import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/modules/shared/auth/login/page.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void ifIsNotLoggedInAskElseAct(Function function) {
  if (AuthService.isLoggedIn) {
    function();
  } else {
    Q.alertWithErr('must_login_first'.tr);
    final dialog = AwesomeDialog(
      context: Q.context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'must_login_first'.tr,
      desc: 'must_login_desc'.tr,
      btnOkOnPress: () {
        Q.to(EnterPhoneNoPage());
      },
    );
    dialog.show();
  }
}
