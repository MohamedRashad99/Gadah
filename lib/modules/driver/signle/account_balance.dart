import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/app.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import 'bank_validation_upload.dart';

class DriverAccountBalance extends StatelessWidget {
  final String depitAmount;

  const DriverAccountBalance({
    Key? key,
    required this.depitAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            StanderedAppBar(
              appBarType: AppBarType.navigatorExtended,
              centerChild: Text(
                'bank_bills'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
                child: Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.lightGreen,
                        child: Icon(
                          FontAwesomeIcons.dollarSign,
                          size: size.width * 0.15,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('deptit_amount'.tr,
                          style: const TextStyle(fontSize: 20)),
                      Text('${'you_have_to_pay'.tr}  $depitAmount  ${'rs'.tr}',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(AppConfig.bankAccountOwner),
                      Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              const Text('حساب الاهلي'),
                              const SizedBox(
                                width: 10.0,
                              ),
                              const Text(AppConfig.elAhlyAccount),
                              const Spacer(),
                              CustomMainButton(
                                text: 'copy'.tr,
                                onTap: () {
                                  Clipboard.setData(const ClipboardData(
                                          text: AppConfig.elAhlyAccount))
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                AppConfig.elAhlyAccount +
                                                    'copy'.tr)));
                                  });
                                },
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              const Text('ايبان'),
                              const SizedBox(
                                width: 10.0,
                              ),
                              const Text(AppConfig.elAhlyIban),
                              const Spacer(),
                              CustomMainButton(
                                text: 'copy'.tr,
                                onTap: () {
                                  Clipboard.setData(const ClipboardData(
                                          text: AppConfig.elAhlyIban))
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(AppConfig.elAhlyIban +
                                                'copy'.tr)));
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              const Text(
                                'مصرف الراجحي',
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              const Text(AppConfig.araghyAccount),
                              const Spacer(),
                              CustomMainButton(
                                text: 'copy'.tr,
                                onTap: () {
                                  Clipboard.setData(const ClipboardData(
                                          text: AppConfig.araghyAccount))
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                AppConfig.araghyAccount +
                                                    'copy'.tr)));
                                  });
                                },
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              const Text(
                                'ايبان',
                                style: TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              const Text(AppConfig.alraghyIban),
                              const Spacer(),
                              CustomMainButton(
                                text: 'copy'.tr,
                                onTap: () {
                                  Clipboard.setData(const ClipboardData(
                                          text: AppConfig.alraghyIban))
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                AppConfig.alraghyIban +
                                                    'copy'.tr)));
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: size.height * 0.2),
                      Text(
                        'you_should_upload_validation'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () => Q.to(const BankValidationUpload()),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        icon: const Icon(CupertinoIcons.cloud_upload),
                        label: Text('upload_bank_validation'.tr),
                      )
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
