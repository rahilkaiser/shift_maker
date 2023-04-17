import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:intl/intl.dart';

import '../../../../../../application/workers/worker_controller_bloc/worker_controller_bloc.dart';
import '../../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../../../domain/entities/user/user_role.dart';
import '../../../../../../domain/entities/users/worker/worker_entity.dart';
import '../../../../../../injection.dart';
import '../../../../components/continue_button_component/continue_button_component.dart';

class ManagerWorkerEditorScreen extends StatefulWidget {
  final WorkerEntity? worker;

  const ManagerWorkerEditorScreen({Key? key, required this.worker}) : super(key: key);

  @override
  State<ManagerWorkerEditorScreen> createState() => _ManagerWorkerEditorScreenState();
}

class _ManagerWorkerEditorScreenState extends State<ManagerWorkerEditorScreen> {
  File? profileImgFile;
  File? initialImgFile;

  late TextEditingController forenameController;
  late TextEditingController surnameController;
  late TextEditingController descriptionController;
  late TextEditingController preferenceController;

  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController workDaysPerMonthCapController;

  late TextEditingController fromDateController;
  late TextEditingController untilDateController;
  late TextEditingController birthDateController;

  DateTime? fromDate = DateTime.now();
  DateTime? untilDate;

  bool fromDateSelected = true;
  bool untilDateSelected = false;

  String initialCountry = 'DE';
  PhoneNumber currentPhone = PhoneNumber(isoCode: 'DE');

  DateTime? birthDate;

  @override
  void initState() {
    if (widget.worker != null) {
      if (widget.worker?.createdAt != null) {
        this.fromDate = widget.worker?.createdAt;
        this.fromDateSelected = true;
      }

      if (widget.worker?.birthDate != null) {
        this.birthDate = widget.worker?.birthDate;
      }
    }
    setState(() {
      this.fromDateController = TextEditingController(text: this.getFromDateTextValue());
      this.untilDateController = TextEditingController(text: this.getUntilDateTextValue());
      this.birthDateController = TextEditingController(text: this.getBirthDateTextValue());
    });

    // if (widget.worker?.end != null) {
    //   this.untilDate = widget.worker?.end;
    //   this.untilDateSelected = true;
    // }

    this.forenameController = TextEditingController(text: widget.worker?.forename ?? "");
    this.surnameController = TextEditingController(text: widget.worker?.surname ?? "");
    this.preferenceController = TextEditingController(text: widget.worker?.preference ?? "");
    this.descriptionController = TextEditingController(text: widget.worker?.description ?? "");
    this.emailController = TextEditingController(text: widget.worker?.email ?? "");
    this.workDaysPerMonthCapController = TextEditingController(text: widget.worker?.maxWorkDays.toString() ?? "0");

    this.phoneNumberController = TextEditingController(text: "");

    if (widget.worker != null) {
      this._setUpPhone();
      this._downloadAndLoadImagesFromCache();
    }

    super.initState();
  }

  String getFromDateTextValue() {
    return fromDateSelected ? DateFormat('dd.MM.yyyy').format(this.fromDate!).toString() : "Beliebig";
  }

  String getUntilDateTextValue() {
    return untilDateSelected && this.untilDate != null ? DateFormat('dd.MM.yyyy').format(this.untilDate!).toString() : "Beliebig";
  }

  String getBirthDateTextValue() {
    return this.birthDate != null ? DateFormat('dd.MM.yyyy').format(this.birthDate!).toString() : "";
  }

  _setUpPhone() async {
    this.currentPhone = (await PhoneNumber.getRegionInfoFromPhoneNumber(widget.worker?.phone ?? ""));
    setState(() {
      this.phoneNumberController.text = this.currentPhone.parseNumber();
    });
  }

  @override
  void dispose() {
    DefaultCacheManager().emptyCache();
    super.dispose();
  }

