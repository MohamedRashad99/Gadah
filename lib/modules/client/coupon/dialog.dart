import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/modules/client/coupon/cubit/coupon_cubit.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class CouponDialog extends StatelessWidget {
  CouponDialog({Key? key}) : super(key: key);

  final _couponController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CouponCubit>(context);
    return BlocConsumer<CouponCubit, CouponState>(
      listener: (context, state) {
        if (state is CouponNotFound) {
          Q.alertWithErr('not_found_coupon'.tr);
        } else if (state is CouponLoaded) {
          if (state.coupon.isValid) {
            Q.back(state.coupon);
          } else {
            Q.alertWithErr('not_valid_coupon'.tr);
          }
        } else if (state is CouponError) {
          Q.alertWithErr(state.msg);
        }
      },
      builder: (context, state) {
        late Widget child;
        if (state is CouponLoading) {
          child = const CenterLoading();
        } else {
          child = Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'add_discount_coupon'.tr,
                style: const TextStyle(
                  color: AppColors.boldBlack,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildCouponTextField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: CustomMainButton(
                      onTap: () {
                        try {
                          if (_key.currentState!.validate()) {
                            cubit.check(_couponController.text.trim());
                          }
                        } catch (e) {
                          log('ERROR WHILE CHECKING COUPON #');
                        }
                      },
                      text: 'enter'.tr,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      borderRaduis: 15,
                      fontWeight: FontWeight.bold,
                      height: 55,
                      // isLoading: _isLoading,
                    ),
                  ),
                  CustomMainButton(
                    outline: true,
                    height: 55,
                    onTap: Q.back,
                    text: 'cancel'.tr,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    borderRaduis: 15,
                    fontWeight: FontWeight.bold,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ],
              ),
            ],
          );
        }
        return Form(
          key: _key,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  height: height * .25,
                  width: width * .80,
                  child: child),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCouponTextField() {
    return Theme(
      data: ThemeData(
        primaryColor: AppColors.lightBlack,
        primaryColorDark: AppColors.lightBlueAccent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: TextFormField(
          controller: _couponController,
          keyboardAppearance: Brightness.dark,
          cursorColor: AppColors.darkGreen,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            isDense: true,
            hintText: 'enter_your_coupon'.tr,
            hintStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            focusColor: AppColors.lightBlack,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.teal,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: qValidator(
            [
              IsRequired('required'.tr),
              MinLength(1, 'min_length_1'.tr),
            ],
          ),
        ),
      ),
    );
  }
}
