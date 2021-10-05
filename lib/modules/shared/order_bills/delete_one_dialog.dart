import 'package:flutter/material.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import './data/bills_service.dart' as service;
import 'cubit/order_bills_cubit.dart';
import 'models/bill.dart';

class DeleteBillDialog extends StatefulWidget {
  final OrderEntity orderEntity;
  final OrderBill orderBill;
  final OrderBillsCubit cubit;
  const DeleteBillDialog({
    Key? key,
    required this.orderEntity,
    required this.orderBill,
    required this.cubit,
  }) : super(key: key);

  @override
  _DeleteBillDialogState createState() => _DeleteBillDialogState();
}

class _DeleteBillDialogState extends State<DeleteBillDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'are_you_want_to_delete_bill'.tr,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: height * 0.01),
            CustomMainButton(
              onTap: deleteBill,
              borderRaduis: 25,
              text: 'Yes'.tr,
              textSize: 16,
              fontWeight: FontWeight.bold,
              height: size.height * 0.06,
            ),
            SizedBox(height: height * 0.01),
            CustomMainButton(
              onTap: () {
                Navigator.pop(context);
              },
              borderRaduis: 25,
              text: 'No'.tr,
              textSize: 16,
              fontWeight: FontWeight.bold,
              height: size.height * 0.06,
            )
          ],
        ),
      ),
    );
  }

  Future<void> deleteBill() async {
    try {
      final msg = await service.deleteOne(
        widget.orderEntity.id,
        widget.orderBill.id,
      );
      Q.alertWithSuccess(msg);
      await widget.cubit.refresh();
      await Q.back();
    } catch (e) {
      Q.alertWithErr(e.toString());
    }
  }
}
