import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:queen/queen.dart';

class OrderPopupRow extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final IconData icon;

  const OrderPopupRow({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.boldBlackAccent,
            ),
          ),
          FaIcon(
            icon,
            size: 16,
            color: AppColors.lightBlack.withAlpha(200),
          ),
        ],
      ),
    );
  }
}
