import 'dart:ffi';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qlkcl/components/dropdown_field.dart';
import 'package:qlkcl/components/input.dart';
import 'package:qlkcl/config/app_theme.dart';
import 'package:qlkcl/helper/validation.dart';
import 'package:qlkcl/models/key_value.dart';
import 'package:qlkcl/models/medical_declaration.dart';
import 'package:qlkcl/utils/constant.dart';
import 'package:qlkcl/utils/data_form.dart';

class MedDeclForm extends StatefulWidget {
  const MedDeclForm({
    Key? key,
    this.mode = Permission.view,
    this.medicalDeclData,
  }) : super(key: key);
  final Permission mode;
  final MedicalDecl? medicalDeclData;

  @override
  _MedDeclFormState createState() => _MedDeclFormState();
}

class _MedDeclFormState extends State<MedDeclForm> {
  //Add medical declaration
  bool isChecked = false;
  bool agree = false;

  //Input Controller
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final userNameController = TextEditingController();
  final heartBeatController = TextEditingController();
  final temperatureController = TextEditingController();
  final breathingController = TextEditingController();
  final bloodPressureController = TextEditingController();
  final otherController = TextEditingController();
  final extraSymptomController = TextEditingController();
  final mainSymptomController = TextEditingController();
  final spo2Controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('medical decl init');
    print(widget.medicalDeclData.toString());

    //Data contained
    userNameController.text = widget.medicalDeclData?.user.fullName != null
        ? widget.medicalDeclData!.user.fullName
        : "";

    heartBeatController.text = widget.medicalDeclData?.heartbeat != null
        ? widget.medicalDeclData!.heartbeat.toString()
        : "";

    print('input');
    print(heartBeatController.text);
    print('heartbeat in data');
    print(widget.medicalDeclData?.heartbeat);
    temperatureController.text = widget.medicalDeclData?.temperature != null
        ? widget.medicalDeclData!.temperature.toString()
        : "";

    breathingController.text = widget.medicalDeclData?.breathing != null
        ? widget.medicalDeclData!.breathing.toString()
        : "";

