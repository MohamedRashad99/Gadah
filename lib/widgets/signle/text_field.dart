import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';

class GadhaTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String? title)? validator;
  final bool enabled;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  const GadhaTextField(
      {this.controller,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.validator,
      this.suffixIcon,
      this.enabled = true,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.maxLines,
      this.minLines,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: TextFormField(
            maxLines: maxLines,
            minLines: minLines,
            enabled: enabled,
            controller: controller,
            keyboardType: keyboardType,
            keyboardAppearance: Brightness.dark,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(
                color: AppColors.boldBlack.withOpacity(0.7),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              hintText: hintText,
              errorStyle: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              focusColor: AppColors.lightBlack,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.teal,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ),
    );
  }
}
