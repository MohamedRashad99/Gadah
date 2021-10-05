import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:queen/queen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // AuthBloc.of(context).checkUserAuthStats();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SvgPicture.asset(
              Constants.splashScreen,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.87,
              child: Container(
                height: height * 0.25,
                decoration: BoxDecoration(
                  gradient: AppColors.famousGradient(
                    end: Alignment.bottomLeft,
                    begin: Alignment.topRight,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: SvgPicture.asset(Constants.hLogo, width: width * 0.5),
          ),
        ],
      ),
    );
  }
}
