import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:get/get.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

class ServicesRatings extends StatelessWidget {
  const ServicesRatings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const StanderedAppBar(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              StanderedAppBar(
                appBarType: AppBarType.navigatorExtended,
                extendedTitle: 'services_ratings'.tr,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(Constants.splashScreenShadow),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'no_services_ratings'.tr,
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.darkGreenAccent.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
