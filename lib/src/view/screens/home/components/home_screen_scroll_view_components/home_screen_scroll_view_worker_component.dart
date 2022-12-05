import 'package:flutter/material.dart';

import '../../../../../domain/entities/users/worker/worker_entity.dart';
import 'home_screen_scroll_view_manager_component.dart';

class HomeScreenScrollViewWorkerComponent extends StatelessWidget {
  const HomeScreenScrollViewWorkerComponent({
    Key? key,
    required this.uEntity,
  }) : super(key: key);

  final WorkerEntity uEntity;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        //APPBAR
        StickySliverAppBarComponent(text: "${uEntity.forename} ${uEntity.surname}"),

        //LIST
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.red,
                  width: 50,
                  height: 50,
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ),
          addAutomaticKeepAlives: false,
          childCount: 1,
        )),
      ],
    );
  }
}
