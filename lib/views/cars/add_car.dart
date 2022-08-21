import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/services/car_service.dart';

import '../../constantes/values.dart';

class AddCar extends GetView<CarService> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: Get.width * .95,
                padding: EdgeInsets.only(bottom: 5),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nom',
                  ),
                  onChanged: (value) {},
                  onSaved: (newValue) {
                    controller.ADD_CAR.value['nom'] = newValue;
                  },
                ),
              ),
              Container(
                width: Get.width * .95,
                padding: EdgeInsets.only(bottom: 5),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Model',
                  ),
                  onChanged: (value) {},
                  onSaved: (newValue) {
                    controller.ADD_CAR.value['model'] = newValue;
                  },
                ),
              ),
              Container(
                width: Get.width * .95,
                padding: EdgeInsets.only(bottom: 5),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Type de carburant',
                  ),
                  onChanged: (value) {},
                  onSaved: (newValue) {
                    controller.ADD_CAR.value['type_carburant'] = newValue;
                  },
                ),
              ),
              InkWell(
                onTap: () async {
                  controller.ADD_CAR.value['end_date_assurance'] =
                      await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 60)),
                          lastDate: DateTime.now().add(Duration(days: 365)));
                },
                child: Container(
                  width: Get.width * .95,
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelText: 'Date echance Assurance',
                    ),
                    onChanged: (value) {},
                    onSaved: (newValue) {
                      controller.ADD_CAR.value['end_date_assurance'] = newValue;
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  controller.ADD_CAR.value['end_date_controle'] =
                      await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 60)),
                          lastDate: DateTime.now().add(Duration(days: 365)));
                },
                child: Container(
                  width: Get.width * .95,
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelText: 'Date echance Controle Technique',
                    ),
                    onChanged: (value) {},
                    onSaved: (newValue) {
                      controller.ADD_CAR.value['end_date_controle'] = newValue;
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  controller.ADD_CAR.value['end_date_stationnement'] =
                      await showDatePicker(
                          locale: Get.locale,
                          confirmText: "Choisir",
                          keyboardType: TextInputType.datetime,
                          initialDatePickerMode: DatePickerMode.day,
                          fieldLabelText: "Date d'achat",
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 60)),
                          lastDate: DateTime.now().add(Duration(days: 365)));
                },
                child: Container(
                  width: Get.width * .95,
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelText: 'Date echéance Stationnement',
                    ),
                    onSaved: (newValue) {
                      controller.ADD_CAR.value['end_date_stationnement'] =
                          newValue;
                    },
                    onChanged: (value) {},
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  controller.ADD_CAR.value['end_date_vignette'] =
                      await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 60)),
                          lastDate: DateTime.now().add(Duration(days: 365)));
                },
                child: Container(
                  width: Get.width * .95,
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelText: 'Date echéance Vignette',
                    ),
                    onChanged: (value) {},
                    onSaved: (newValue) {
                      controller.ADD_CAR.value['end_date_vignette'] = newValue;
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  try {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                            allowedExtensions: ['pdf', 'doc', "docx"],
                            allowMultiple: false,
                            onFileLoading: (FilePickerStatus status) {
                              if (status == FilePickerStatus.picking) {
                                Get.snackbar("File picking", "message $status");
                              }
                            });
                    controller.ADD_CAR.value['carte_rose'] = result!.paths[0];
                  } catch (e) {
                    print(e);
                  }
                },
                child: DottedBorder(
                  color: AppColors.accent,
                  radius: Radius.circular(10),
                  child: Container(
                    height: 40,
                    width: Get.width * .95,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Choisir la carte"),
                        // Text('Carte ROSE'),
                        Icon(Icons.file_copy)
                      ],
                    )),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    // color: Colors.lime,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    textStyle: TextStyle(color: Colors.white),
                    backgroundColor: AppColors.accentDark),
                child: Text("Enregistrer"),
              ),
            ],
          )),
    );
  }
}
