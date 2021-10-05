import 'package:flutter/cupertino.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:flutter/material.dart';

import 'package:gadha/modules/shared/notification_tab/notification_screen.dart';
import 'package:gadha/modules/shared/user_profile/page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'orders_tab/orders_tab.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);
  @override
  _AgentHomeState createState() => _AgentHomeState();
}

class _AgentHomeState extends State<DriverHomePage> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: const [
        OrdersScreen(),
        // OrdersInProgress(),
        NotificationScreen(),
        UserProfile(),
      ],
      navBarStyle: NavBarStyle.style12,
      items: <PersistentBottomNavBarItem>[
        PersistentBottomNavBarItem(
          title: '',
          iconSize: 22,
          icon: const Icon(CupertinoIcons.home),
          activeColorPrimary: AppColors.lightGreen,
          activeColorSecondary: AppColors.lightGreen,
        ),
        // PersistentBottomNavBarItem(
        //   title: '',
        //   iconSize: 22,
        //   icon: const Icon(Icons.local_shipping),
        //   activeColorPrimary: AppColors.lightGreen,
        //   activeColorSecondary: AppColors.lightGreen,
        // ),
        PersistentBottomNavBarItem(
          title: '',
          iconSize: 22,
          icon: const Icon(Icons.notifications),
          activeColorPrimary: AppColors.lightGreen,
          activeColorSecondary: AppColors.lightGreen,
        ),
        PersistentBottomNavBarItem(
          title: '',
          iconSize: 22,
          icon: const Icon(CupertinoIcons.person),
          activeColorPrimary: AppColors.lightGreen,
          activeColorSecondary: AppColors.lightGreen,
        ),
      ],
      bottomScreenMargin: 40,
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears.
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        colorBehindNavBar: Colors.white,
      ),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation:
          const ScreenTransitionAnimation(animateTabTransition: true),
    );
  }
}
