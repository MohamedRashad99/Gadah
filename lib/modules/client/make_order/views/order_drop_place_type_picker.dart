import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDropPlacePicker extends StatefulWidget {
  final ValueChanged<bool> onTypeChange;
  const OrderDropPlacePicker({
    Key? key,
    required this.onTypeChange,
  }) : super(key: key);

  @override
  _OrderDropPlacePickerState createState() => _OrderDropPlacePickerState();
}

class _OrderDropPlacePickerState extends State<OrderDropPlacePicker> {
  bool _toCurrentLocation = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RadioListTile<bool>(
          value: true,
          groupValue: _toCurrentLocation,
          onChanged: (_) {
            setState(() {
              _toCurrentLocation = _!;
              widget.onTypeChange(_toCurrentLocation);
            });
          },
          title: Text('drop_to_home'.tr),
        ),
        RadioListTile<bool>(
          value: false,
          groupValue: _toCurrentLocation,
          onChanged: (_) {
            setState(() {
              _toCurrentLocation = _!;
              widget.onTypeChange(_toCurrentLocation);
            });
          },
          title: Text('other_place'.tr),
        ),
      ].map((e) => Expanded(child: e)).toList(),
    );
  }
}
