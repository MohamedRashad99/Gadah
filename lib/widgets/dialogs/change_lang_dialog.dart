import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/functions.dart';

import 'package:gadha/widgets/buttons/custom_main_button.dart';

import 'package:get/get.dart';
import 'package:queen/queen.dart';

class ChangeLang extends StatefulWidget {
  const ChangeLang({Key? key}) : super(key: key);
  @override
  _ChangeLangState createState() => _ChangeLangState();
}

class _ChangeLangState extends State<ChangeLang> {
  Future<void> _onLangClicked(String locale) async {
    Get.updateLocale(Locale(locale));
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: SizedBox(
        height: height * 0.20,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'choose_device_lang'.tr,
                style: const TextStyle(fontSize: 17),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomMainButton(
                      outline: !isArabic,
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      borderRaduis: 10,
                      onTap: () => _onLangClicked('ar'),
                      text: 'عربي',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomMainButton(
                      outline: isArabic,
                      height: 50,
                      borderRaduis: 10,
                      onTap: () => _onLangClicked('en'),
                      text: 'English',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
