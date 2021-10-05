import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gadha/comman/cubits/auth_cubit/authantication_cubit.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:gadha/modules/shared/auth/confirm_code/cubit/confirm_code_cubit.dart';
import 'package:gadha/modules/shared/auth/login/cubit/login_cubit.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class EnterPinCode extends StatefulWidget {
  const EnterPinCode({Key? key}) : super(key: key);
  @override
  _EnterAndChechPinCodeState createState() => _EnterAndChechPinCodeState();
}

class _EnterAndChechPinCodeState extends State<EnterPinCode> {
  final _formKey = GlobalKey<FormState>();
  final _countdownController = CountdownController();
  final _pinFieldController = TextEditingController();

  // void _handleCodeResend() {
  //   Auth
  // }
  void _handleConfirmCode() {
    final text = _pinFieldController.text;
    if (text.isNotEmpty) {
      ConfirmCodeCubit.of(context).checkCode(_pinFieldController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const StanderedAppBar(),
        body: SafeArea(
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
                      end: Alignment.topRight,
                      begin: Alignment.bottomLeft,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -70,
                right: -15,
                child: SvgPicture.asset(
                  Constants.logoWaterMark,
                  height: size.height * 0.35,
                  width: size.width * 0.9,
                ),
              ),
              Positioned(
                top: size.height * 0.16,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'we_will_send_you_code_to_number'.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                color: Colors.grey,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: AuthCubit.of(context).phoneNo,
                          style: const TextStyle(
                            fontSize: 15,
                            shadows: [
                              Shadow(
                                color: Colors.grey,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        const TextSpan(text: '  '),
                        TextSpan(
                          text: 'edit_number'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightTextGreen,
                            fontSize: 15,
                            shadows: [
                              Shadow(color: Colors.grey, blurRadius: 10)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: size.height * 0.25,
                child: Container(
                  height: size.height,
                  decoration: const BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06,
                    vertical: size.width * 0.05,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'enter_4_numbers_code'.tr,
                          style: const TextStyle(
                            color: AppColors.boldBlack,
                            fontSize: 12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: _buildPinTextField(),
                        ),
                        BlocConsumer<ConfirmCodeCubit, ConfirmCodeState>(
                          listener: (context, state) {
                            if (state is ValidAuthCode) {
                              Q.alertWithSuccess('right_pin_code'.tr);
                            } else if (state is ConfirmCodeError) {
                              Q.alertWithErr(state.msg);
                            }
                          },
                          builder: (context, state) {
                            final loading = state is TryingToConfirmCode ||
                                state is TryingToSendCode;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CustomMainButton(
                                onTap: _handleConfirmCode,
                                borderRaduis: 25,
                                text: 'activate'.tr,
                                textSize: 17.5,
                                fontWeight: FontWeight.bold,
                                height: size.height * 0.055,
                                isLoading: loading,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.05),
                        _buildResendCounter(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResendCounter() {
    return Countdown(
      seconds: 75,
      controller: _countdownController,
      build: (context, time) {
        final showResetBottom = time.toInt() == 0;
        final minutes = time >= 60 ? (time / 60).round() : 0;
        final seconds = (time - minutes * 60).round();
        return GestureDetector(
          onTap: () {
            // _handleCodeResend();
            if (showResetBottom) {
              _countdownController.restart();
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'resend_code'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: showResetBottom ? Colors.black : Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$minutes:${seconds < 10 ? 0 : ''}${seconds.toInt()}',
                    style: TextStyle(
                      color: !showResetBottom ? Colors.black : Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Directionality _buildPinTextField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: size.width * 0.6,
        child: Form(
          key: _formKey,
          child: PinCodeTextField(
            controller: _pinFieldController,
            length: 4,
            appContext: context,
            keyboardAppearance: Brightness.dark,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 60,
              fieldWidth: (45 * size.width) / 360,
              activeFillColor: Colors.white,
              inactiveColor: Colors.grey[400],
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.black12,
              selectedColor: AppColors.lightGreen,
              activeColor: AppColors.lightGreen,
              borderWidth: 1.3,
            ),
            keyboardType: TextInputType.number,
            cursorColor: Colors.transparent,
            animationDuration: const Duration(milliseconds: 200),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            beforeTextPaste: (text) {
              log('Do you want to paste $text');
              return true;
            },
            onCompleted: (_) => _handleConfirmCode(),
            onSubmitted: (_) {},
            onChanged: (_) {},
          ),
        ),
      ),
    );
  }
}
