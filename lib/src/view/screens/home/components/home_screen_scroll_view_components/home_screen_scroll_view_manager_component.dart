import 'package:flutter/material.dart';

import '../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../../domain/entities/users/manager/manager_entity.dart';

class HomeScreenScrollViewManagerComponent extends StatelessWidget {
  const HomeScreenScrollViewManagerComponent({
    Key? key,
    required this.uEntity,
  }) : super(key: key);

  final ManagerEntity uEntity;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        //APPBAR
        StickySliverAppBarComponent(text: uEntity.name),
        //LIST
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
            child: Card(
              color: Colors.red,
              child: Center(
                child: Text("Meldungen"),
              ),
            ),
          ),
          addAutomaticKeepAlives: false,
          childCount: 1,
        )),
      ],
    );
  }
}

// child: GridView.builder(
//   scrollDirection: Axis.vertical,
//   shrinkWrap: true,
//   physics: NeverScrollableScrollPhysics(),
//   itemCount: 1,
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//   itemBuilder: (context, index) {
//     return Container(
//       color: Colors.red,
//       padding: const EdgeInsets.all(8.0),
//       child: const GridTile(
//         header: Text("Meldungen"),
//         child: Center(child: Text("CENTER")),
//       ),
//     );
//   },
// ),

// ListView.separated(
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: 10,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   color: Colors.red,
//                   width: 50,
//                   height: 50,
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) => const Divider(),
//             ),

class StickySliverAppBarComponent extends StatelessWidget {
  final String text;

  const StickySliverAppBarComponent({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // expandedHeight: 43,
      floating: true,
      pinned: true,
      snap: true,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Card(
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
