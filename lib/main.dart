import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:gadha/comman/push_notifications.dart';

import 'package:gadha/modules/client/search/cubit/near_by_search_cubit.dart';
import 'package:gadha/modules/driver/home/orders_tab/in_porgress/cubit/orders_in_progress_cubit.dart';
import 'package:gadha/modules/driver/home/orders_tab/to_offer/cubit/orders_to_offer_cubit.dart';
import 'package:gadha/modules/shared/complains/cubit/complains_cubit.dart';
import 'package:gadha/modules/shared/curren_location/cubit/current_location_cubit.dart';
import 'package:gadha/modules/shared/user_profile/cubit/user_profile_cubit.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import 'comman/cubits/auth_cubit/authantication_cubit.dart';

import 'comman/config/theme.dart';
import 'comman/models/shared/user.dart';
import 'comman/trs/messages.dart';
import 'helpers/storage.dart';
import 'modules/client/orders/cubit/user_offers_cubit.dart';
import 'modules/client/coupon/cubit/coupon_cubit.dart';
import 'modules/client/home/page.dart';
import 'modules/client/catigories/cubit/home_categories_cubit.dart';
import 'modules/client/home/views/home_near_by/cubit/home_near_by_cubit.dart';
import 'modules/driver/bank_bills/cubit/driver_bank_bills_cubit.dart';
import 'modules/driver/home/orders_tab/orders_done/cubit/orders_done_cubit.dart';
import 'modules/driver/home/page.dart';
import 'modules/shared/auth/confirm_code/cubit/confirm_code_cubit.dart';
import 'modules/shared/auth/login/cubit/login_cubit.dart';
import 'modules/shared/auth/signup/as_client/cubit/sign_up_as_client_cubit.dart';
import 'modules/shared/auth/signup/as_driver/cubit/sign_up_as_drvier_cubit.dart';
import 'modules/shared/auth/status/blocked.dart';
import 'modules/shared/auth/status/pending.dart';
import 'modules/shared/auth/status/refused.dart';
import 'modules/shared/notification_tab/cubit/notifications_cubit.dart';
import 'modules/shared/splash_page.dart';

Future<void> main() async {
  await init();
  return runApp(const Gadha());
}

Future<void> init() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
  );
  // *
  await Q.coreBoot();
  // *
  await AppStorage.boot();

  // *
  await Firebase.initializeApp();
  // *
  await FCMConfig.instance.init();
  PushNotificationService pushNotificationService = PushNotificationService.instance;
  pushNotificationService.initialise();



}

class Gadha extends StatelessWidget {
  const Gadha({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// ? features
    return Portal(
      child: MultiBlocProvider(
        providers: [
          // ? shared cubits
          // * Auth
          BlocProvider(create: (_) => AuthCubit()),

          BlocProvider(create: (_) => LoginCubit(AuthCubit.of(_))),
          BlocProvider(
            create: (_) => SignUpAsClientCubit(AuthCubit.of(_)),
          ),
          BlocProvider(
            create: (_) => SignUpAsDrvierCubit(AuthCubit.of(_)),
          ),
          BlocProvider(
            create: (_) => ConfirmCodeCubit(AuthCubit.of(_)),
          ),

          BlocProvider(create: (_) => CurrentLocationCubit()),
          BlocProvider(create: (_) => UserProfileCubit()),
          BlocProvider(create: (_) => NotificationsCubit()),
          BlocProvider(create: (_) => DriverBankBillsCubit()),
          BlocProvider(create: (_) => ComplainsCubit()),

          // * client cubits
          BlocProvider(create: (_) => HomeNearByCubit()),
          BlocProvider(create: (_) => HomeCategoriesCubit()),
          BlocProvider(create: (_) => NearBySearchCubit()),
          BlocProvider(create: (_) => CouponCubit()),

          // * driver cubits
          BlocProvider(create: (_) => OrdersToOfferCubit()),
          BlocProvider(create: (_) => OrdersInProgressCubit()),
          BlocProvider(create: (_) => OrdersDoneCubit()),
          BlocProvider(create: (_) => UserOrdersCubit()),
        ],
        child: BlocListener<AuthCubit, AuthState>(
          listener: _authStateListner,
          child: GetMaterialApp(
            theme: mainTheme,
            navigatorKey: Q.navKey,
            title: 'app_title'.tr,
            fallbackLocale: const Locale('ar'),
            locale: const Locale('ar'),
            debugShowCheckedModeBanner: false,
            translations: Messages(),
            onGenerateRoute: (_) =>
                MaterialPageRoute(builder: (_) => const SplashPage()),
          ),
        ),
      ),
    );
  }
}

void _authStateListner(_, AuthState state) {
  try {
    if (state is LoggedIn) {
      switch (state.user.accountStatus) {
        case AccountStatus.active:
          Q.replaceAll(state.user.isDriver
              ? const DriverHomePage()
              : const ClientHomePage());
          break;
        case AccountStatus.awaiting:
          Q.replaceAll(const Pending());
          break;
        case AccountStatus.refused:
          Q.replaceAll(Refused(state.user.statusNote));
          break;
        case AccountStatus.banned:
          Q.replaceAll(Blocked(state.user.statusNote));
          break;
      }
    } else {
      Q.replaceAll(const ClientHomePage());
    }
  } catch (e) {
    L.e('[gadha][auth_cubit][bug] $e');
    Q.replaceAll(const ClientHomePage());
  }
}
