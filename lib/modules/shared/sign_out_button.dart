import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gadha/comman/cubits/auth_cubit/authantication_cubit.dart';
import 'package:gadha/widgets/items/user_info_item.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return UserInfoItem(
      onTap: () async {
        final signOutPressed = await Q.dialog<bool>(PlatformAlertDialog(
          title: Text(
            'sign_out_b'.tr,
            style: const TextStyle(color: Colors.red),
          ),
          content: Text('signing_out'.tr),
          actions: <Widget>[
            PlatformDialogAction(
              onPressed: () => Q.back(false),
              child: PlatformText('cancel'.tr),
            ),
            PlatformDialogAction(
              onPressed: () => Q.back(true),
              child: PlatformText('sign_out'.tr),
            ),
          ],
        ));
        if (signOutPressed != null && signOutPressed) {
          await AuthCubit.of(context).logout(context);
        }
      },
      leadingIcon: FontAwesomeIcons.signOutAlt,
      title: 'sign_out'.tr,
      trailing: const SizedBox(),
    );
  }
}
