import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qlkcl/components/dropdown_field.dart';
import 'package:qlkcl/components/input.dart';
import 'package:qlkcl/helper/authentication.dart';
import 'package:qlkcl/helper/dismiss_keyboard.dart';
import 'package:qlkcl/helper/infomation.dart';
import 'package:qlkcl/helper/validation.dart';
import 'package:qlkcl/models/key_value.dart';
import 'package:qlkcl/screens/app.dart';
import 'package:qlkcl/config/app_theme.dart';
import 'package:qlkcl/screens/members/update_member_screen.dart';
import 'package:qlkcl/utils/data_form.dart';

class Register extends StatefulWidget {
  static const String routeName = "/register";
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    super.initState();
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
          backgroundColor: CustomColors.background,
          iconTheme: IconThemeData(
            color: CustomColors.primaryText,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                child: Image.asset("assets/images/sign_up.png"),
              ),
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final secondPassController = TextEditingController();
  final quarantineWardController = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "????ng k?? c??ch ly",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Input(
            label: "S??? ??i???n tho???i",
            hint: "Nh???p s??? ??i???n tho???i",
            type: TextInputType.phone,
            required: true,
            validatorFunction: phoneValidator,
            controller: phoneController,
          ),
          Input(
            label: "M???t kh???u",
            hint: "Nh???p m???t kh???u",
            obscure: true,
            required: true,
            controller: passController,
            validatorFunction: passValidator,
          ),
          Input(
            label: "X??c nh???n m???t kh???u",
            hint: "X??c nh???n m???t kh???u",
            obscure: true,
            required: true,
            controller: secondPassController,
            validatorFunction: passValidator,
            error: error,
          ),
          DropdownInput<KeyValue>(
            label: 'Khu c??ch ly',
            hint: 'Ch???n khu c??ch ly',
            itemAsString: (KeyValue? u) => u!.name,
            onFind: (String? filter) => fetchQuarantineWardNoToken({
              'is_full': "false",
            }),
            compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
            onChanged: (value) {
              if (value == null) {
                quarantineWardController.text = "";
              } else {
                quarantineWardController.text = value.id.toString();
              }
            },
            mode: Mode.BOTTOM_SHEET,
            maxHeight: 700,
            showSearchBox: true,
            required: true,
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _submit,
              child: Text(
                '????ng k??',
                style: TextStyle(color: CustomColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() async {
    setState(() {
      error = null;
    });
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      if (passController.text != secondPassController.text) {
        setState(() {
          error = "M???t kh???u kh??ng tr??ng kh???p";
        });
      } else {
        EasyLoading.show();
        final registerResponse = await register(registerDataForm(
            phoneNumber: phoneController.text,
            password: passController.text,
            quarantineWard: quarantineWardController.text));
        if (registerResponse.success) {
          final loginResponse = await login(loginDataForm(
              phoneNumber: phoneController.text,
              password: passController.text));
          EasyLoading.dismiss();
          if (loginResponse.success) {
            int role = await getRole();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => App(role: role)),
                (Route<dynamic> route) => false);
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => UpdateMember()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(loginResponse.message)),
            );
          }
        } else {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(registerResponse.message)),
          );
        }
      }
    }
  }
}
