import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/driver/driver_meta.dart';
import 'package:gadha/modules/driver/bank_bills/page.dart';
import 'package:gadha/modules/driver/signle/account_balance.dart';
import 'package:gadha/modules/shared/user_settings/settings.dart';
import 'package:gadha/modules/shared/my_reviews/page.dart';
import 'package:gadha/modules/shared/sign_out_button.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/widgets/items/user_info_item.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../contact_us_page.dart';
import 'cubit/user_profile_cubit.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool get isDriver => AuthService.currentUser!.isDriver;
  @override
  void initState() {
    UserProfileCubit.of(context).refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: const StanderedAppBar(),
            body: SafeArea(
              child: Stack(children: <Widget>[
                const Positioned.fill(
                  bottom: null,
                  child: StanderedAppBar(),
                ),
                Positioned.fill(
                  top: height * 0.02,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: .1,
                                blurRadius: 7)
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60 * 0.85,
                          child: CircleAvatar(
                            radius: 52 * 0.85,
                            backgroundColor: AppColors.darkWhite,
                            backgroundImage: NetworkImage(
                                AuthService.currentUser?.image ?? ''),
                            // child: AuthService.currentUser?.image ==
                            //         null
                            //     ? const Icon(FontAwesomeIcons.userAlt,
                            //         size: 40)
                            //     : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  top: size.height * .2,
                  // top: size.height * (0.11 * 2 + (0.15 - 0.11)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    child: BlocBuilder<UserProfileCubit, UserProfileState>(
                        builder: (context, state) {
                      if (state is UserProfileCantLoad) {
                        return CenterError(message: state.msg);
                      } else if (state is UserProfileLoading) {
                        return const CenterLoading();
                      } else if (state is UserProfileLoaded) {
                        return buidData(state.metaData);
                      } else {
                        return const SizedBox();
                      }
                    }),
                  ),
                ),
              ]),
            )));
  }

  Widget buidData(UserMetaData meta) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            AuthService.currentUser!.name,
            style: const TextStyle(
              color: AppColors.boldBlack,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(meta.rate.toString(), style: textTheme.headline6),
              Directionality(
                textDirection: directionReversed,
                child: SmoothStarRating(
                  rating: meta.rate.toDouble(),
                  size: 19.0,
                  isReadOnly: true,
                  color: Colors.amber,
                  borderColor: Colors.grey,
                ),
              ),
            ],
          ),
          if (isDriver) ...[
            UserInfoItem(
              leadingIcon: FontAwesomeIcons.carSide,
              title: 'orders_number'.tr,
              trailing: Row(
                children: <Widget>[
                  Text(
                    meta.ordersCount.toString(),
                    textDirection: TextDirection.ltr,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'orders'.tr,
                    style: const TextStyle(
                      color: AppColors.darkGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            UserInfoItem(
              visable: isDriver,
              leadingIcon: FontAwesomeIcons.circleNotch,
              title: 'deptit_amount'.tr,
              showTrailingAndArrow: true,
              onTap: () => Q.to(DriverAccountBalance(
                depitAmount: meta.depit.toString(),
              )),
              trailing: Row(
                children: <Widget>[
                  Text(
                    meta.depit.toString(),
                    textDirection: TextDirection.ltr,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'rs'.tr,
                    style: const TextStyle(
                      color: AppColors.darkGreen,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            UserInfoItem(
              visable: isDriver,
              leadingIcon: FontAwesomeIcons.circleNotch,
              title: 'driver_bank_bills'.tr,
              onTap: () => Q.to(const DriverBankBillsScreen()),
            ), //
            const Divider(),
          ],
          UserInfoItem(
            onTap: () => Q.to(UserReviewsScreen(AuthService.currentUser!)),
            leadingIcon: FontAwesomeIcons.solidCommentAlt,
            title: 'my_reviews'.tr,
          ),
          const Divider(),
          UserInfoItem(
            onTap: () => Q.to(const Settings()),
            leadingIcon: FontAwesomeIcons.cogs,
            title: 'settings'.tr,
          ),
          const Divider(),
          const SignOutButton(),
          const Divider(),
          const ContactUsView(),
        ],
      ),
    );
  }
}
