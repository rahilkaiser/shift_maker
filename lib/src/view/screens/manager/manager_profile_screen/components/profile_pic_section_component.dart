import 'package:flutter/material.dart';

class ProfilePicSectionComponent extends StatelessWidget {
  const ProfilePicSectionComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: themeData.canvasColor,
            backgroundImage: const AssetImage("assets/images/flutter_logo.png"),
          ),
          Positioned(
            right: -10,
            bottom: -10,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: Colors.white),
                    ),
                    backgroundColor: themeData.dialogBackgroundColor.withOpacity(1)),
                onPressed: () {},
                child: const Icon(Icons.camera_alt),
              ),
            ),
          )
        ],
      ),
    );
  }
}
