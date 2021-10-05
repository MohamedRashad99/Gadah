import 'package:flutter/material.dart';
import 'package:gadha/modules/shared/scaffold.dart';
import 'package:gadha/modules/shared/user_settings/change_user_acount_data.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class Refused extends StatelessWidget {
  final String? blockReason;
  const Refused(this.blockReason, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GadhaScaffold(
      title: 'refuesd_account'.tr,
      children: [
        Text(
          'plase_update_your_data'.tr,
          style: textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * 0.50,
          child: Center(
            child: Text(
              blockReason ?? '',
              style: textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        CustomMainButton(
          text: 'edit_acount_data'.tr,
          onTap: () => Q.to(const ChangeUserInfo()),
          borderRaduis: 25,
          textSize: textTheme.headline6!.fontSize,
          fontWeight: FontWeight.bold,
          height: size.height * 0.06,
        ),
      ],
    );
  }
}
