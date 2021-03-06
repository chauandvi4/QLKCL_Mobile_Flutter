import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qlkcl/helper/dismiss_keyboard.dart';
import 'package:qlkcl/helper/infomation.dart';
import 'package:qlkcl/models/test.dart';
import 'package:qlkcl/screens/test/component/test_form.dart';
import 'package:qlkcl/screens/test/update_test_screen.dart';
import 'package:qlkcl/utils/constant.dart';

class DetailTest extends StatefulWidget {
  static const String routeName = "/detail_test";
  DetailTest({Key? key, required this.code}) : super(key: key);
  final String code;

  @override
  _DetailTestState createState() => _DetailTestState();
}

class _DetailTestState extends State<DetailTest> {
  late Future<dynamic> futureTest;

  @override
  void initState() {
    super.initState();
    futureTest = fetchTest(data: {'code': widget.code});
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thông tin phiếu xét nghiệm'),
          centerTitle: true,
          actions: [
            FutureBuilder(
              future: getRole(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data != 5
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateTest(
                                          code: widget.code,
                                        )));
                          },
                          icon: Icon(Icons.edit),
                        )
                      : Container();
                }
                return Container();
              },
            ),
          ],
        ),
        body: FutureBuilder<dynamic>(
          future: futureTest,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              EasyLoading.dismiss();
              if (snapshot.hasData) {
                return TestForm(
                  testData: Test.fromJson(snapshot.data),
                  mode: Permission.view,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }

            EasyLoading.show();
            return TestForm(
              mode: Permission.view,
            );
          },
        ),
      ),
    );
  }
}
