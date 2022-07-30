import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:get/get.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/services/car_service.dart';

class AddDocument extends GetView<CarService> {
  String id_car;
  // String namedoc;
  Map<String, dynamic> item;
  // AddDocument(this.id_car, this.namedoc, {Key? key}) : super(key: key);
  AddDocument(this.id_car, this.item, {Key? key}) : super(key: key);
  //formKey
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
//submit form
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
    return FractionallySizedBox(
      heightFactor: .4,
      widthFactor: .8,
      alignment: Alignment.center,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.backgroundDark,
        type: MaterialType.card,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${(item["doc_name"] as String).capitalizeFirst}",
                    style: Get.textTheme.displayMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    child: Icon(Icons.close),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                  ),
                )
              ],
            ),
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
                              controller.startDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now().subtract(365.days),
                                  lastDate: DateTime.now().add(365.days),
                                  initialDate: DateTime.now());
                            },
                            child: TextFormField(
                              enabled: false,
                              controller: controller.start_date.value,
                              decoration: InputDecoration(
                                  label: Text("Debut de l'écheance")),
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
                                      allowedExtensions: [
                                    'pdf',
                                    "docx",
                                    "doc"
                                  ]);
                              if (result != null) {
                                controller.setfile = result.files[0];
                              }
                            },
                            child: !controller.filepicked.value
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
                                    // height: 150,
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Text("${controller.fileg.value!.path}",
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: submitForm,
                            child: Text('Mettre à jour')),
                        TextButton(
                            onPressed: () {
                              controller.resetForm();
                              Get.back();
                            },
                            child: Text('Annuler'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red.withOpacity(.2)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red)))
                      ],
                    ),
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
