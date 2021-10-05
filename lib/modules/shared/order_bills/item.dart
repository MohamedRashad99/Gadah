import 'package:flutter/material.dart';
import 'package:gadha/modules/shared/order_bills/models/bill.dart';
import 'package:queen/queen.dart';

class BillItem extends StatelessWidget {
  final OrderBill bill;
  final int index;
  final VoidCallback longPress;

  const BillItem(
    this.bill,
    this.index,
    this.longPress, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: longPress,
      child: Card(
        child: ExpansionTile(
          leading: Text(index.toString()),
          title: Text(bill.amount.toString(), style: theme.textTheme.bodyText1),
          children: [
            Image.network(
              bill.image.toString(),
              // fullImagePath(bill.image.toString()),
              // height: size.,
            ),
          ],
        ),
      ),
    );
  }
}
