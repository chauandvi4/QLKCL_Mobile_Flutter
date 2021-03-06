import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qlkcl/helper/dismiss_keyboard.dart';
import 'package:qlkcl/models/custom_user.dart';
import 'package:qlkcl/models/member.dart';
import 'package:qlkcl/screens/members/component/member_personal_info.dart';
import 'package:qlkcl/screens/members/component/member_quarantine_info.dart';
import 'package:qlkcl/config/app_theme.dart';
import 'package:qlkcl/utils/constant.dart';

class UpdateMember extends StatefulWidget {
  static const String routeName = "/update_member";
  final String? code;
  final CustomUser? personalData;
  final Member? quarantineData;
  UpdateMember({Key? key, this.code, this.personalData, this.quarantineData})
      : super(key: key);

  @override
  _UpdateMemberState createState() => _UpdateMemberState();
}

class _UpdateMemberState extends State<UpdateMember>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Future<dynamic> futureMember;
  late CustomUser personalData;
  late Member? quarantineData;

  @override
  void initState() {
    super.initState();
    if (widget.code != null) {
      futureMember = fetchCustomUser(data: {'code': widget.code});
    } else {
      futureMember = fetchCustomUser();
    }
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  _handleTabChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cập nhật thông tin"),
          centerTitle: true,
          // actions: [
          //   if (_tabController.index == 0)
          //     IconButton(
          //       onPressed: () {},
          //       icon: Icon(Icons.qr_code_scanner),
          //       tooltip: "Nhập dữ liệu từ CCCD",
          //     ),
          // ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: CustomColors.white,
            tabs: [
              Tab(text: "Thông tin cá nhân"),
              Tab(text: "Thông tin cách ly"),
            ],
          ),
        ),
        body: (widget.personalData != null)
            ? (TabBarView(
                controller: _tabController,
                children: [
                  MemberPersonalInfo(
                    personalData: widget.personalData,
                    tabController: _tabController,
                    mode: Permission.edit,
                  ),
                  MemberQuarantineInfo(
                    quarantineData: widget.quarantineData,
                    mode: Permission.edit,
                  ),
                ],
              ))
            : (FutureBuilder<dynamic>(
                future: futureMember,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    EasyLoading.dismiss();
                    if (snapshot.hasData) {
                      personalData =
                          CustomUser.fromJson(snapshot.data["custom_user"]);
                      quarantineData = snapshot.data["member"] != null
                          ? Member.fromJson(snapshot.data["member"])
                          : null;
                      if (quarantineData != null) {
                        quarantineData!.customUserCode = personalData.code;
                        quarantineData!.quarantineWard =
                            personalData.quarantineWard;
                      }
                      return TabBarView(
                        controller: _tabController,
                        children: [
                          MemberPersonalInfo(
                            personalData: personalData,
                            tabController: _tabController,
                            mode: Permission.edit,
                          ),
                          MemberQuarantineInfo(
                            quarantineData: quarantineData,
                            mode: Permission.edit,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                  }

                  EasyLoading.show();
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      MemberPersonalInfo(
                        tabController: _tabController,
                        mode: Permission.edit,
                      ),
                      MemberQuarantineInfo(
                        mode: Permission.edit,
                      ),
                    ],
                  );
                },
              )),
      ),
    );
  }
}
