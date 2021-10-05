import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gadha/modules/client/catigories/view.dart';
import 'package:gadha/modules/client/home/views/home_near_by/view.dart';
import 'package:gadha/modules/client/home/views/home_serach_field.dart';
import 'package:gadha/modules/shared/slider/view.dart';
import 'package:gadha/modules/shared/user_profile/page.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:gadha/widgets/signle/header_edit_container.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: Column(
              children: [
                StanderedAppBar(
                  appBarType: AppBarType.homeExtended,
                  onTap: () => Q.to(const UserProfile()),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: height * .025),
                      const HomeSearchTextField(),
                      HomeSlider(),
                      HeaderAndEditContainer(title: 'near_by_shops'.tr),
                      SizedBox(height: height * .015),
                      Container(
                        constraints: BoxConstraints(maxHeight: height * .11),
                        width: width,
                        child: const HomeNearBy(),
                      ),
                      SizedBox(height: height * .01),
                      HeaderAndEditContainer(title: 'our_services'.tr),
                      SizedBox(height: height * .025),
                      const HomeCategories(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
