import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/core/is_editable_bloc/is_editable_bloc.dart';
import '../../../../../application/workers/selected_worker_bloc/selected_worker_bloc.dart';
import '../../../../../application/workers/worker_observer_bloc/worker_observer_bloc.dart';
import '../../../../../application/workers/worker_observer_bloc/worker_observer_bloc.dart';
import '../../../../../domain/entities/users/worker/worker_entity.dart';
import 'package:intl/intl.dart';
import '../../../../routes/router.gr.dart';
import '../../core/sliver_search_app_bar_component/sliver_search_app_bar_component.dart';

class ManagerOverviewWorkerScreenBody extends StatelessWidget {
  const ManagerOverviewWorkerScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        const SliverSearchAppBar(hintText: "Suche Personal"),
        BlocBuilder<WorkerObserverBloc, WorkerObserverState>(
          builder: (context, state) {
            if (state is WorkerObserverSuccessState) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.workerEntities.length,
                  (context, index) => InkWell(
                    onTap: () {
                      context.read<SelectedWorkerBloc>().add(
                            SelectedWorkerEvent.selectWorkerEntityEvent(
                              workerEntity: state.workerEntities[index],
                            ),
                          );
                      AutoRouter.of(context).push(ManagerWorkerDetailsRoute(worker: state.workerEntities[index])).then(
                        (value) {
                          context.read<IsEditableBloc>().add(ChangeWorkerToIsNotEditableEvent());
                          context.read<SelectedWorkerBloc>().add(const SelectedWorkerEvent.unselectWorkerEntityEvent());
                        },
                      );
                    },
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: CachedNetworkImage(
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          imageUrl:
                              "https://firebasestorage.googleapis.com/v0/b/shiftmaker-d0904.appspot.com/o/CiIpp7BPk3Z36iIFwpk3zTnwm813%2Fdepartments%2Fa56fa930-855b-11ed-b6db-51b88687fc5a%2Fimage_picker2152901276822235240.jpg?alt=media&token=143d69c7-8ac9-414c-82e0-0820488c6c40",
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      title: Text("${state.workerEntities[index].forename} ${state.workerEntities[index].surname}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      text: TextSpan(
                                        text: state.workerEntities[index] != null
                                            ? DateFormat('dd.MM.yyyy').format(state.workerEntities[index].createdAt!).toString()
                                            : "-",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: themeData.colorScheme.secondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  text: TextSpan(
                                    text: "bis",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: themeData.colorScheme.secondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      text: TextSpan(
                                        text: state.workerEntities[index] != null
                                            ? DateFormat('dd.MM.yyyy').format(state.workerEntities[index].createdAt!).toString()
                                            : "-",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: themeData.colorScheme.secondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text("Tagschicht"),
                        ],
                      ),
                      trailing: RichText(
                        text: TextSpan(
                            text: "23",
                            style: themeData.textTheme.bodyText2?.copyWith(color: Colors.green, fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(text: "/27", style: themeData.textTheme.bodyText2),
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is WorkerObserverInitialState) {
              const SliverFillRemaining();
            } else if (state is WorkerObserverLoadingState) {
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: themeData.colorScheme.secondary,
                  ),
                ),
              );
            } else if (state is WorkerObserverFailureState) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    state.toString(),
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: themeData.errorColor,
                        ),
                  ),
                ),
              );
            }

            return const SliverFillRemaining();
          },
        )
      ],
    );
  }
}
