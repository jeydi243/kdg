import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:get/get.dart';
import 'package:kdg/services/car_service.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AddDocument extends GetView<CarService> {
  const AddDocument({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      // color: Colors.red,
      child: Form(
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
                        File file = File(result.files.single.path ?? "");
// controller.ge();
                        Get.snackbar("File picked", "Path ${file.path}");
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(label: Text("Fichier PDF")),
                    ),
                  ),
                ),
               
              ],
            ),
            TextButton(
                onPressed: () {
                  controller.updateCarDocument();
                },
                child: Text('Mettre à jour')),
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
