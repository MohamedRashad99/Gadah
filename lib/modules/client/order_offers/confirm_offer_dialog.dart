import 'package:flutter/material.dart';
import 'package:gadha/comman/models/offer.dart';
import 'package:gadha/comman/services/offers_repo.dart';
import 'package:gadha/modules/client/orders/cubit/user_offers_cubit.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class ConfirmOfferDialog extends StatelessWidget {
  final OfferEntity offer;
  final int orderId;
  const ConfirmOfferDialog(
    this.offer,
    this.orderId, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('confrim_offer_dialog'.tr),
            SizedBox(height: height * .03),
            SizedBox(
              width: width * .3,
              child: CustomMainButton(
                dropShadow: true,
                onTap: () async {
                  try {
                    // refresh offers
                    await OffersRepo().acceptOffer(orderId, offer.id);
                    await Q.back();
                    await Q.back();
                    await UserOrdersCubit.of(context).refresh();
                  } catch (e) {
                    Q.alertWithErr(e.toString().tr);
                    log(e.toString());
                  }
                },
                text: 'confirm'.tr,
                borderRaduis: 25,
                textSize: 16,
                fontWeight: FontWeight.bold,
                height: size.height * 0.06,
              ),
            ),
            SizedBox(height: height * .03),
            Align(
              alignment: Alignment.bottomLeft,
              child: OutlinedButton(
                onPressed: Q.back,
                child: Text('close'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
