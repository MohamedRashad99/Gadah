import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/models/dtos/sign_up_as_driver.dart';
import 'package:gadha/comman/models/shared/user.dart';
import 'package:gadha/comman/validation/ksa_phone_no.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/modules/shared/auth/confirm_code/page.dart';
import 'package:gadha/modules/shared/auth/signup/as_driver/cubit/sign_up_as_drvier_cubit.dart';
import 'package:gadha/widgets/signle/text_field.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:gadha/widgets/pickers/gender_picker.dart';
import 'package:gadha/widgets/pickers/image_uploader.dart';
import 'package:gadha/widgets/pickers/image_uploader_widget.dart';

class SignUpAsDriver extends StatefulWidget {
  const SignUpAsDriver({Key? key}) : super(key: key);
  @override
  _SignUpAsDriverState createState() => _SignUpAsDriverState();
}

class _SignUpAsDriverState extends State<SignUpAsDriver> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _stcController = TextEditingController();
  final _natuinalCardDataController = TextEditingController();
  final _carDataController = TextEditingController();
  final _phoneController = TextEditingController();
  UserGender _gender = UserGender.male;
  bool _isStcPaySameAsMobileNumber = false;
  File? _userImage;
  File? _idImage;
  File? _licenseImage;
  File? _formImage;
  List<File>? _carImages;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _emailController.dispose();
    _stcController.dispose();
    _natuinalCardDataController.dispose();
    _carDataController.dispose();
    super.dispose();
  }

  void _validateFormImages() {
    if (_idImage == null) {
      throw 'id_image_is_missing'.tr;
    } else if (_licenseImage == null) {
      throw 'license_image_is_missing'.tr;
    } else if (_carImages == null) {
      throw 'car_image_is_missing'.tr;
    } else if (_carImages!.length < 2) {
      throw 'car_image_is_missing_2'.tr;
    } else if (_userImage == null) {
      throw 'must_pick_image'.tr;
    }
  }

  Future<void> _signUp() async {
    try {
      // if uploaded form image
      // no need for other car info
      if (_formImage == null) {
        _validateFormImages();
      }
      if (_formKey.currentState!.validate()) {
        await SignUpAsDrvierCubit.of(context).signUpAsDriver(
          SignUpAsDriverDto(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            gender: _gender,
            image: _userImage,
            carBackImg: _carImages?.first,
            carFrontImg: _carImages?.last,
            carFormImg: _formImage,
            idCardImage: _idImage,
            carLicenseImg: _licenseImage,
            stcpay: _stcController.text.trim(),
            idNumber: _natuinalCardDataController.text.trim(),
            carNumber: _carDataController.text.trim(),
            phone: _phoneController.text.trim(),
            formImage: _formImage,
          ),
        );
      } else {
        throw 'not_valid_form'.tr;
      }
    } catch (e) {
      Q.alertWithErr(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    const kLongInScreentextFieldStyle =
        TextStyle(color: Colors.grey, fontSize: 12);
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
                              begin: Alignment.bottomLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -60,
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
                            text: 'sign_up_as_driver'.tr,
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
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(size.width * 0.06,
                      size.width * 0.05, size.width * 0.06, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            UserPhotoUpload(
                                onImageSubmit: (f) => _userImage = f),
                            SizedBox(width: size.width * 0.05),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'personal_pic'.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "mustn't_5 mega".tr,
                                  style: kLongInScreentextFieldStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                        GadhaTextField(
                          controller: _nameController,
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
                          validator: qValidator([
                            const IsOptional(),
                            const KsaPhoneNumber(),
                          ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('same_as_phone_number'.tr),
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
                        GadhaTextField(
                          controller: _natuinalCardDataController,
                          labelText: 'personal_id_num'.tr,
                          hintText: '123456789',
                          prefixIcon: const Icon(FontAwesomeIcons.idCard),
                          validator: qValidator([
                            if (_formImage == null) ...[
                              IsRequired('enter_personal_id'.tr),
                              MinLength(8, 'too_short'.tr),
                            ]
                          ]),
                        ),
                        GenderPicker(onChanged: (g) => _gender = g),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: size.height * 0.05),
                            const Icon(FontAwesomeIcons.carAlt),
                            const SizedBox(width: 5),
                            Text('vehicle'.tr),
                          ],
                        ),
                        GadhaTextField(
                            controller: _carDataController,
                            labelText: 'vehicle_number'.tr,
                            hintText: 'vehicle_number'.tr,
                            prefixIcon: const Icon(FontAwesomeIcons.car),
                            validator: qValidator([
                              if (_formImage == null)
                                MinLength(3, 'please_re_enter_number'.tr),
                            ])),
                        const Divider(),
                        SizedBox(height: size.height * 0.01),
                        ImageUploader(
                          onFilesPicked: (i) =>
                              setState(() => _idImage = i.first),
                          title: 'personal_id_pic'.tr,
                          subTitle: 'form_should_be_valid_id'.tr,
                        ),
                        SizedBox(height: size.height * 0.01),
                        ImageUploader(
                          onFilesPicked: (i) =>
                              setState(() => _formImage = i.first),
                          title: 'form_photo'.tr,
                          subTitle: 'form_should_be_valid'.tr,
                        ),
                        SizedBox(height: size.height * 0.01),
                        ImageUploader(
                          onFilesPicked: (i) =>
                              setState(() => _licenseImage = i.first),
                          title: 'personal_driving_license_pic'.tr,
                          subTitle: 'form_should_be_valid_license'.tr,
                        ),
                        SizedBox(height: size.height * 0.01),
                        ImageUploader(
                          maxCount: 2,
                          onFilesPicked: (i) => setState(() => _carImages = i),
                          title: 'vehicle_photoes'.tr,
                          subTitle: 'front_rear_vehicle_pics'.tr,
                        ),
                        BlocConsumer<SignUpAsDrvierCubit, SignUpAsDrvierState>(
                          listener: (context, state) {
                            if (state is SignUpSucessd) {
                              Q.to(const EnterPinCode());
                            } else if (state is CantSignUp) {
                              Q.alertWithErr(state.error);
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
