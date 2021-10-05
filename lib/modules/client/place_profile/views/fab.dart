import 'package:flutter/material.dart';
import 'package:gadha/modules/client/make_order/page.dart';
import 'package:gadha/modules/client/place_profile/cubit/place_profile_cubit.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class PlaceProfileFab extends StatelessWidget {
  final String? coverImageUrl;

  const PlaceProfileFab({this.coverImageUrl, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceProfileCubit, PlaceProfileState>(
      builder: (context, state) {
        if (state is PlaceProfileLoaded) {
          return FloatingActionButton.extended(
            // heroTag: 'map_tag',

            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {},
            label: CustomMainButton(
              dropShadow: true,
              onTap: () => Q.to(
                MakeOrderPage(
                  place: BlocProvider.of<PlaceProfileCubit>(context).place,
                  coverImageUrl: coverImageUrl,
                ),
              ),
              text: 'write_your_orders'.tr,
              borderRaduis: 25,
              textSize: 16,
              fontWeight: FontWeight.bold,
              height: height * .06,
              width: width * .8,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
