import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:get/get.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/services/car_service.dart';

class AddDocument extends GetView<CarService> {
  AddDocument(this.id_car, this.item, {Key? key}) {
    print(this.item);
    print(controller.currentCar.value!.documents[this.item['doc_name']]);
    start_date.text = (controller.currentCar.value!
            .documents[this.item['doc_name']]!['debut'] as Timestamp)
        .toString();
    start_date.text = (controller.currentCar.value!
            .documents[this.item['doc_name']]!['fin'] as Timestamp)
        .toString();
    // end_date.text = this.item['fin'];
  }
  String id_car;
  Map<String, dynamic> item;
  Map<String, dynamic> form = {};
  final start_date = TextEditingController();
  final end_date = TextEditingController();
  bool filePicked = false;
  List<String> allowExt = ['pdf', "docx", "doc"];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void submitForm() async {
    Get.back();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await controller.updateCarStep1(id_car, item['doc_name']);

      await Get.dialog(StatefulBuilder(
          builder: (context, setState) => Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: FractionallySizedBox(
                    heightFactor: .1,
                    widthFactor: .9,
                    child: Material(
                      color: AppColors.backgroundDark,
                      type: MaterialType.card,
                      child: Row(
                        children: [
                          CircularProgressIndicator(
                            value: controller.progress,
                            color: AppColors.accent,
                          ),
                          Text('${controller.progress}% Uploading')
                        ],
                      ),
                    ),
                  ),
                ),
              )));
      if (1 == 1) {
        Get.snackbar("Update Card", "La mise a  jour a reussi");
      } else {
        Get.snackbar("Update Card", "La mise a  jour a échoué");
      }
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${(item["doc_name"] as String).capitalizeFirst}",
          style: Get.textTheme.displayMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: submitForm, child: Text('Mettre à jour')),
            TextButton(
                onPressed: () {
                  controller.resetForm();
                  Get.back();
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () async {
                              var value = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now().subtract(365.days),
                                  lastDate: DateTime.now().add(365.days),
                                  initialDate: item['debut']);
                              if (value != null) {
                                start_date.text =
                                    value.toLocal().toIso8601String();
                              }
                            },
                            child: TextFormField(
                              enabled: false,
                              controller: controller.start_date.value,
                              onSaved: (newValue) {
                                item['debut'] = start_date.value.text;
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
                              var value = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now().subtract(365.days),
                                  initialDate: item['fin'],
                                  lastDate: DateTime.now().add(365.days));
                              if (value != null) {
                                end_date.text =
                                    value.toLocal().toIso8601String();
                              }
                              print(
                                  "${start_date.value.text} - ${end_date.value.text}");
                            },
                            child: TextFormField(
                              enabled: false,
                              controller: controller.end_date.value,
                              onSaved: (newValue) {
                                item['fin'] = end_date.value.text;
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
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: allowExt);
                              if (result != null) {
                                controller.setfile = result.files[0];
                              }
                            },
                            child: !controller.isFilePicked
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
                                          Text(
                                              "Choisis un Fichier PDF ou Docx"),
                                        ],
                                      ),
                                    ))
                                : Container(
                                    height: 40,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)),
                                        border:
                                            Border.all(color: Colors.green)),
                                    child: Row(
                                      children: [
                                        // Text("${controller.fileg.value!.path}",
                                        //     overflow: TextOverflow.ellipsis),
                                        Text(
                                          'File ready to upload',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              maximumSize: Size(50, 30)),
                                          onPressed: () {},
                                          child: Text('Voir '),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     TextButton(
                    //         onPressed: submitForm,
                    //         child: Text('Mettre à jour')),
                    //     TextButton(
                    //         onPressed: () {
                    //           controller.resetForm();
                    //           Get.back();
                    //         },
                    //         child: Text('Annuler'),
                    //         style: ButtonStyle(
                    //             backgroundColor:
                    //                 MaterialStateProperty.all<Color>(
                    //                     Colors.red.withOpacity(.2)),
                    //             foregroundColor:
                    //                 MaterialStateProperty.all<Color>(
                    //                     Colors.red)))
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
