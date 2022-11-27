import 'package:flutter/material.dart';

class ContinueButtonComponent extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool showSpinner;

  const ContinueButtonComponent(
      {Key? key, required this.text, required this.onPressed, required this.showSpinner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? size.height * 0.08
          : size.height * 0.18,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: this.onPressed,
        child: showSpinner
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                this.text,
                style: themeData.textTheme.headline1!.copyWith(fontSize: 22),
              ),
      ),
    );
  }

  static void showButtonPressDialogForInvalidInputs(BuildContext context, String innerText, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color ?? Colors.redAccent,
      content: Text(innerText),
      duration: const Duration(milliseconds: 600),
    ));
  }
}
