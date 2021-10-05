import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/modules/driver/home/orders_tab/in_porgress/tab.dart';
import 'package:gadha/modules/shared/user_profile/page.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import 'orders_done/tab.dart';
import 'to_offer/orders_to_offer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StanderedAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StanderedAppBar(
              appBarType: AppBarType.agentHomeExtended,
              textColor: Colors.white,
              profilePhotoUrl: fullImagePath(AuthService.currentUser!.image),
              onTap: () => Q.to(const UserProfile()),
            ),
            SizedBox(
              width: size.width,
              child: TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(vertical: 10),
                indicatorColor: AppColors.darkGreen,
                indicatorWeight: 3.5,
                labelColor: AppColors.boldBlack,
                tabs: <Widget>[
                  Text('orders_to_accept'.tr,
                      style: const TextStyle(fontSize: 14)),
                  Text('orders_in_progress'.tr,
                      style: const TextStyle(fontSize: 14)),
                  Text('orders_done'.tr, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  OrdersToOffer(),
                  OrdersInProgress(),
                  OrdersDone(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