  _downloadAndLoadImagesFromCache() async {
    if (widget.worker != null && widget.worker?.profileImage != null) {
      File? loadedFile = null;
      loadedFile = await DefaultCacheManager().getSingleFile(widget.worker?.profileImage as String);
      setState(() {
        this.profileImgFile = loadedFile;
      });
      this.initialImgFile = loadedFile;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider<WorkerControllerBloc>(
        create: (context) => serviceLocator<WorkerControllerBloc>(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocConsumer<WorkerControllerBloc, WorkerControllerState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
                padding: CoreSpacingConstants.getCoreBodyContentPaddingHorizontal(size),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: this.profileImgFile != null
                                      ? GestureDetector(
                                          key: ValueKey(this.profileImgFile),
                                          onTap: () async {
                                            FocusScope.of(context).unfocus();
                                            await this._cropImage(context);
                                          },
                                          child: Image.file(
                                            width: 115,
                                            height: 115,
                                            this.profileImgFile!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Icon(Icons.account_circle_rounded, size: 115, color: themeData.colorScheme.secondary),
                                )),
                            if (this.profileImgFile != null && this.profileImgFile != this.initialImgFile) ...[
                              Positioned(
                                right: -10,
                                top: -5,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      this.profileImgFile = this.initialImgFile;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      child: Icon(Icons.highlight_off_outlined, size: 32, color: themeData.colorScheme.error),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            Positioned(
                              right: -10,
                              bottom: -10,
                              child: GestureDetector(
                                onTap: () async => await this._showImageSelectionChoiceDialog(context),
                                child: SizedBox(
                                  height: 49,
                                  width: 49,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          side: BorderSide(color: themeData.colorScheme.inverseSurface),
                                        ),
                                        backgroundColor: themeData.dialogBackgroundColor.withOpacity(1)),
                                    onPressed: () async => await this._showImageSelectionChoiceDialog(context),
                                    child: const Icon(Icons.camera_alt),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                    CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: this.forenameController,
                            decoration: InputDecoration(
                              labelText: "Vorname",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: this.surnameController,
                            decoration: InputDecoration(
                              labelText: "Nachname",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                    TextField(
                      minLines: 3,
                      maxLines: 8,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: "Beschreibung",
                        helperText: "Beschreibung oder allg. Notiz zum Personal",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                    InkWell(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        DateTime? newBirtDate = await showDatePicker(
                          locale: const Locale("de"),
                          context: context,
                          initialDate: this.birthDate ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (newBirtDate == null) return;

                        setState(() {
                          this.birthDate = newBirtDate;
                          this.birthDateController.text = this.getBirthDateTextValue();
                        });
                      },
                      child: TextField(
                        controller: this.birthDateController,
                        autofocus: true,
                        focusNode: FocusNode(),
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Geburtsdatum",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kontaktdaten festlegen",
                          style: themeData.textTheme.headline6,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        TextField(
                          controller: this.emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber newPhoneNumber) {
                            this.currentPhone = newPhoneNumber;
                          },
                          locale: 'de',
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          textFieldController: this.phoneNumberController,
                          formatInput: false,
                          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                          initialValue: this.currentPhone,
                          selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              setSelectorButtonAsPrefixIcon: false,
                              leadingPadding: 10,
                              useEmoji: true),
                          autoFocusSearch: true,
                          searchBoxDecoration: InputDecoration(
                            labelText: "Suche nach Landnamen oder Vorwahlziffer",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          inputDecoration: InputDecoration(
                            labelText: "Telefonnummer",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Einplanungsdaten festlegen",
                          style: themeData.textTheme.headline6,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        TextField(
                          controller: this.preferenceController,
                          decoration: InputDecoration(
                            labelText: "Präferenz",
                            helperText: "Notiz über die Schichtauswahl",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                        TextField(
                          controller: this.workDaysPerMonthCapController,
                          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                          decoration: InputDecoration(
                            labelText: "Einsatztagelimit",
                            helperText: "Maximale Einsatztage im Monat",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nutzer-Zeitraum festlegen",
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
                                  FocusScope.of(context).unfocus();
                                  DateTime? newFromDate = await showDatePicker(
                                    locale: const Locale("de"),
                                    context: context,
                                    initialDate: this.fromDate ?? DateTime.now(),
                                    firstDate: DateTime(1900),
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
                                    labelText: "Erstellt am",
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
                                  FocusScope.of(context).unfocus();
                                  DateTime? newUntilDate = await showDatePicker(
                                    locale: Locale("de"),
                                    context: context,
                                    initialDate: this.untilDate ?? this.fromDate!,
                                    firstDate: this.fromDate!,
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
                                    labelText: "Gültig bis",
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
                    CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                    const SizedBox(
                      height: 25,
                    ),
                    ContinueButtonComponent(
                      onPressed: () {
                        if (widget.worker == null) {
                          // Register that user in Auth
                          WorkerEntity worker = WorkerEntity.empty().copyWith(
                            forename: this.forenameController.text,
                            surname: this.surnameController.text,
                            description: this.descriptionController.text,
                            role: UserRole.WORKER,
                            birthDate: this.birthDate,
                            email: this.emailController.text,
                            phoneNumber: this.currentPhone.phoneNumber,
                            preference: this.preferenceController.text,
                            maxWorkDays: int.parse(this.workDaysPerMonthCapController.text),
                            createdAt: this.fromDate,
                            validUntil: this.untilDate,
                          );

                          BlocProvider.of<WorkerControllerBloc>(context).add(WorkerControllerEvent.createWorker(workerEntity: worker, profileImage: this.profileImgFile));
                        }
                      },
                      text: "Speichern",
                      showSpinner: state.isLoading,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage(BuildContext context) async {
    ThemeData themeData = Theme.of(context);

    CroppedFile? cropped = await ImageCropper().cropImage(sourcePath: this.profileImgFile?.path as String, uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Bild bearbeiten',
          statusBarColor: themeData.colorScheme.inversePrimary,
          activeControlsWidgetColor: themeData.colorScheme.primary,
          backgroundColor: themeData.colorScheme.surface,
          toolbarColor: themeData.colorScheme.surface,
          toolbarWidgetColor: themeData.colorScheme.secondary,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    ]);

    if (cropped != null) {
      setState(() {
        this.profileImgFile = File(cropped.path);
      });
    }
  }

  _openGallery() async {
    try {
      PickedFile? pic = (await ImagePicker.platform.pickImage(source: ImageSource.gallery));
      if (pic == null) {
        return;
      }
      setState(() {
        this.profileImgFile = File(pic.path);
      });
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
      setState(() {
        this.profileImgFile = File(pic.path);
      });
    } on PlatformException catch (e) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _showImageSelectionChoiceDialog(BuildContext context) async {
    FocusScope.of(context).unfocus();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
}
