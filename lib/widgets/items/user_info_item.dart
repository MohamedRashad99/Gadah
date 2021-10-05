import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:queen/queen.dart';

class UserInfoItem extends StatelessWidget {
  final bool visable;
  final IconData leadingIcon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showTrailingAndArrow;
  const UserInfoItem({
    Key? key,
    required this.leadingIcon,
    required this.title,
    this.visable = true,
    this.trailing,
    this.onTap,
    this.showTrailingAndArrow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !visable
        ? const SizedBox()
        : InkWell(
            onTap: onTap,
            child: Padding(
              padding: _createTilePadding(),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        leadingIcon,
                        size: 16,
                        color: AppColors.darkGreen,
                      ),
                      SizedBox(width: width * .05),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.boldBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      if (showTrailingAndArrow) ...[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            trailing!,
                            const SizedBox(width: 5),
                            _buildArrow(context),
                          ],
                        )
                      ] else
                        trailing ?? _buildArrow(context)
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  EdgeInsetsGeometry _createTilePadding() {
    if (showTrailingAndArrow) {
      return const EdgeInsetsDirectional.only(
        top: 8,
        bottom: 8,
      );
    }
    return const EdgeInsets.symmetric(vertical: 8);
  }

  Directionality _buildArrow(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Icon(
        Icons.chevron_left,
        size: 20,
        color: AppColors.darkGreen,
      ),
    );
  }
}
