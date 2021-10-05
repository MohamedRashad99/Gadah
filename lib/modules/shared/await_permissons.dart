import 'package:flutter/material.dart';
import 'package:gadha/comman/cubits/auth_cubit/authantication_cubit.dart';

import 'package:gadha/modules/shared/scaffold.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class AwaitForPermissions extends StatelessWidget {
  const AwaitForPermissions({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GadhaScaffold(
      title: 'pending_account'.tr,
      children: [
        SizedBox(
          height: height * .50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'not Ready'.tr,
                style: textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              OutlinedButton(
                onPressed: AuthCubit.of(context).checkUserAuthStats,
                child: const Text('requrest permissons'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
