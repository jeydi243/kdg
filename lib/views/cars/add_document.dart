import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:get/get.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/services/car_service.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../models/car.dart';

class AddDocument extends GetView<CarService> {
  String id;
  String namedoc;
  AddDocument(this.id, this.namedoc, {Key? key}) : super(key: key);
  //formKey
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
//submit form
  void submitForm() async {
    Get.back();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await controller.updateCar(id, namedoc);

      Get.dialog(StatefulBuilder(
          builder: (context, setState) => Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Material(
                    child: Row(
                      children: [
                        CircularProgressIndicator(
                          value: controller.file_upload_progress.value,
                          color: AppColors.accent,
                        ),
                        Text(
                            'Uploading.. ${controller.file_upload_progress.value}%')
                      ],
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // color: Colors.red,
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
                      controller.startDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now().subtract(365.days),
                          lastDate: DateTime.now().add(365.days),
                          initialDate: DateTime.now());
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: controller.start_date.value,
                      decoration:
                          InputDecoration(label: Text("Debut de l'écheance")),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () async {
                      controller.endDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now().subtract(365.days),
                          initialDate: DateTime.now(),
                          lastDate: DateTime.now().add(365.days));
                      print(
                          "${controller.start_date.value.text} - ${controller.end_date.value.text}");
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: controller.end_date.value,
                      decoration:
                          InputDecoration(label: Text("Fin de l'écheance")),
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
                              allowedExtensions: ['pdf', "docx", "doc"]);
                      if (result != null) {
                        controller.setfile = result.files[0];
                      }
                    },
                    child: !controller.filepicked.value
                        ? DottedBorder(
                            color: AppColors.accentDark,
                            child: Container(
                              height: 150,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Text("Choisis un Fichier PDF ou Docx"),
                                ],
                              ),
                            ))
                        : Container(
                            // height: 150,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Text("${controller.fileg!.value!.path}",
                                    overflow: TextOverflow.ellipsis),
                                TextButton(
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
            TextButton(onPressed: submitForm, child: Text('Mettre à jour')),
            TextButton(
                onPressed: () {
                  controller.reset();
                  Get.back();
                },
                child: Text('Annuler'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.red.withOpacity(.2)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red))),
          ],
        ),
      ),
    );
  }
}
