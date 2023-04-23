import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../application/core/is_editable_bloc/is_editable_bloc.dart';
import '../../../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../../../../domain/entities/users/worker/worker_entity.dart';
import '../../../../../components/continue_button_component/continue_button_component.dart';
import '../../../../manager_profile_screen/components/profile_pic_section_component.dart';

//Tag oder Nacht
// Urlaubsanträge und Arbeitsunfähigkeiten

class ManagerWorkerDetailsScreenBody extends StatefulWidget {
  final WorkerEntity worker;

  const ManagerWorkerDetailsScreenBody({Key? key, required this.worker}) : super(key: key);

  @override
  State<ManagerWorkerDetailsScreenBody> createState() => _ManagerWorkerDetailsScreenBodyState();
}

class _ManagerWorkerDetailsScreenBodyState extends State<ManagerWorkerDetailsScreenBody> {
  @override
  void initState() {
    context.read<IsEditableBloc>().add(ChangeWorkerToIsEditableEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: CoreSpacingConstants.getCoreBodyContentPaddingHorizontal(size),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    showDialog(
                      builder: (context) {
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
                                child: widget.worker.profileImage != null
                                    ? CachedNetworkImage(
                                        fit: BoxFit.contain,
                                        imageUrl: widget.worker.profileImage!,
                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      )
                                    : Icon(Icons.account_circle_rounded, size: 115, color: themeData.colorScheme.secondary),
                              ),
                            ),
                          ],
                        );
                      },
                      context: context,
                    );
                  },
                  child: widget.worker.profileImage != null
                      ? CachedNetworkImage(
                          width: 115,
                          height: 115,
                          fit: BoxFit.cover,
                          imageUrl: widget.worker.profileImage!,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        )
                      : Icon(Icons.account_circle_rounded, size: 115, color: themeData.colorScheme.secondary),
                ),
              ),
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            Center(
              child: Text(
                "${widget.worker.forename} ${widget.worker.surname}",
                style: themeData.textTheme.headline6?.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            RichText(
              softWrap: true,
              text: TextSpan(
                text: widget.worker.description,
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
                      Icons.schedule_send,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        text: "Eingeplante Tage",
                        style: themeData.textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),
                RichText(
                  text: TextSpan(text: "23", style: themeData.textTheme.bodyText2?.copyWith(color: Colors.green, fontWeight: FontWeight.w500), children: [
                    TextSpan(text: "/27", style: themeData.textTheme.bodyText2),
                  ]),
                ),
              ],
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
                      Icons.info,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        text: "Präferenz",
                        style: themeData.textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(
                    text: "Tagschicht",
                    style: TextStyle(
                      fontSize: 15,
                      color: themeData.colorScheme.secondary,
                    ),
                  ),
                ),
              ],
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
                      Icons.cake,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        text: "Geburtsdatum",
                        style: themeData.textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 5),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(
                    text: widget.worker.birthDate != null ? DateFormat('dd.MM.yyyy').format(widget.worker.birthDate!).toString() : "-",
                    style: TextStyle(
                      fontSize: 15,
                      color: themeData.colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 15,
                            ),
                            const SizedBox(width: 5),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              text: TextSpan(
                                text: "Erstellt am",
                                style: themeData.textTheme.bodyText2?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              text: TextSpan(
                                text: widget.worker.createdAt != null ? DateFormat('dd.MM.yyyy').format(widget.worker.createdAt!).toString() : "-",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: themeData.colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FittedBox(
                      child: Row(
                        children: [
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            text: TextSpan(
                              text: "Gültig bis",
                              style: themeData.textTheme.bodyText2?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            text: TextSpan(
                              text: widget.worker.createdAt != null ? DateFormat('dd.MM.yyyy').format(widget.worker.createdAt!).toString() : "-",
                              style: TextStyle(
                                fontSize: 13,
                                color: themeData.colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.numbers, size: 15),
                      const SizedBox(width: 8),
                      InkWell(
                        onLongPress: () {
                          Clipboard.setData(ClipboardData(text: widget.worker.phoneNumber));
                        },
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                            text: widget.worker.phoneNumber,
                            style: themeData.textTheme.headline5?.copyWith(fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  // color: themeData.colorScheme.primary,
                  onPressed: () {
                    launchUrl(
                      Uri(scheme: 'tel', path: widget.worker.phoneNumber),
                    );
                  },
                  icon: Icon(
                    Icons.phone,
                    color: themeData.colorScheme.primary,
                  ),
                ),
                IconButton(
                  // color: themeData.colorScheme.primary,
                  onPressed: () {
                    launchUrl(
                      Uri.parse("https://wa.me/${widget.worker.phoneNumber}?text="),
                      mode: LaunchMode.externalApplication,
                    );
                    // lau
                    //
                  },
                  icon: Icon(
                    Icons.whatsapp_outlined,
                    color: themeData.colorScheme.primary,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.alternate_email, size: 15),
                      const SizedBox(width: 8),
                      InkWell(
                        onLongPress: () {
                          Clipboard.setData(ClipboardData(text: widget.worker.email));
                        },
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                            text: widget.worker.email,
                            style: themeData.textTheme.headline5?.copyWith(fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  // color: themeData.colorScheme.primary,
                  onPressed: () {
                    launchUrl(
                      Uri(scheme: 'mailto', path: widget.worker.email),
                    );
                  },
                  icon: Icon(
                    Icons.mail,
                    color: themeData.colorScheme.primary,
                  ),
                )
              ],
            ),
            Divider(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
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
                          borderRadius: const BorderRadius.all(
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
            GestureDetector(
              onTap: () {
                //TODO: Dienstplan
                print("Urlaubsanträge");
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
                              Icon(Icons.sunny),
                              SizedBox(
                                width: 8,
                              ),
                              Text("Urlaubsanträge"),
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
                print("Arbeitsunfähigkeitsmeldungen");
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
                              Icon(Icons.medical_services_sharp),
                              SizedBox(
                                width: 8,
                              ),
                              Text("Arbeitsunfähigkeitsmeldungen"),
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
                print("Stundennachweise");
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
                              Icon(Icons.list_alt),
                              SizedBox(
                                width: 8,
                              ),
                              Text("Stundennachweise ansehen"),
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
            SizedBox(
              height: 18,
            ),
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
                              "Zugewiesene Objekte",
                              style: themeData.textTheme.headline5?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.home_work_rounded),
                                const SizedBox(width: 5),
                                RichText(
                                  text: TextSpan(
                                    text: "1",
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
              onPressed: () {
                //Personal deaktivieren
              },
              showSpinner: false,
              text: "Personal deaktivieren",
            ),
            const SizedBox(
              height: 38,
            ),
            ContinueButtonComponent(
              onPressed: () {},
              showSpinner: false,
              text: "Personal löschen",
              colorOverWrite: themeData.colorScheme.error,
              textColorOverWrite: themeData.colorScheme.onError,
            ),
            const SizedBox(
              height: 38,
            ),
          ],
        ),
      ),
    );
  }
}
