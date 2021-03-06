import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qlkcl/components/input.dart';
import 'package:qlkcl/config/app_theme.dart';
import 'package:qlkcl/models/building.dart';
import 'package:qlkcl/models/floor.dart';
import 'package:qlkcl/models/quarantine.dart';
import 'package:qlkcl/utils/data_form.dart';
import 'component/general_info_building.dart';

class AddFloorScreen extends StatefulWidget {
  static const String routeName = "/add-floor";
  final Building? currentBuilding;
  final Quarantine? currentQuarantine;
  final VoidCallback onGoBackFloorList;

  const AddFloorScreen({
    Key? key,
    required this.onGoBackFloorList,
    this.currentBuilding,
    this.currentQuarantine,
  }) : super(key: key);

  @override
  _AddFloorScreenState createState() => _AddFloorScreenState();
}

class _AddFloorScreenState extends State<AddFloorScreen> {
  late Future<dynamic> futureFloorList;

  @override
  void initState() {
    super.initState();

//   myController.addListener(_updateLatestValue);
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  //Submit
  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      final registerResponse = await createFloor(
        createFloorDataForm(
            name: nameController.text,
            quarantineBuilding: widget.currentBuilding!.id),
      );
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(registerResponse.message)),
      );
    }
    widget.onGoBackFloorList();
    Navigator.pop(context);
  }

//  bool addMultiple = false;
//  int numOfAddedFloor = 1;

//  final myController = TextEditingController();

  // void _updateLatestValue() {
  //   setState(() {
  //     numOfAddedFloor = int.parse(myController.text);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    futureFloorList =
        fetchFloorList({'quarantine_building': widget.currentBuilding!.id});
    final appBar = AppBar(
      title: Text('Th??m t???ng'),
      centerTitle: true,
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: FutureBuilder<dynamic>(
            future: futureFloorList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                EasyLoading.dismiss();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.25,
                      child: GeneralInfoBuilding(
                        currentQuarantine: widget.currentQuarantine!,
                        currentBuilding: widget.currentBuilding!,
                        numberOfFloor: snapshot.data.length,
                      ),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.6,

                      //Input fields
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Add multiple floors
                            // Container(
                            //   margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
                            // child: Row(
                            //   children: [
                            //     Expanded(
                            //       flex: 55,
                            //       child: ListTileTheme(
                            //         contentPadding: EdgeInsets.all(0),
                            //         child: CheckboxListTile(
                            //           title: Text("Th??m nhi???u t???ng"),
                            //           controlAffinity:
                            //               ListTileControlAffinity.leading,
                            //           value: addMultiple,
                            //           onChanged: (bool? value) {
                            //             setState(() {
                            //               addMultiple = value!;
                            //             });
                            //           },
                            //         ),
                            //       ),
                            //     ),
                            //     // insert number of floor
                            //     addMultiple
                            //         ? Expanded(
                            //             flex: 45,
                            //             child: Input(
                            //               label: 'S??? t???ng',
                            //               hint: 'S??? t???ng',
                            //               type: TextInputType.number,
                            //               required: true,
                            //               //initValue: '1',
                            //               controller: myController,
                            //             ),
                            //           )
                            //         : Container(),
                            //   ],
                            // ),
                            //),
                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 16),
                            //   child: const Text(
                            //     'Ch???nh s???a th??ng tin t???ng',
                            //     style: TextStyle(fontSize: 16),
                            //   ),
                            // ),
                            // addMultiple
                            //     ?
                            //     ListView.builder(
                            //         physics: NeverScrollableScrollPhysics(),
                            //         shrinkWrap: true,
                            //         itemBuilder: (ctx, index) {
                            //           return Row(
                            //             children: [
                            //               Expanded(
                            //                 child: Input(
                            //                   label: 'T??n t???ng',
                            //                   hint: 'T??n t???ng',
                            //                   required: true,
                            //                 ),
                            //               ),
                            //             ],
                            //           );
                            //         },
                            //         itemCount: numOfAddedFloor,
                            //       )
                            //    :

                            Form(
                              key: _formKey,
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Input(
                                        label: 'T??n t???ng',
                                        hint: 'T??n t???ng',
                                        required: true,
                                        controller: nameController,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: Text(
                          "X??c nh???n",
                          style: TextStyle(color: CustomColors.white),
                        ),
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Snapshot has error');
              }
              EasyLoading.show();
              return Container();
            }),
      ),
    );
  }
}
