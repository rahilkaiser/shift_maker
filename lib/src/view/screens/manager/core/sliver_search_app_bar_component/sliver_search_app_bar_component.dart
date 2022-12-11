import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SliverSearchAppBar extends StatelessWidget {
  final String hintText;

  const SliverSearchAppBar({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  static const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return SliverAppBar(
      // pinned: true,
      snap: true,
      floating: true,
      centerTitle: true,
      title: Container(
        decoration: BoxDecoration(
          color: themeData.colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  errorBorder: outlineInputBorder,
                  hintText: this.hintText,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: themeData.colorScheme.inversePrimary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    )),
                child: SvgPicture.asset(
                  "assets/images/filter.svg",
                  color: themeData.colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
      // flexibleSpace: Placeholder(),
      expandedHeight: 70,
    );
  }
}
