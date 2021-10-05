import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadha/modules/client/make_order/models/order_item_to_add.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class CountPicker extends StatefulWidget {
  final ValueChanged<OrderItemToAdd> onCountChanged;
  final OrderItemToAdd item;
  const CountPicker(this.item, this.onCountChanged, {Key? key})
      : super(key: key);

  @override
  _CountPickerState createState() => _CountPickerState();
}

class _CountPickerState extends State<CountPicker> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialButton(
            onPressed: () {
              widget.onCountChanged(widget.item.copyWith(count: count));
              Q.back();
            },
            child: Text('tam'.tr),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40,
              useMagnifier: true,
              backgroundColor: Colors.white,
              onSelectedItemChanged: (qIndex) => count = qIndex + 1,
              children: List.generate(
                100,
                (index) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
