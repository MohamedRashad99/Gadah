import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/modules/shared/auth/confirm_code/page.dart';
import 'package:gadha/modules/shared/auth/login/cubit/login_cubit.dart';
import 'package:gadha/modules/shared/auth/signup/as_client/page.dart';
import 'package:gadha/modules/shared/auth/signup/as_driver/page.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class EnterPhoneNoPage extends StatelessWidget {
  EnterPhoneNoPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = LoginCubit.of(context);

    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: const StanderedAppBar(),
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.famousGradient(
                        begin: Alignment.bottomLeft, end: Alignment.topRight),
                  ),
                ),
                Positioned(
                  top: -80,
                  right: -15,
                  child: SvgPicture.asset(Constants.logoWaterMark,
                      height: size.height * 0.35, width: size.width * 0.9),
                ),
                Positioned(
                  top: size.height * 0.12,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(Constants.hLogo,
                      width: size.width * 0.55),
                ),
                Positioned.fill(
                  top: size.height * 0.25,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Container(
                      height: size.height,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: size.width * 0.05,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'we_will_send_you_code'.tr,
                              style: textTheme.bodyText1!.copyWith(
                                color: AppColors.darkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: _buildPhoneNumberTextField(),
                            ),
                            Column(
                              children: <Widget>[
                                BlocConsumer<LoginCubit, LoginState>(
                                  listener: (context, state) async {
                                    if (state is CodeSent) {
                                      Q.alertWithSuccess(state.msg);
                                      // Q.alertWithSuccess('code_has_been_sent_to_your_phone'.tr);
                                      await Q.to(const EnterPinCode());
                                    } else if (state is MustSignUpFirst) {
                                      Q.alertWithErr('must_sign_up_first'.tr);
                                    } else if (state is CantSendCode) {
                                      Q.alertWithErr(state.msg);
                                    }
                                  },
                                  builder: (context, state) {
                                    final isLoading = state is TryingToSendCode;
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20, top: 10),
                                      child: CustomMainButton(
                                        onTap: isLoading
                                            ? null
                                            : () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  await cubit.loginWithPhoneNo(
                                                      _phoneNoController.text
                                                          .trim());
                                                }
                                              },
                                        text: 'login'.tr,
                                        borderRaduis: 25,
                                        textSize: textTheme.headline6!.fontSize,
                                        fontWeight: FontWeight.bold,
                                        height: size.height * 0.06,
                                        isLoading: isLoading,
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: size.height * 0.05),
                                CustomMainButton(
                                  text: 'sign_up_as_client'.tr,
                                  onTap: () => Q.to(const SignUpAsClient()),
                                  borderRaduis: 25,
                                  textSize: textTheme.headline6!.fontSize,
                                  fontWeight: FontWeight.bold,
                                  height: size.height * 0.06,
                                ),
                                SizedBox(height: size.height * 0.02),
                                CustomMainButton(
                                  text: 'sign_up_as_driver'.tr,
                                  onTap: () => Q.to(const SignUpAsDriver()),
                                  borderRaduis: 25,
                                  textSize: textTheme.headline6!.fontSize,
                                  fontWeight: FontWeight.bold,
                                  height: size.height * 0.06,
                                ),
                                SizedBox(height: size.height * 0.05),
                                Text(
                                  'terms_of_servis'.tr,
                                  textAlign: TextAlign.center,
                                  style: textTheme.bodyText1!.copyWith(
                                    color: AppColors.lightBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildPhoneNumberTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Theme(
            data: ThemeData(
                primaryColor: AppColors.lightBlack,
                primaryColorDark: AppColors.lightBlueAccent),
            child: TextFormField(
                controller: _phoneNoController,
                keyboardType: TextInputType.number,
                keyboardAppearance: Brightness.dark,
                decoration: InputDecoration(
                  labelText: 'phone_number'.tr,
                  labelStyle: TextStyle(
                    color: AppColors.boldBlack.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  hintText: 'xxx xxx xxxx',
                  prefixIcon: const Icon(Icons.phone_iphone),
                  focusColor: AppColors.lightBlack,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: qValidator([
                  MinLength(9, 'phone_number_is_too_short'.tr),
                  MaxLength(12, 'phone_number_is_too_long'.tr),
                ])),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.lightBlack, width: 1.3),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('+966', textDirection: TextDirection.ltr),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
