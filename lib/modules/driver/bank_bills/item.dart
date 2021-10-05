import 'package:flutter/material.dart';
import 'package:gadha/modules/driver/bank_bills/models/bank_bill.dart';

import 'package:queen/queen.dart';

class BankBillItem extends StatelessWidget {
  final BankBill bill;

  const BankBillItem(
    this.bill, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Text('#${bill.id}'),
        title: Text(bill.createdAt, style: theme.textTheme.bodyText1),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [Image.network(bill.image)],
      ),
    );
  }
}
