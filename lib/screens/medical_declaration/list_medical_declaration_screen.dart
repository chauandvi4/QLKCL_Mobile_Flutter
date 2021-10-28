import 'package:flutter/material.dart';
import 'package:qlkcl/components/cards.dart';

class ListMedicalDeclaration extends StatefulWidget {
  static const String routeName = "/list_medical_declaration";
  ListMedicalDeclaration({Key? key}) : super(key: key);

  @override
  _ListMedicalDeclarationState createState() => _ListMedicalDeclarationState();
}

class _ListMedicalDeclarationState extends State<ListMedicalDeclaration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Lịch sử khai báo y tế"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          MedicalDeclaration(
            id: "KB-123456789",
            time: "22/09/2021 18:00",
            status: "Bình thường",
            onTap: () {},
          ),
        ],
      )),
    );
  }
}
