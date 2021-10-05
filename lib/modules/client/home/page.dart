import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/modules/client/bot_chat/page.dart';
import 'package:gadha/modules/client/orders/client_orders.dart';
import 'package:gadha/modules/shared/notification_tab/notification_screen.dart';
import 'package:gadha/widgets/custom_icon.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:queen/queen.dart';
import 'package:gadha/widgets/navigation_bar/curved_navigation_bar.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:flutter/material.dart';

import '../auth_builder.dart';
import 'tabs/home_tab.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key? key}) : super(key: key);

  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  final _screens = const <Widget>[
    SizedBox(),
    AuthBuild(NotificationScreen()),
    AuthBuild(ClientOrders()),
    HomeTab(),
  ];
  final _iconsData = [
    Icons.notifications,
    Icons.notifications,
    FontAwesomeIcons.listUl,
    Icons.store,
  ];
  bool get isHomeSreenSelected => _controller.index == _screens.length - 1;

  @override
  void initState() {
    _controller = TabController(
      vsync: this,
      length: _screens.length,
      initialIndex: _screens.length - 1,
    );
    _controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StanderedAppBar(),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            TabBarView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: _screens,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                height: height * .10,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: CurvedNavigationBar(
                        height: 50,
                        backgroundColor: AppColors.transparent,
                        index: _controller.index,
                        items: List.generate(
                          _iconsData.length,
                          (i) => i == 0
                              ? const SizedBox()
                              : CIcon(
                                  // activateBadge: index == 1 && _dotProvider.showDot!,
                                  icon: _iconsData[i],
                                  isChoosen: _controller.index == i,
                                  specialSize: const [27, 22],
                                  giveSpecialSize: i == 2,
                                ),
                        ),
                        onTap: (index) {
                          if (_controller.index != index && index != 0) {
                            setState(() => _controller.index = index);
                          }
                        },
                      ),
                    ),
                    Positioned.directional(
                      bottom: 25,
                      end: width * .03,
                      textDirection: TextDirection.ltr,
                      child: _buildHomeScreenIcon(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHomeScreenIcon() {
    return Container(
      height: width * .17,
      width: width * .17,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.famousGradient(
            end: Alignment.bottomRight, begin: Alignment.topLeft),
        boxShadow: const [
          BoxShadow(color: Colors.black38, spreadRadius: 0.2, blurRadius: 10)
        ],
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.zero,
          child: InkWell(
            onTap: () => Q.to(const BotChatPage()),
            child: Material(
              color: Colors.transparent,
              child: SvgPicture.asset(
                Constants.miniLogo,
                color: Colors.white,
                height: width * .12,
                width: width * .12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
