import 'package:flutter/material.dart';
import 'package:gadha/modules/shared/scaffold.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class Blocked extends StatelessWidget {
  final String? blockReason;
  const Blocked(this.blockReason, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GadhaScaffold(
      title: 'blocked_account'.tr,
      children: [
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
      ],
    );
  }
}
