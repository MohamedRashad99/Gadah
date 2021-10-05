import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/models/shared/user.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class GenderPicker extends StatefulWidget {
  final Function(UserGender gender) onChanged;
  const GenderPicker({required this.onChanged, Key? key}) : super(key: key);
  @override
  _GenderPickerState createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  UserGender selectedGender = UserGender.male;
  @override
  void initState() {
    widget.onChanged(selectedGender);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'gender'.tr,
            style: textTheme.button,
          ),
          SizedBox(height: height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              customButton(
                height: height * 0.055,
                width: width * 0.4,
                onTap: () {
                  setState(() {
                    selectedGender = UserGender.male;
                    widget.onChanged(selectedGender);
                  });
                },
                text: 'male'.tr,
                gender: UserGender.male,
              ),
              customButton(
                height: height * 0.055,
                width: width * 0.4,
                onTap: () {
                  setState(() {
                    selectedGender = UserGender.female;
                    widget.onChanged(selectedGender);
                  });
                },
                text: 'female'.tr,
                gender: UserGender.female,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget customButton({
    double? width,
    double? height,
    required String text,
    VoidCallback? onTap,
    UserGender? gender,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient:
              selectedGender == gender ? AppColors.famousGradient() : null,
          border: selectedGender != gender
              ? Border.all(
                  color: AppColors.darkGreen,
                  width: 1.3,
                )
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(999)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: selectedGender == gender ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
