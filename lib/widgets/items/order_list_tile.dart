import 'package:flutter/material.dart';
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:queen/queen.dart';

class OrderListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Widget? subtitle;
  final Widget? bottom;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  const OrderListTile({
    Key? key,
    this.leading,
    this.onTap,
    this.trailing,
    this.title,
    this.subtitle,
    this.bottom,
    this.contentPadding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: margin,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                leading ?? Container(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      title ?? Container(),
                      subtitle ?? Container(),
                    ],
                  ),
                ),
                trailing ?? Container(),
              ],
            ),
            if (bottom != null) bottom!,
          ],
        ),
      ),
    );
  }
}

class ListTileIconRow extends StatelessWidget {
  final String? title;
  final IconData icon;
  final bool isBold;
  const ListTileIconRow({
    Key? key,
    required this.title,
    required this.icon,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FaIcon(
            icon,
            size: 15,
            color: AppColors.darkGreen,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: ShowMoreText(
              title!,
              maxLength: 33,
              showMoreText: '',
              style: TextStyle(
                color: isBold ? AppColors.boldBlack : AppColors.lightBlack,
                fontSize: 10,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
