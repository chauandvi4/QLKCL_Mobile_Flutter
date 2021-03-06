import 'package:flutter/material.dart';
import 'package:qlkcl/config/routes.dart';
import 'package:qlkcl/screens/account/account_screen.dart';
import 'package:qlkcl/screens/error/error_screen.dart';
import 'package:qlkcl/screens/home/manager_home_screen.dart';
import 'package:qlkcl/screens/home/member_home_screen.dart';
import 'package:qlkcl/screens/members/list_all_member_screen.dart';
import 'package:qlkcl/screens/qr_code/qr_scan_screen.dart';
import 'package:qlkcl/screens/quarantine_ward/quarantine_list_screen.dart';
import 'package:qlkcl/config/app_theme.dart';

// cre: https://codewithandrea.com/articles/multiple-navigators-bottom-navigation-bar/

// cre: https://github.com/Kickbykick/Persistent-Bottom-Navigation-Bar

// cre: https://medium.com/@theboringdeveloper/common-bottom-navigation-bar-flutter-e3693305d2d

// cre: https://stackoverflow.com/questions/61414778/tabbarview-or-indexedstack-for-bottomnavigationbar-flutter

// cre: https://flutterui.design/blog/persistent-tabs

// cre: https://medium.com/flutter-community/bottom-navigation-which-state-is-saved-when-clicks-in-item-in-the-list-and-switches-between-bottom-bcf8ba3bc4a

// cre: https://www.vojtech.net/posts/flutter-bottom-navigation/

// new: https://pub.dev/packages/persistent_bottom_nav_bar

class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    required this.currentTab,
    required this.onSelectTab,
    required this.role,
  });
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final int role;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex:
          (role == 5) ? (currentTab.index ~/ 2).toInt() : currentTab.index,
      selectedItemColor: CustomColors.secondary,
      onTap: (index) => {
        index = (role == 5) ? index * 2 : index,
        if (TabItem.values[index] == TabItem.qr_code_scan)
          {Navigator.pushNamed(context, QrCodeScan.routeName)}
        else
          {
            onSelectTab(
              TabItem.values[index],
            )
          }
      },
      items: [
        _buildItem(TabItem.homepage),
        if (role != 5) _buildItem(TabItem.quarantine_person),
        _buildItem(TabItem.qr_code_scan),
        if (role != 5) _buildItem(TabItem.quarantine_ward),
        _buildItem(TabItem.account),
      ],
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      label: tabName[tabItem],
      icon: Icon(tabIcon[tabItem]),
    );
  }
}

enum TabItem {
  homepage,
  quarantine_person,
  qr_code_scan,
  quarantine_ward,
  account
}

const Map<TabItem, String> tabName = {
  TabItem.homepage: 'Trang ch???',
  TabItem.quarantine_person: 'Ng?????i c??ch ly',
  TabItem.qr_code_scan: 'Qu??t m??',
  TabItem.quarantine_ward: 'Khu c??ch ly',
  TabItem.account: 'T??i kho???n',
};

const Map<TabItem, IconData> tabIcon = {
  TabItem.homepage: Icons.home_outlined,
  TabItem.quarantine_person: Icons.groups_outlined,
  TabItem.qr_code_scan: Icons.qr_code_scanner,
  TabItem.quarantine_ward: Icons.apartment_outlined,
  TabItem.account: Icons.person_outline,
};

const Map<TabItem, String> tabRouteName = {
  TabItem.homepage: ManagerHomePage.routeName,
  TabItem.quarantine_person: ListAllMember.routeName,
  TabItem.qr_code_scan: QrCodeScan.routeName,
  TabItem.quarantine_ward: QuarantineListScreen.routeName,
  TabItem.account: Account.routeName,
};

const Map<TabItem, String> tabMemberRouteName = {
  TabItem.homepage: MemberHomePage.routeName,
  TabItem.qr_code_scan: QrCodeScan.routeName,
  TabItem.account: Account.routeName,
};

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.tabItem,
    required this.role,
  }) : super(key: key);

  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;
  final int role;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute:
          role == 5 ? tabMemberRouteName[tabItem] : tabRouteName[tabItem],
      onGenerateRoute: (settings) {
        Widget child;
        if (routes.containsKey(settings.name)) {
          child = routes[settings.name!]!(context);
        } else if (settings.name == "/") {
          return null;
        } else {
          child = Error();
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => child,
        );
      },
    );
  }
}
