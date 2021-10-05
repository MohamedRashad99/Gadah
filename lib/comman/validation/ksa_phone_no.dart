import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:queen_validators/queen_validators.dart';

class KsaPhoneNumber extends TextValidationRule {
  const KsaPhoneNumber();

  @override
  String get defaultError => 'not_valid_ksa_phone_number'.tr;

  @override
  bool isValid(String val) =>
      val.length == 12 && val.startsWith('966') || val.length == 9;
}
