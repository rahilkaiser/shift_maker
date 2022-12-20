import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../../application/core/is_editable_bloc/is_editable_bloc.dart';
import '../../../../../application/departments/selected_department_bloc/selected_department_bloc.dart';
import '../../../../../domain/entities/department/department_entity.dart';
import '../../../../routes/router.gr.dart';

class ManagerDepartmentCardComponent extends StatelessWidget {
  final DepartmentEntity department;

  const ManagerDepartmentCardComponent({
    required this.department,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        DepartmentEntity depart = this.department;

        context.read<SelectedDepartmentBloc>().add(
              SelectedDepartmentEvent.selectDepartmentEntityEvent(
                departmentEntity: depart,
              ),
            );

        AutoRouter.of(context).push(ManagerDepartmentDetailsRoute(departmentEntity: depart)).then(
          (value) {
            context.read<IsEditableBloc>().add(ChangeToIsNotEditableEvent());
            context.read<SelectedDepartmentBloc>().add(
                  const SelectedDepartmentEvent.unselectDepartmentEntityEvent(),
                );
          },
        );
      },
      child: Align(
        child: Container(
          height: 300,
          child: Card(
            elevation: 4,
            borderOnForeground: false,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        const Center(child: CircularProgressIndicator()),
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          child: FadeInImage.memoryNetwork(
                            fadeInDuration: const Duration(milliseconds: 200),
                            image: department.images.isNotEmpty
                                ? department.images[0]
                                : "https://firebasestorage.googleapis.com/v0/b/shiftmaker-d0904.appspot.com/o/VinceTest.jpg?alt=media&token=dd081341-2fec-4dd8-afdc-1b699b8481fd",
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Label
                  Flexible(
                    // color: Colors.purple,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                              text: "${this.department.label}",
                              style: themeData.textTheme.headline5?.copyWith(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text:
                                  "${this.department.description} Lorem ipsum dolor sit amet, consectetur adipisici elit, …“ ist ein Blindtext, der nichts bedeuten soll, sondern als Platzhalter im Layout verwendet wird, um einen Eindruck vom fertigen Dokument zu erhalten. Wikipedia",
                              style: themeData.textTheme.headline5?.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: "Beginn:  03.07.2022",
                                            style: themeData.textTheme.headline5?.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "Ende:      03.08.2023",
                                            style: themeData.textTheme.headline5?.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          Icons.people,
                                          size: 19,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "2 / 12",
                                            style: themeData.textTheme.headline5?.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        const Icon(
                                          Icons.accessibility,
                                          size: 19,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "2",
                                            style: themeData.textTheme.headline5?.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
