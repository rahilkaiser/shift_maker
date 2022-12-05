import 'package:flutter/material.dart';

import '../../../../../core/theme/sizefit/core_spacing_constants.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final Icon icon;
  final String text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final themeData = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

        ),
        onPressed: press,
        child: Row(
          children: [
            this.icon,
            const SizedBox(width: 20),
            Expanded(child: Text(this.text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
