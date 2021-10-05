import 'package:flutter/material.dart';
import 'package:gadha/modules/shared/scaffold.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class Pending extends StatelessWidget {
  const Pending({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GadhaScaffold(
      title: 'pending_account'.tr,
      children: [
        SizedBox(
          height: size.height * 0.50,
          child: Center(
            child: Text(
              'plase_wait_untill_we_review_your_account'.tr,
              style: textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
