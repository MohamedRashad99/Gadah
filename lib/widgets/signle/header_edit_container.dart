import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:get/get.dart';

class HeaderAndEditContainer extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Widget? trailing;

  const HeaderAndEditContainer({
    Key? key,
    required this.title,
    this.onTap,
    this.padding,
    this.color,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          gradient: color == null
              ? LinearGradient(
                  colors: [
                    const Color(0xffFDEDFE),
                    const Color(0xffFDEDFE).withAlpha(200),
                    const Color(0xffE8FDFF),
                  ],
                  end: Alignment.centerLeft,
                  begin: Alignment.centerRight,
                )
              : null,
        ),
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: 5,
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: AppColors.boldBlack,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            if (onTap != null && trailing == null)
              Text(
                'edit'.tr,
                style: const TextStyle(
                  color: AppColors.boldBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              )
            else
              trailing ?? Container(),
          ],
        ),
      ),
    );
  }
}
