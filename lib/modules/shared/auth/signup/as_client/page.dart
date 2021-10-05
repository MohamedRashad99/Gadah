import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/models/dtos/sign_up_as_client.dart';
import 'package:gadha/comman/models/shared/user.dart';
import 'package:gadha/comman/validation/ksa_phone_no.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/modules/shared/auth/confirm_code/page.dart';
import 'package:gadha/modules/shared/auth/signup/as_client/cubit/sign_up_as_client_cubit.dart';
import 'package:gadha/widgets/signle/text_field.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:gadha/widgets/pickers/gender_picker.dart';
import 'package:gadha/widgets/pickers/image_uploader.dart';

class SignUpAsClient extends StatefulWidget {
  const SignUpAsClient({Key? key}) : super(key: key);

  @override
  _SignUpAsClientState createState() => _SignUpAsClientState();
}

class _SignUpAsClientState extends State<SignUpAsClient> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _stcController = TextEditingController();
  final _phoneController = TextEditingController();
  UserGender _gender = UserGender.male;
  bool _isStcPaySameAsMobileNumber = false;
  File? _userImage;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _stcController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      await SignUpAsClientCubit.of(context).signUpAsClient(SignUpAsClientDto(
        name: _userNameController.text.trim(),
        email: _emailController.text.trim(),
        gender: _gender,
        image: _userImage,
        stcpay: _stcController.text.trim(),
        phone: _phoneController.text.trim(),
      ));
    } else {
      Q.alertWithErr('not_valid_form'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const StanderedAppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.25,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Container(
                          height: size.height * 0.25,
                          decoration: BoxDecoration(
                            gradient: AppColors.famousGradient(
                              end: Alignment.centerRight,
                              begin: Alignment.centerLeft,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -90,
                        right: -15,
                        child: SvgPicture.asset(
                          Constants.logoWaterMark,
                          height: size.height * 0.35,
                          width: size.width * 0.9,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 15,
                        child: InkWell(
                          onTap: Q.back,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'back'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                shadows: [
                                  Shadow(color: Colors.grey, blurRadius: 10)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.18,
                        left: 0,
                        right: 0,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'sign_up_as_client'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              shadows: [
                                Shadow(color: Colors.grey, blurRadius: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(size.width * 0.06,
                      size.width * 0.05, size.width * 0.06, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            UserPhotoUpload(
                                onImageSubmit: (f) => _userImage = f),
                            SizedBox(width: width * 0.05),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'personal_pic'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                Text(
                                  "mustn't_5 mega".tr,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                        GadhaTextField(
                          controller: _userNameController,
                          labelText: 'name'.tr,
                          hintText: 'name'.tr,
                          prefixIcon: const Icon(FontAwesomeIcons.user),
                          validator: qValidator([
                            IsRequired('enter_your_name'.tr),
                            MinLength(10, 'name_is_too_short'.tr),
                          ]),
                        ),
                        GadhaTextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'e-mail'.tr,
                          hintText: 'example@gmail.com',
                          prefixIcon: const Icon(Icons.mail_outline),
                          validator: qValidator([
                            // IsRequired('enter_your_email'.tr),
                            const IsOptional(),
                            IsEmail('please_re_enter_e-mail'.tr),
                          ]),
                        ),
                        GadhaTextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          labelText: 'phone'.tr,
                          prefixIcon: const Icon(Icons.mail_outline),
                          onChanged: (_) => _isStcPaySameAsMobileNumber
                              ? _stcController.text = _.trim()
                              : null,
                          validator: qValidator([
                            IsRequired('enter_your_phone_no'.tr),
                            const KsaPhoneNumber(),
                          ]),
                        ),
                        GadhaTextField(
                          enabled: !_isStcPaySameAsMobileNumber,
                          controller: _stcController,
                          keyboardType: TextInputType.number,
                          labelText: 'stc_number'.tr,
                          hintText: '123456789',
                          prefixIcon: const Icon(Icons.phone_iphone),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  width: 1,
                                  color: Colors.grey[300],
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                ),
                                const Text(
                                  '+966',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          validator: qValidator(const [
                            IsOptional(),
                            KsaPhoneNumber(),
                          ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'same_as_phone_number'.tr,
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _isStcPaySameAsMobileNumber,
                                onChanged: (value) {
                                  setState(() {
                                    _isStcPaySameAsMobileNumber = value!;
                                    if (_isStcPaySameAsMobileNumber) {
                                      _stcController.text =
                                          _phoneController.text;
                                    } else {
                                      _stcController.clear();
                                    }
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        GenderPicker(onChanged: (gender) => _gender = gender),
                        SizedBox(height: size.height * 0.05),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 10),
                          child: BlocConsumer<SignUpAsClientCubit,
                              SignUpAsClientState>(
                            listener: (context, state) {
                              if (state is SignUpSucessd) {
                                Q.to(const EnterPinCode());
                              } else if (state is CantSignUp) {
                                Q.alertWithErr(state.error.firstErrorMessage);
                              } else if (state is UnknownError) {
                                Q.alertWithErr(state.msg);
                              }
                            },
                            builder: (context, state) {
                              final loading = state is RegisterInProgress;
                              return CustomMainButton(
                                onTap: _signUp,
                                borderRaduis: 25,
                                text: 'sign_in_b'.tr,
                                textSize: 16,
                                fontWeight: FontWeight.bold,
                                height: size.height * 0.06,
                                isLoading: loading,
                              );
                            },
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
