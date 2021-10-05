import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/models/shared/setting_entity.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

class TermsOfService extends StatefulWidget {
  final SettingEntity settingEntity;

  const TermsOfService(this.settingEntity, {Key? key}) : super(key: key);
  @override
  _TermsOfServiceState createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const StanderedAppBar(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              StanderedAppBar(
                appBarType: AppBarType.navigatorExtended,
                extendedTitle: 'settings'.tr,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Text(widget.settingEntity.termsConditions ?? ''),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
