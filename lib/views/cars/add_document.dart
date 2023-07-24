
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:get/get.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/services/car_service.dart';

class AddDocument extends StatefulWidget {
  AddDocument({required this.item, Key? key});
  final Map<String, dynamic> item;

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  CarService controller = Get.find();
  Map<String, dynamic> form = {};

  bool filePicked = false;
  PlatformFile? currentFile;
  final end_date = TextEditingController();
  final start_date = TextEditingController();
  late DateTime debut;
  late DateTime fin;
  List<String> allowExt = ['pdf', "docx", "doc"];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    fin = ff("fin");
    debut = ff("debut");
    end_date.text = fin.toIso8601String();
    start_date.text = debut.toIso8601String();
  }

  DateTime ff(String when) {
    return controller.currentCar.value!
            .documents[widget.item['doc_name']]![when] is Timestamp
        ? DateTime.fromMillisecondsSinceEpoch((controller
                .currentCar.value!.documents[widget.item['doc_name']]![when])
            .millisecondsSinceEpoch)
        : DateTime.parse(controller
            .currentCar.value!.documents[widget.item['doc_name']]![when]);
  }

  void submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (form.isNotEmpty) {
        form['doc_name'] = widget.item['doc_name'];
        form['id'] = controller
            .currentCar.value!.documents[widget.item['doc_name']]!['id'];

        if (currentFile != null) {
          final meta = SettableMetadata(
            customMetadata: {
              ...form,
            },
          );
// 				Get.dialog(StatefulBuilder(
//               builder: (context, setState) => Center(
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                       child: FractionallySizedBox(
//                         heightFactor: .1,
//                         widthFactor: .9,
//                         child: Material(
//                           color: AppColors.backgroundDark,
//                           type: MaterialType.card,
//                           child: Row(
//                             children: [
//                               CircularProgressIndicator(
//                                 value: controller.progress,
//                                 color: AppColors.accent,
//                               ),
//                               !thereIsFile()
//                                   ? SizedBox(
//                                       height: 30,
//                                       width: 35,
//                                       child: LoadingIndicator(
//                                           indicatorType:
//                                               Indicator.lineScalePulseOut,
//                                           colors: const [AppColors.accent],
//                                           strokeWidth: 1,
//                                           backgroundColor: Colors.transparent,
//                                           pathBackgroundColor: Colors.black),
//                                     )
//                                   : Container(),
//                               thereIsFile()
//                                   ? Padding(
//                                       padding: const EdgeInsets.only(left: 10),
//                                       child: Text(
//                                           '${controller.progress}% Uploading'),
//                                     )
//                                   : Container(),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 10),
//                                 child: Text('Mise à jour'),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   )));
          controller.storefile(currentFile, meta);
        }

        await controller.updateCar(map: form);
      }
      Get.back();
    }
  }

  bool thereIsFile() {
    return currentFile != null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? shouldPop = false;
        if (form.isNotEmpty) {
          shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Quitter et annuler les modifications ?"),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
        } else {
          shouldPop = true;
        }
        return shouldPop!;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Text(
            "${(widget.item["doc_name"] as String).capitalizeFirst} - ${controller.currentCar.value!.Nom}",
            style: Get.textTheme.displayMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: form.isNotEmpty ? submitForm : null,
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      'Mettre à jour',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                      controller.resetForm();
                    },
                    child: Text('Annuler'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red.withOpacity(.2)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)))
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () async {
                            print("On tap: ${form['debut']}");
                            DateTime? value = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now().subtract(365.days),
                                lastDate: DateTime.now().add(365.days),
                                initialDate: debut);
                            if (value != null) {
                              setState(() {
                                start_date.text =
                                    value.toLocal().toIso8601String();
                                form['debut'] =
                                    value.toLocal().toIso8601String();
                              });
                            }
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: start_date,
                            onSaved: (newValue) {
                              setState(() {
                                // form['debut'] = start_date.value.text;
                              });
                            },
                            decoration: InputDecoration(
                                label: Text("Debut de l'écheance")),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () async {
                            DateTime? value = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now().subtract(365.days),
                                initialDate: fin,
                                lastDate: DateTime.now().add(365.days));
                            if (value != null) {
                              setState(() {
                                end_date.text =
                                    value.toLocal().toIso8601String();
                                form['fin'] = value.toLocal().toIso8601String();
                              });
                            }
                            print(
                                "${start_date.value.text} - ${end_date.value.text}");
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: end_date,
                            onSaved: (newValue) {
                              setState(() {
                                // form['fin'] = end_date.value.text;
                              });
                            },
                            decoration: InputDecoration(
                                label: Text("Fin de l'écheance")),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: allowExt);
                            if (result != null) {
                              setState(() {
                                currentFile = result.files[0];
                                filePicked = true;
                              });
                            }
                          },
                          child: !filePicked
                              ? DottedBorder(
                                  color: AppColors.accentDark,
                                  radius: Radius.circular(15),
                                  child: Container(
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        Text("Choisis un Fichier PDF ou Docx"),
                                      ],
                                    ),
                                  ))
                              : Container(
                                  height: 40,
                                  width: Get.width,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      border: Border.all(color: Colors.green)),
                                  child: Row(
                                    children: [
                                      // Text("${controller.fileg.value!.path}",
                                      //     overflow: TextOverflow.ellipsis),
                                      Text(
                                        'File ready to upload',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      // TextButton(
                                      //   style: TextButton.styleFrom(
                                      //       maximumSize: Size(50, 30)),
                                      //   onPressed: () {},
                                      //   child: Text('Voir '),
                                      // ),
                                      // ViewerPDF(link)
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 250),
                child: CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
