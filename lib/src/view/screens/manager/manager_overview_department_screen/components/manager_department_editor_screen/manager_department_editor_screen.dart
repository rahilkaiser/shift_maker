import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../../../domain/entities/department/department_entity.dart';
import '../../../../../routes/router.gr.dart';
import '../../../../components/continue_button_component/continue_button_component.dart';
import 'components/manager__adress_map_screen.dart';

class ManagerDepartmentEditorScreen extends StatefulWidget {
  final DepartmentEntity? departmentEntity;

  const ManagerDepartmentEditorScreen({
    Key? key,
    required this.departmentEntity,
  }) : super(key: key);

  @override
  State<ManagerDepartmentEditorScreen> createState() => _ManagerDepartmentEditorScreenState();
}

class _ManagerDepartmentEditorScreenState extends State<ManagerDepartmentEditorScreen> {
  final GlobalKey<AnimatedListState> animaListKey = GlobalKey<AnimatedListState>();

  List<File> imgFileList = [];
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  double currentIndex = 0;

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  bool fromDateSelected = false;
  bool untilDateSelected = false;
  DateTime fromDate = DateTime.now();
  DateTime? untilDate;
  late TextEditingController fromDateController;
  late TextEditingController untilDateController;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        currentIndex = _controller.page!;
      });
    });

    this.animaListKey.currentState?.insertItem(0);
    this.titleController = TextEditingController(text: widget.departmentEntity?.label ?? "");
    this.descriptionController = TextEditingController(text: widget.departmentEntity?.description ?? "");

    this.fromDateController = TextEditingController(text: this.getFromDateTextValue());
    this.untilDateController = TextEditingController(text: this.getUntilDateTextValue());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: CoreSpacingConstants.getCoreBodyContentPaddingHorizontal(size),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: size.width,
                height: size.width / 2,
                child: PageView.builder(
                  controller: this._controller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: this.imgFileList.length + 1,
                  itemBuilder: (context, index) {
                    return index < this.imgFileList.length
                        ? Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: DottedBorder(
                                color: themeData.colorScheme.secondary,
                                strokeWidth: 2,
                                dashPattern: const [8, 4],
                                child: InkWell(
                                  onTap: () async {
                                    showDialog(
                                      builder: (context) {
                                        return BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                          child: PageView.builder(
                                            pageSnapping: true,
                                            itemCount: this.imgFileList.length,
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
                                                      child: Image.file(
                                                        this.imgFileList[index],
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      child: Row(
                                                        children: const [
                                                          Text("Entfernen"),
                                                          Icon(Icons.delete),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      context: context,
                                    );
                                  },
                                  child: SizedBox(
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                    child: Image.file(
                                      this.imgFileList[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: DottedBorder(
                                color: themeData.colorScheme.secondary,
                                strokeWidth: 2,
                                dashPattern: const [8, 4],
                                child: InkWell(
                                  onTap: () async {
                                    await this._showImageSelectionChoiceDialog(context);
                                  },
                                  child: SizedBox(
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.upload,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("Upload your images"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
              SizedBox(
                // width: size.width,
                height: size.width / 5.5,
                child: buildAnimatedList(size, themeData),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Titel",
                  helperText: "Geben Sie hier einen Titel ein",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                minLines: 3,
                maxLines: 8,
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Beschreibung",
                  helperText: "Geben Sie hier eine Beschreibung ein",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Objekt-Zeitraum festlegen",
                    style: themeData.textTheme.headline6,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            DateTime? newFromDate = await showDatePicker(
                              locale: Locale("de"),
                              context: context,
                              initialDate: this.fromDate,
                              firstDate: DateTime.now(),
                              lastDate: this.untilDate ?? DateTime(2300),
                            );
                            if (newFromDate == null) return;

                            setState(() {
                              fromDateSelected = true;
                              this.fromDate = newFromDate;
                              this.fromDateController.text = this.getFromDateTextValue();
                            });
                          },
                          child: TextField(
                            controller: this.fromDateController,
                            textAlign: TextAlign.center,
                            autofocus: true,
                            focusNode: FocusNode(),
                            enabled: false,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: themeData.colorScheme.primary),
                              labelText: "Beginn",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            DateTime? newUntilDate = await showDatePicker(
                              locale: Locale("de"),
                              context: context,
                              initialDate: this.fromDate,
                              firstDate: this.fromDate,
                              lastDate: DateTime(2300),
                            );
                            if (newUntilDate == null) return;

                            setState(() {
                              this.untilDateSelected = true;
                              this.untilDate = newUntilDate;
                              this.untilDateController.text = this.getUntilDateTextValue();
                            });
                          },
                          child: TextField(
                            controller: untilDateController,
                            textAlign: TextAlign.center,
                            autofocus: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: themeData.colorScheme.primary),
                              labelText: "Ende",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Adresse festlegen",
                    style: themeData.textTheme.headline6,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  InkWell(
                    onTap: () {
                      //TODO: dialog mit Adresse-auswahl
                      AutoRouter.of(context).push(const ManagerAdressMapRoute());
                    },
                    child: TextField(
                      enabled: false,
                      controller: titleController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_right,
                          color: themeData.colorScheme.primary,
                        ),
                        labelText: "Adresse",
                        labelStyle: TextStyle(color: themeData.colorScheme.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              ContinueButtonComponent(
                onPressed: () {},
                text: "Speichern",
                showSpinner: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFromDateTextValue() {
    return fromDateSelected ? '${fromDate.day}.${fromDate.month}.${fromDate.year}' : "Beliebig";
  }

  String getUntilDateTextValue() {
    return untilDateSelected && untilDate != null ? '${untilDate?.day}.${untilDate?.month}.${untilDate?.year}' : "Beliebig";
  }

  _openGallery() async {
    try {
      List<PickedFile>? pics = (await ImagePicker.platform.pickMultiImage());
      if (pics == null) {
        return;
      }
      var files = pics.map((PickedFile pic) {
        return File(pic.path);
      }).toList();

      int lastIndex = imgFileList.length;
      setState(() {
        imgFileList.insertAll(lastIndex, files);
      });
      for (int offset = 0; offset < files.length; offset++) {
        print(imgFileList[offset]);
        animaListKey.currentState?.insertItem(lastIndex + offset);
      }
    } on PlatformException catch (e) {
      Navigator.of(context).pop();
    }
  }

  _openCamera() async {
    try {
      PickedFile? pic = (await ImagePicker.platform.pickImage(source: ImageSource.camera));
      if (pic == null) {
        return;
      }
      var file = File(pic.path);

      int lastIndex = imgFileList.length;
      setState(() {
        imgFileList.insert(lastIndex, file);
      });
      animaListKey.currentState?.insertItem(lastIndex);
    } on PlatformException catch (e) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _showImageSelectionChoiceDialog(BuildContext context) {
    FocusScope.of(context).unfocus();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    onPressed: () {
                      this._openGallery();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.image_search),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Select from galery"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    onPressed: () {
                      this._openCamera();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.camera_alt_outlined),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Take Photo"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AnimatedList buildAnimatedList(Size size, ThemeData themeData) {
    return AnimatedList(
      scrollDirection: Axis.horizontal,
      key: this.animaListKey,
      shrinkWrap: true,
      initialItemCount: this.imgFileList.length + 1,
      itemBuilder: (context, index, animation) {
        if (index == this.imgFileList.length) {
          return SizedBox(
            width: size.width / 5.5,
            height: size.width / 5.5,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  color: themeData.colorScheme.secondary.withOpacity(0.8),
                  strokeWidth: 2,
                  dashPattern: const [8, 4],
                  child: InkWell(
                    onTap: () async {
                      this._showImageSelectionChoiceDialog(context);
                    },
                    child: const SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return SizeTransition(
          axis: Axis.horizontal,
          sizeFactor: animation,
          child: SizedBox(
            width: size.width / 5.5,
            height: size.width / 5.5,
            child: Stack(
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: AnimatedSwitcher(
                      key: ValueKey(this.imgFileList[index]),
                      duration: const Duration(milliseconds: 500),
                      child: this.currentIndex == index
                          ? InkWell(
                              onTap: () async {
                                this._controller.animateToPage(index, curve: Curves.easeIn, duration: const Duration(milliseconds: 100));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(width: 2, color: themeData.colorScheme.primary)),
                                height: double.maxFinite,
                                width: double.maxFinite,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      this.imgFileList[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              color: themeData.colorScheme.secondary.withOpacity(0.8),
                              strokeWidth: 2,
                              dashPattern: const [8, 4],
                              child: InkWell(
                                onTap: () async {
                                  this._controller.animateToPage(index, curve: Curves.easeIn, duration: const Duration(milliseconds: 100));
                                },
                                child: SizedBox(
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      this.imgFileList[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  top: -14,
                  right: -20,
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: themeData.colorScheme.inverseSurface),
                    onPressed: () {
                      setState(() {
                        this.removeItem(index);
                      });
                    },
                    child: const Icon(Icons.highlight_remove),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void removeItem(int index) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    final item = this.imgFileList[index];
    setState(() {
      this.imgFileList.removeAt(index);
    });
    this.animaListKey.currentState?.removeItem(
      duration: Duration(milliseconds: 400),
      index,
      (context, animation) {
        return ScaleTransition(
          key: ValueKey(item),
          scale: animation,
          child: SizedBox(
            width: size.width / 5.5,
            height: size.width / 5.5,
            child: Stack(
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      color: themeData.colorScheme.secondary.withOpacity(0.8),
                      strokeWidth: 2,
                      dashPattern: const [8, 4],
                      child: SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            item,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
