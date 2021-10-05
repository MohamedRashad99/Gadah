import 'package:flutter/material.dart';
import 'package:gadha/modules/shared/complains/models/complain.dart';
import 'package:queen/queen.dart';

class ComplaintItem extends StatelessWidget {
  final ComplianEntity complain;

  const ComplaintItem(
    this.complain, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Text('#${complain.id}'),
        title: Text(complain.title, style: theme.textTheme.bodyText1),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(complain.message, style: theme.textTheme.bodyText1),
        ],
      ),
    );
  }
}
