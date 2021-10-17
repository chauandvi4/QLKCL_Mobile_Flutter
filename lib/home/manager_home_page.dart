import 'package:flutter/material.dart';
import 'package:qlkcl/components/cards.dart';
import 'package:qlkcl/components/charts.dart';
import 'package:qlkcl/theme/app_theme.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ManagerHomePage extends StatefulWidget {
  @override
  _ManagerHomePageState createState() {
    return _ManagerHomePageState();
  }
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Trang chủ"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.help_outline),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_box_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          InfoManagerHomePage(
            title: "Xét nghiệm cần cập nhật",
            subtitle: "50",
            icon: WebsafeSvg.asset("assets/svg/xet_nghiem_cap_nhat.svg"),
            onTap: () {},
          ),
          InfoManagerHomePage(
            title: "Chờ xét duyệt",
            subtitle: "50",
            icon: WebsafeSvg.asset("assets/svg/cho_xet_duyet.svg"),
            onTap: () {},
          ),
          InfoManagerHomePage(
            title: "Nghi nhiễm",
            subtitle: "50",
            icon: WebsafeSvg.asset("assets/svg/nghi_nhiem.svg"),
            onTap: () {},
          ),
          InfoManagerHomePage(
            title: "Tới hạn xét nghiệm",
            subtitle: "50",
            icon: WebsafeSvg.asset("assets/svg/toi_han_xet_nghiem.svg"),
            onTap: () {},
          ),
          InfoManagerHomePage(
            title: "Sắp hoàn thành cách ly",
            subtitle: "50",
            icon: WebsafeSvg.asset("assets/svg/sap_hoan_thanh_cach_ly.svg"),
            onTap: () {},
          ),
          Container(
            height: 400,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text("Thống kê người cách ly"),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GroupedFillColorBarChart.withSampleData(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: CustomColors.secondary,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Trang chủ',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Người cách ly',
            icon: Icon(Icons.groups_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Quét mã',
            icon: Icon(Icons.qr_code_scanner),
          ),
          BottomNavigationBarItem(
            label: 'Khu cách ly',
            icon: Icon(Icons.apartment_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Tài khoản',
            icon: Icon(Icons.person_outline),
          ),
        ],
      ),
    );
  }
}
