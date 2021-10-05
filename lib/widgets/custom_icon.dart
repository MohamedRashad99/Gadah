// ignore: import_of_legacy_library_into_null_safe
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';

class CIcon extends StatelessWidget {
  final bool isChoosen;
  final IconData? icon;
  final bool activateBadge;
  final bool giveSpecialSize;

  ///index `0`  `active`
  ///index `1`  `inactive`
  final List<double>? specialSize;
  const CIcon({
    Key? key,
    this.isChoosen = false,
    this.icon,
    this.activateBadge = false,
    this.giveSpecialSize = false,
    this.specialSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      showBadge: activateBadge,
      position: BadgePosition.topEnd(end: 3, top: 0),
      badgeColor: AppColors.bloodRed,
      badgeContent: Container(),
      child: Icon(
        icon,
        size: giveSpecialSize ? specialSize![1] : 25,
        color: isChoosen ? AppColors.lightGreen : AppColors.boldBlack,
      ),
    );
  }
}
