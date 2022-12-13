import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../../application/core/is_editable_bloc/is_editable_bloc.dart';
import '../../../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../../../../domain/entities/department/department_entity.dart';
import '../../../../../components/continue_button_component/continue_button_component.dart';

class ManagerEditDepartmentScreenBody extends StatefulWidget {
  final DepartmentEntity departmentEntity;

  const ManagerEditDepartmentScreenBody({Key? key, required this.departmentEntity}) : super(key: key);

  @override
  State<ManagerEditDepartmentScreenBody> createState() => _ManagerEditDepartmentScreenBodyState();
}

class _ManagerEditDepartmentScreenBodyState extends State<ManagerEditDepartmentScreenBody> {
  int currentPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    context.read<IsEditableBloc>().add(ChangeToIsEditableEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    List<String> images = [
      "assets/images/bgTest.jpg",
      "assets/images/bgTest.jpg",
      "assets/images/bgTest.jpg",
      "assets/images/bgTest.jpg",
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: CoreSpacingConstants.getCoreBodyContentPaddingHorizontal(size),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              height: size.height / 3.5,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    this.currentPageIndex = value;
                  });
                },
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showDialog(
                          builder: (context) {
                            return PageView.builder(
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          images[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          context: context,
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: AnimatedSmoothIndicator(
                activeIndex: this.currentPageIndex,
                count: images.length,
                effect: ScrollingDotsEffect(
                  activeDotColor: themeData.colorScheme.inversePrimary,
                  dotColor: themeData.colorScheme.onBackground.withOpacity(0.6),
                  dotHeight: 5,
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(
                text: widget.departmentEntity.label,
                style: themeData.textTheme.headline5?.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            RichText(
              softWrap: true,
              text: TextSpan(
                text:
                    "${widget.departmentEntity.description} Lorem ipsum dolor sit amet, consectetur adipisici elit, …“ ist ein Blindtext, der nichts bedeuten soll, sondern als Platzhalter im Layout verwendet wird, um einen Eindruck vom fertigen Dokument zu erhalten. Wikipedia",
                style: themeData.textTheme.headline5?.copyWith(
                  fontSize: 13,
                  color: themeData.hintColor.withOpacity(0.9),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.timelapse_outlined,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        text: "Beginn",
                        style: themeData.textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        text: "19.03.2022",
                        style: TextStyle(
                          fontSize: 15,
                          color: themeData.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        text: "Ende",
                        style: themeData.textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        text: "19.09.2022",
                        style: TextStyle(
                          fontSize: 15,
                          color: themeData.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.location_on_outlined, size: 15),
                const SizedBox(width: 1),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(
                    text: "Prinz-Heinrich-Straße 7A , 12307 Berlin",
                    style: themeData.textTheme.headline5?.copyWith(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
                IconButton(
                  // color: themeData.colorScheme.primary,
                  onPressed: () => MapsLauncher.launchQuery('Prinz-Heinrich-Straße 7A, Berlin, 12307, Deutschland'),
                  icon: Icon(
                    Icons.gps_fixed_sharp,
                    color: themeData.colorScheme.primary,
                  ),
                )
              ],
            ),
            // WorkersAmountCardComponent(themeData: themeData),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            //DIENSTPLAN
            GestureDetector(
              onTap: () {
                //TODO: Dienstplan
                print("Diensplab");
              },
              child: SizedBox(
                width: double.maxFinite,
                // height: 100,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nächste Schicht :',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: themeData.colorScheme.secondary),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Samstag',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.lightGreen,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '19.03.2022',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  // color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '16:00 - 4:00',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: themeData.colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.calendar_month),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Dienstplan ansehen"),
                                ],
                              ),
                              Icon(Icons.keyboard_arrow_right)
                            ],
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                //TODO: Dienstplan
                print("Dienstanweisung");
              },
              child: SizedBox(
                width: double.maxFinite,
                // height: 100,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.picture_as_pdf),
                              SizedBox(
                                width: 8,
                              ),
                              Text("Dienstanweisung ansehen"),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                //TODO: Dienstplan
                print("Dienstanweisung");
              },
              child: SizedBox(
                width: double.maxFinite,
                // height: 100,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.inventory_outlined),
                              SizedBox(
                                width: 8,
                              ),
                              Text("Login-Logout Historie ansehen"),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                //TODO: Dienstplan
                print("Dienstanweisung");
              },
              child: SizedBox(
                width: double.maxFinite,
                // height: 100,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.archive),
                              SizedBox(
                                width: 8,
                              ),
                              Text("Sonstige Dokumente"),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),

// ASSIGNED WORKER
            SizedBox(
              height: 18,
            ),
            // Divider(),
            GestureDetector(
              onTap: () {
                //TODO: PUSH Assigned Workerslist
                print("assigned workerlist");
              },
              child: SizedBox(
                width: double.maxFinite,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Eingesetztes Personal",
                              style: themeData.textTheme.headline5?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.people),
                                const SizedBox(width: 5),
                                RichText(
                                  text: TextSpan(
                                    text: "18/22",
                                    style: themeData.textTheme.bodyText2?.copyWith(
                                        // fontSize: 18,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.chevron_right,
                            color: themeData.colorScheme.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
// Springer
            GestureDetector(
              onTap: () {
                //TODO: PUSH Springerliste
                print("Springerliste");
              },
              child: SizedBox(
                width: double.maxFinite,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Springer",
                              style: themeData.textTheme.headline5?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.accessibility),
                                const SizedBox(width: 5),
                                RichText(
                                  text: TextSpan(
                                    text: "5/5",
                                    style: themeData.textTheme.bodyText2?.copyWith(
                                        // fontSize: 18,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.chevron_right,
                            color: themeData.colorScheme.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
// LOGIN
            GestureDetector(
              onTap: () {
                //TODO: PUSH actuell eingeloggte
                print("current loged in");
              },
              child: SizedBox(
                width: double.maxFinite,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Aktuell eingeloggtes Personal",
                              style: themeData.textTheme.headline5?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.catching_pokemon,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 5),
                                RichText(
                                  text: TextSpan(
                                    text: "10/10",
                                    style: themeData.textTheme.bodyText2?.copyWith(
                                        // fontSize: 18,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.chevron_right,
                            color: themeData.colorScheme.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 38,
            ),
            ContinueButtonComponent(
              onPressed: () {},
              showSpinner: false,
              text: "NFC verwalten",
            ),
            const SizedBox(
              height: 38,
            ),
            ContinueButtonComponent(
              onPressed: () {},
              showSpinner: false,
              text: "Objekt löschen",
              colorOverWrite: themeData.colorScheme.error,
              textColorOverWrite: themeData.colorScheme.onError,
            ),
          ],
        ),
      ),
    );
  }
}