    bloodPressureController.text = widget.medicalDeclData?.breathing != null
        ? widget.medicalDeclData!.bloodPressure.toString()
        : "";
    spo2Controller.text = widget.medicalDeclData?.spo2 != null
        ? widget.medicalDeclData!.spo2.toString()
        : "";
  }

  @override
  Widget build(BuildContext context) {
    // //Data contained
    // userNameController.text = widget.medicalDeclData?.user.fullName != null
    //     ? widget.medicalDeclData!.user.fullName
    //     : "";

    // heartBeatController.text = widget.medicalDeclData?.heartbeat != null
    //     ? widget.medicalDeclData!.heartbeat.toString()
    //     : "";

    // temperatureController.text = widget.medicalDeclData?.temperature != null
    //     ? widget.medicalDeclData!.temperature.toString()
    //     : "";

    // breathingController.text = widget.medicalDeclData?.breathing != null
    //     ? widget.medicalDeclData!.breathing.toString()
    //     : "";

    // bloodPressureController.text = widget.medicalDeclData?.breathing != null
    //     ? widget.medicalDeclData!.bloodPressure.toString()
    //     : "";
    // spo2Controller.text = widget.medicalDeclData?.spo2 != null
    //     ? widget.medicalDeclData!.spo2.toString()
    //     : "";
    //submit
    void _submit() async {
      // Validate returns true if the form is valid, or false otherwise.
      if (_formKey.currentState!.validate()) {
        print(temperatureController.text);
        EasyLoading.show();
        final registerResponse = await createMedDecl(createMedDeclDataForm(
          phoneNumber: phoneNumberController.text,
          heartBeat:  int.tryParse(heartBeatController.text),
          temperature: double.tryParse(temperatureController.text),
          breathing: int.tryParse(breathingController.text),
          bloodPressure: double.tryParse(bloodPressureController.text),
          mainSymtoms: mainSymptomController.text,
          extraSymtoms: extraSymptomController.text,
          otherSymtoms: otherController.text,
          spo2: double.tryParse(spo2Controller.text),
        ));

        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(registerResponse.message)),
        );
      }
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // T??n ng?????i khai h???

                (widget.mode == Permission.add)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTileTheme(
                            contentPadding: EdgeInsets.all(0),
                            child: CheckboxListTile(
                              title: Text("Khai h???"),
                              controlAffinity: ListTileControlAffinity.leading,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                          ),

                          // S??T ng?????i khai h???
                          isChecked
                              ? Input(
                                  label: 'S??? ??i???n tho???i',
                                  hint: 'S??T ng?????i ???????c khai b??o',
                                  required: true,
                                  type: TextInputType.number,
                                  enabled: true,
                                  controller: phoneNumberController,
                                  validatorFunction: phoneValidator,
                                )
                              : Input(
                                  label: 'S??? ??i???n tho???i',
                                  hint: 'S??T ng?????i ???????c khai b??o',
                                  // required: true,
                                  type: TextInputType.number,
                                  enabled: false,
                                ),
                        ],
                      )
                    : Input(
                        label: 'H??? v?? t??n',
                        controller: userNameController,
                        required: true,
                        type: TextInputType.number,
                        enabled: false,
                      ),

                //Medical Declaration Info
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: const Text(
                    'A/ Ch??? s??? s???c kh???e:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Input(
                  label: 'Nh???p tim (l???n/ph??t)',
                  hint: 'Nh???p tim (l???n/ph??t)',
                  type: TextInputType.number,
                  controller: heartBeatController,
                  validatorFunction: intValidator,
                  enabled: (widget.mode == Permission.add) ? true : false,
                ),
                Input(
                  label: 'Nhi???t ????? c?? th??? (????? C)',
                  hint: 'Nhi???t ????? c?? th??? (????? C)',
                  type: TextInputType.number,
                  controller: temperatureController,
                  enabled: (widget.mode == Permission.add) ? true : false,
                ),
                Input(
                  label: 'N???ng ????? Oxi trong m??u (%)',
                  hint: 'N???ng ????? Oxi trong m??u (%)',
                  type: TextInputType.number,
                  controller: spo2Controller,
                  enabled: (widget.mode == Permission.add) ? true : false,
                ),
                Input(
                  label: 'Nh???p th??? (l???n/ph??t)',
                  hint: 'Nh???p th??? (l???n/ph??t)',
                  type: TextInputType.number,
                  controller: breathingController,
                  validatorFunction: intValidator,
                  enabled: (widget.mode == Permission.add) ? true : false,
                ),
                Input(
                  label: 'Huy???t ??p (mmHg)',
                  hint: 'Huy???t ??p (mmHg)',
                  type: TextInputType.number,
                  controller: bloodPressureController,
                  enabled: (widget.mode == Permission.add) ? true : false,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: const Text('B/ Tri???u ch???ng nghi nhi???m:',
                      style: TextStyle(fontSize: 16)),
                ),

                MultiDropdownInput<KeyValue>(
                  label: 'Tri???u ch???ng nghi nhi???m',
                  hint: 'Ch???n tri???u ch???ng',
                  itemValue: symptomMainList,
                  mode: Mode.BOTTOM_SHEET,
                  dropdownBuilder: _customDropDown,
                  compareFn: (item, selectedItem) =>
                      item?.id == selectedItem?.id,
                  itemAsString: (KeyValue? u) => u!.name,
                  selectedItems: (widget.medicalDeclData?.mainSymptoms != null)
                      ? (widget.medicalDeclData!.mainSymptoms
                          .toString()
                          .split(',')
                          .map((e) => symptomMainList[int.parse(e) - 1])
                          .toList())
                      : null,
                  onChanged: (value) {
                    if (value == null) {
                      mainSymptomController.text = "";
                    } else {
                      mainSymptomController.text =
                          value.map((e) => e.id).join(",");
                    }
                  },
                  enabled: widget.mode != Permission.view ? true : false,
                  maxHeight: 700,
                  popupTitle: 'Tri???u ch???ng nghi nhi???m',
                ),

                MultiDropdownInput<KeyValue>(
                  label: 'Tri???u ch???ng nghi nhi???m kh??c',
                  hint: 'Ch???n tri???u ch???ng',
                  itemValue: symptomExtraList,
                  mode: Mode.BOTTOM_SHEET,
                  dropdownBuilder: _customDropDown,
                  compareFn: (item, selectedItem) =>
                      item?.id == selectedItem?.id,
                  itemAsString: (KeyValue? u) => u!.name,
                  selectedItems: (widget.medicalDeclData?.extraSymptoms != null)
                      ? (widget.medicalDeclData!.extraSymptoms
                          .toString()
                          .split(',')
                          .map((e) => symptomExtraList[int.parse(e) - 5])
                          .toList())
                      : null,
                  onChanged: (value) {
                    if (value == null) {
                      extraSymptomController.text = "";
                    } else {
                      extraSymptomController.text =
                          value.map((e) => e.id).join(",");
                    }
                  },
                  enabled: widget.mode != Permission.view ? true : false,
                  maxHeight: 700,
                  popupTitle: 'Tri???u ch???ng kh??c',
                ),

                Input(
                  label: 'Kh??c',
                  hint: 'Kh??c',
                  controller: otherController,
                  enabled: (widget.mode == Permission.add) ? true : false,
                ),
                SizedBox(height: 20),

                //Button add medical declaration
                if (widget.mode == Permission.add)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTileTheme(
                        contentPadding: EdgeInsets.all(0),
                        child: CheckboxListTile(
                          title: Container(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                "T??i cam k???t ho??n to??n ch???u tr??ch nhi???m v??? t??nh ch??nh x??c v?? trung th???c c???a th??ng tin ???? cung c???p",
                                style: TextStyle(fontSize: 13),
                              )),
                          value: agree,
                          onChanged: (bool? value) {
                            setState(() {
                              agree = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Row(
                          children: [
                            Text(
                              '(*)',
                              style: TextStyle(
                                fontSize: 16,
                                color: CustomColors.error,
                              ),
                            ),
                            Text(
                              'Th??ng tin b???t bu???c',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: agree
                              ? _submit
                              : () {
                                  final snackBar = SnackBar(
                                    content: const Text(
                                        'Vui l??ng cam k???t tr?????c khi khai b??o.'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                          child: Text(
                            "Khai b??o",
                            style: TextStyle(color: CustomColors.white),
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _customDropDown(BuildContext context, List<KeyValue?> selectedItems) {
  // if (selectedItems.isEmpty) {
  //   return Container();
  // }

  return Wrap(
    children: selectedItems.map((e) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          // margin: EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColorLight),
          child: Text(
            e!.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      );
    }).toList(),
  );
}
