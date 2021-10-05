import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/modules/shared/complains/page.dart';
import 'package:gadha/widgets/dialogs/change_lang_dialog.dart';
import 'package:gadha/modules/shared/terms_of_service/page.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/comman/services/settings_service.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

import 'change_user_acount_data.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
              _buildUserDataSummury(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () => Q.dialog(const ChangeLang()),
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.language),
                      title: Text('app_lang'.tr),
                      subtitle: Text('this_lang_name'.tr),
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.phone),
                      title: Text('phone_number'.tr),

                      subtitle: Text(
                        AuthService.currentUser?.phone ?? '',
                        style:
                            const TextStyle(color: AppColors.darkGreenAccent),
                      ),
                      // onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () async {
                        final data = await SettingsService().getAppSettings();
                        await Q.to(TermsOfService(data));
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(FontAwesomeIcons.fileAlt),
                      title: Text('usage_policy'.tr),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () => Q.to(const ComplainsScreen()),
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(FontAwesomeIcons.alignRight),
                      title: Text('complains_list'.tr),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserDataSummury() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: ListTile(
        onTap: () => Q.to(const ChangeUserInfo()),
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.person),
        title: Text('update_account_data'.tr),
      ),
    );

    // return Container(
    //   width: size.width,
    //   height: size.height * 0.10,
    //   color: Colors.grey[200],
    //   padding: EdgeInsets.symmetric(horizontal: size.height * 0.015),
    //   child: ListTile(
    //     onTap: () => Q.to(const ChangeUserInfo()),
    //     leading: Stack(
    //       children: <Widget>[
    //         Stack(
    //           children: <Widget>[
    //             CircleAvatar(
    //               radius: 30,
    //               backgroundColor: AppColors.darkWhite,
    //               backgroundImage:
    //                   AuthService.currentUser?.image?.path == null ? null : NetworkImage(fullImagePath(AuthService.currentUser!.image!.path)!),
    //               child: AuthService.currentUser?.image == null ? const Icon(FontAwesomeIcons.userAlt, size: 40) : null,
    //             ),
    //           ],
    //         ),
    //         const Positioned(
    //           left: 0,
    //           bottom: 0,
    //           child: CircleAvatar(
    //             radius: 12,
    //             backgroundColor: AppColors.boldBlackAccent,
    //             child: Center(
    //               child: FaIcon(
    //                 FontAwesomeIcons.cog,
    //                 color: Colors.white,
    //                 size: 13,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     title: Text(
    //       AuthService.currentUser!.name,
    //       style: const TextStyle(
    //         fontSize: 12,
    //         color: AppColors.boldBlack,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //     subtitle: Text(
    //       AuthService.currentUser!.email,
    //       style: const TextStyle(
    //         fontSize: 10,
    //         color: Colors.grey,
    //       ),
    //     ),
    //     trailing: Text(
    //       'edit'.tr,
    //       style: const TextStyle(
    //         fontSize: 12,
    //         color: AppColors.darkGreen,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ),
    // );
  }
}
