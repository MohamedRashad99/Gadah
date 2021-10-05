import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/shared/user.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/modules/client/home/page.dart';
import 'package:gadha/modules/driver/home/page.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:gadha/widgets/pickers/image_uploader.dart';
import 'package:gadha/widgets/signle/text_field.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

class ChangeUserInfo extends StatefulWidget {
  const ChangeUserInfo({Key? key}) : super(key: key);

  @override
  _ChangeUserInfoState createState() => _ChangeUserInfoState();
}

class _ChangeUserInfoState extends State<ChangeUserInfo> {
  User get currentUser => AuthService.currentUser!;
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  late TextEditingController _diplayName;
  late TextEditingController _diplayEmail;
  File? _newImage;
  @override
  void initState() {
    _diplayName = TextEditingController(text: currentUser.name);
    _diplayEmail = TextEditingController(text: currentUser.email);
    super.initState();
  }

  @override
  void dispose() {
    _diplayEmail.dispose();
    _diplayName.dispose();
    super.dispose();
  }

  Future<void> _handleUserDataUpdate() async {
    try {
      if (!_formKey.currentState!.validate()) return;

      setState(() => _isLoading = true);

      await AuthService().updateUser(
        email: _diplayEmail.text.trim(),
        name: _diplayName.text.trim(),
        image: _newImage,
      );

      Q.replaceAll(
        AuthService.currentUser!.isDriver
            ? const DriverHomePage()
            : const ClientHomePage(),
      );
    } catch (e, st) {
      L.e(st.toString());
      L.e(e.toString());
      Q.alertWithErr(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const StanderedAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                StanderedAppBar(
                  appBarType: AppBarType.navigatorExtended,
                  extendedTitle: 'your_details'.tr,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.width * 0.05,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            UserPhotoUpload(
                              initalImage: fullImagePath(currentUser.image),
                              onImageSubmit: (_imageFile) {
                                _newImage = _imageFile;
                              },
                            ),
                            SizedBox(width: size.width * 0.05),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'personal_pic'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text("mustn't_5 mega".tr),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        GadhaTextField(
                          controller: _diplayName,
                          labelText: 'name'.tr,
                          hintText: 'name'.tr,
                          prefixIcon: const Icon(FontAwesomeIcons.user),
                          validator: qValidator([
                            const IsRequired(),
                          ]),
                        ),
                        GadhaTextField(
                          controller: _diplayEmail,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'e-mail'.tr,
                          prefixIcon: const Icon(Icons.mail_outline),
                          validator: qValidator([
                            const IsRequired(),
                            const IsEmail(),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 10),
                                child: CustomMainButton(
                                  onTap: _handleUserDataUpdate,
                                  borderRaduis: 25,
                                  text: 'update'.tr,
                                  textSize: 16,
                                  fontWeight: FontWeight.bold,
                                  height: size.height * 0.06,
                                  isLoading: _isLoading,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
