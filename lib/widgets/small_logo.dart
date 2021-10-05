import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:queen/queen.dart';

class SmallLogo extends StatelessWidget {
  const SmallLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
        child: Padding(
          padding: EdgeInsets.zero,
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
    );
  }
}
