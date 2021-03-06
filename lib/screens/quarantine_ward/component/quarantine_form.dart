import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qlkcl/components/dropdown_field.dart';
import 'package:qlkcl/components/input.dart';
import 'package:qlkcl/config/app_theme.dart';
import 'package:qlkcl/helper/function.dart';
import 'package:qlkcl/helper/validation.dart';
import 'package:qlkcl/models/key_value.dart';
import 'package:qlkcl/models/member.dart';
import 'package:qlkcl/models/quarantine.dart';
import 'package:qlkcl/screens/quarantine_ward/component/circle_button.dart';
import 'package:qlkcl/utils/constant.dart';
import 'package:qlkcl/utils/data_form.dart';

class QuarantineForm extends StatefulWidget {
  final Permission mode;
  final Quarantine? quarantineInfo;

  const QuarantineForm(
      {Key? key, this.quarantineInfo, this.mode = Permission.add})
      : super(key: key);

  @override
  _QuarantineFormState createState() => _QuarantineFormState();
}

class _QuarantineFormState extends State<QuarantineForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  //Input Controller
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final wardController = TextEditingController();
  final addressController = TextEditingController();
  final typeController = TextEditingController();
  final emailController = TextEditingController();
  final quarantineTimeController = TextEditingController();
  final managerController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final statusController = TextEditingController();

  //Image Picker
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFileList = [];

  //Submit
  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      if (widget.mode == Permission.add) {
        final registerResponse =
            await createQuarantine(createQuarantineDataForm(
          email: emailController.text,
          fullName: nameController.text,
          country: countryController.text,
          city: cityController.text,
          district: districtController.text,
          ward: wardController.text,
          status: statusController.text,
          quarantineTime: int.parse(quarantineTimeController.text),
          mainManager: "1",
          address: addressController.text,
          type: typeController.text,
        ));
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(registerResponse.message)),
        );
      }
      if (widget.mode == Permission.edit) {
        print('edit');
        final registerResponse =
            await updateQuarantine(updateQuarantineDataForm(
          id: widget.quarantineInfo!.id.toInt(),
          email: emailController.text,
          fullName: nameController.text,
          country: countryController.text,
          city: cityController.text,
          district: districtController.text,
          ward: wardController.text,
          status: statusController.text,
          quarantineTime: int.parse(quarantineTimeController.text),
          mainManager: "1",
          address: addressController.text,
          type: typeController.text,
        ));
        if (registerResponse.success) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(registerResponse.message)),
          );
        } else {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(registerResponse.message)),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.quarantineInfo != null) {
      idController.text = widget.quarantineInfo?.id != null
          ? widget.quarantineInfo!.id.toString()
          : "";
      nameController.text = widget.quarantineInfo?.fullName ?? "";
      countryController.text = widget.quarantineInfo!.country != null
          ? widget.quarantineInfo?.country['code']
          : "";
      cityController.text = widget.quarantineInfo?.city != null
          ? widget.quarantineInfo!.city['id'].toString()
          : "";

      districtController.text = widget.quarantineInfo?.district != null
          ? widget.quarantineInfo!.district['id'].toString()
          : "";

      wardController.text = widget.quarantineInfo?.ward != null
          ? widget.quarantineInfo!.ward['id'].toString()
          : "";

      addressController.text = widget.quarantineInfo?.address ?? "";
      typeController.text = widget.quarantineInfo?.type ?? "";
      statusController.text = widget.quarantineInfo?.status ?? "";
      emailController.text = widget.quarantineInfo?.email ?? "";
      quarantineTimeController.text =
          widget.quarantineInfo?.quarantineTime.toString() ?? "";
      managerController.text = widget.quarantineInfo?.mainManager != null
          ? widget.quarantineInfo!.mainManager['full_name']
          : "";
      phoneNumberController.text = widget.quarantineInfo?.phoneNumber ?? "";
    } else {
      countryController.text = "VNM";
      statusController.text = "RUNNING";
      typeController.text = "CONCENTRATE";
    }

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Text(
                'Th??ng tin chung',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),

            Input(
              label: 'T??n ?????y ?????',
              required: true,
              controller: nameController,
            ),

            DropdownInput<KeyValue>(
              label: 'Qu???c gia',
              hint: 'Qu???c gia',
              required: widget.mode == Permission.view ? false : true,
              selectedItem: (widget.quarantineInfo?.country != null)
                  ? KeyValue.fromJson(widget.quarantineInfo!.country)
                  : KeyValue(id: 1, name: 'Vi???t Nam'),
              onFind: (String? filter) => fetchCountry(),
              onChanged: (value) {
                if (value == null) {
                  countryController.text = "";
                } else {
                  countryController.text = value.id;
                }
              },
              itemAsString: (KeyValue? u) => u!.name,
              showSearchBox: true,
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 700,
            ),

            DropdownInput<KeyValue>(
              label: 'T???nh/th??nh',
              hint: 'T???nh/th??nh',
              required: widget.mode == Permission.view ? false : true,
              selectedItem: (widget.quarantineInfo?.city != null)
                  ? KeyValue.fromJson(widget.quarantineInfo!.city)
                  : null,
              enabled: (widget.mode == Permission.edit ||
                      widget.mode == Permission.add)
                  ? true
                  : false,
              onFind: (String? filter) => fetchCity({'country_code': 'VNM'}),
              onChanged: (value) {
                if (value == null) {
                  cityController.text = "";
                } else {
                  cityController.text = value.id.toString();
                }
              },
              itemAsString: (KeyValue? u) => u!.name,
              showSearchBox: true,
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 700,
              popupTitle: 'T???nh th??nh',
            ),

            DropdownInput<KeyValue>(
              label: 'Qu???n/huy???n',
              hint: 'Qu???n/huy???n',
              required: widget.mode == Permission.view ? false : true,
              selectedItem: (widget.quarantineInfo?.district != null)
                  ? KeyValue.fromJson(widget.quarantineInfo!.district)
                  : null,
              enabled: (widget.mode == Permission.edit ||
                      widget.mode == Permission.add)
                  ? true
                  : false,
              onFind: (String? filter) =>
                  fetchDistrict({'city_id': cityController.text}),
              onChanged: (value) {
                if (value == null) {
                  districtController.text = "";
                } else {
                  districtController.text = value.id.toString();
                }
              },
              itemAsString: (KeyValue? u) => u!.name,
              showSearchBox: true,
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 700,
              popupTitle: 'Qu???n huy???n',
            ),

            DropdownInput<KeyValue>(
              label: 'Ph?????ng/x??',
              hint: 'Ph?????ng/x??',
              selectedItem: (widget.quarantineInfo?.ward != null)
                  ? KeyValue.fromJson(widget.quarantineInfo!.ward)
                  : null,
              enabled: (widget.mode == Permission.edit ||
                      widget.mode == Permission.add)
                  ? true
                  : false,
              onFind: (String? filter) =>
                  fetchWard({'district_id': districtController.text}),
              onChanged: (value) {
                if (value == null) {
                  wardController.text = "";
                } else {
                  wardController.text = value.id.toString();
                }
              },
              itemAsString: (KeyValue? u) => u!.name,
              showSearchBox: true,
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 700,
              popupTitle: 'Ph?????ng x??',
            ),

            Input(
              label: '?????a ch???',
              controller: addressController,
            ),

            DropdownInput<KeyValue>(
                label: 'Ng?????i qu???n l??',
                hint: 'Ng?????i qu???n l??',
                required: widget.mode == Permission.view ? false : true,
                selectedItem: (widget.quarantineInfo?.mainManager != null)
                    ? KeyValue.fromJson(widget.quarantineInfo!.mainManager)
                    : null,
                enabled: (widget.mode == Permission.edit ||
                        widget.mode == Permission.add)
                    ? true
                    : false,
                onFind: (String? filter) =>
                    fetchNotMemberList({'role_name_list': 'MANAGER'}),
                onChanged: (value) {
                  if (value == null) {
                    managerController.text = "";
                  } else {
                    managerController.text = value.id.toString();
                  }
                },
                itemAsString: (KeyValue? u) => u!.name,
                showSearchBox: true,
                mode: Mode.BOTTOM_SHEET,
                maxHeight: 700,
                popupTitle: 'Qu???n l??'),

            DropdownInput<KeyValue>(
              label: 'C?? s??? c??ch ly',
              hint: 'C?? s??? c??ch ly',
              required: true,
              itemValue: quarantineTypeList,
              itemAsString: (KeyValue? u) => u!.name,
              maxHeight: 150,
              compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
              selectedItem: quarantineTypeList
                  .safeFirstWhere((type) => type.id == typeController.text),
              onChanged: (value) {
                if (value == null) {
                  typeController.text = "";
                } else {
                  typeController.text = value.id;
                }
              },
            ),

            DropdownInput<KeyValue>(
              label: 'Tr???ng th??i',
              hint: 'Tr???ng th??i',
              required: true,
              itemValue: quarantineStatusList,
              itemAsString: (KeyValue? u) => u!.name,
              maxHeight: 150,
              compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
              selectedItem: quarantineStatusList.safeFirstWhere(
                  (status) => status.id == statusController.text),
              onChanged: (value) {
                if (value == null) {
                  statusController.text = "";
                } else {
                  statusController.text = value.id;
                }
              },
            ),

            Input(
              label: 'Th???i gian c??ch ly (ng??y)',
              hint: 'Th???i gian c??ch ly',
              required: true,
              type: TextInputType.number,
              validatorFunction: quarantineTimeValidator,
              controller: quarantineTimeController,
            ),

            // DropdownInput(
            //   label: 'Ng?????i qu???n l??',
            //   hint: 'Ng?????i qu???n l??',
            //   required: true,
            //   itemValue: ['1', '2'],
            //   selectedItem:
            //       widget.mode == Permission.add ? null : managerController.text,
            // ),

            Input(
              label: '??i???n tho???i li??n l???c',
              hint: '??i???n tho???i li??n l???c',
              type: TextInputType.phone,
              validatorFunction: phoneNullableValidator,
              controller: phoneNumberController,
            ),

            Input(
              label: 'Email',
              hint: 'Email li??n l???c',
              required: true,
              controller: emailController,
              type: TextInputType.emailAddress,
              validatorFunction: emailValidator,
            ),

            Container(
              margin: EdgeInsets.all(16),
              child: Text(
                (widget.mode == Permission.add) ? 'Th??m ???nh' : 'S???a b??? ???nh',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: DottedBorder(
                padding: EdgeInsets.all(0),
                color: CustomColors.primary,
                strokeWidth: 1,
                child: OutlinedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size.infinite),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: CustomColors.primary,
                        width: 1.0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  onPressed: () {
                    selectImages();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Th??m ???nh'),
                    ],
                  ),
                ),
              ),
            ),

            //Selected pictures display
            _imageFileList.isEmpty
                ? Center(
                    heightFactor: 5,
                    child: Text('Ch??a c?? h??nh n??o ???????c ch???n'),
                  )
                : Container(
                    margin: EdgeInsets.fromLTRB(8, 12, 8, 12),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (BuildContext ctx, int index) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.file(File(_imageFileList[index].path),
                                    fit: BoxFit.cover),
                                Positioned(
                                  right: -0.05,
                                  top: -0.05,
                                  child: CircleButton(
                                      onTap: () {
                                        _imageFileList.removeAt(index);
                                        setState(() {});
                                      },
                                      iconData: Icons.close),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: _imageFileList.length,
                      ),
                    ),
                  ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text(
                  (widget.mode == Permission.add) ? 'T???o' : 'X??c nh???n',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      _imageFileList.addAll(selectedImages);
    }
    setState(() {});
  }
}
