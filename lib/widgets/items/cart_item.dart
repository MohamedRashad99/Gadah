import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/modules/client/make_order/dialogs/update_name_dialog.dart';
import 'package:gadha/modules/client/make_order/models/order_item_to_add.dart';
import 'package:gadha/widgets/pickers/count_picker.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import '../pickers/single_image_picker.dart';

class CartItemWidget extends StatelessWidget {
  final OrderItemToAdd item;
  final Function(DismissDirection)? onDismissed;
  final ValueChanged<OrderItemToAdd> onItemChanged;

  const CartItemWidget(
      {required this.item,
      required this.onItemChanged,
      this.onDismissed,
      Key? key})
      : super(key: key);

  Widget _slideLeftBackground() {
    return Container(
      decoration: const BoxDecoration(color: AppColors.bloodRed),
      child: Align(
        alignment:
            isArabic ? const Alignment(-0.9, 0) : const Alignment(0.9, 0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return onDismissed == null
        ? buildItem(context)
        : Dismissible(
            key: UniqueKey(),
            direction: isArabic
                ? DismissDirection.endToStart
                : DismissDirection.startToEnd,
            background: _slideLeftBackground(),
            onDismissed: onDismissed,
            child: buildItem(context),
          );
  }

  Widget buildItem(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * .03, vertical: height * 0.005),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () async {
              await showPlatformModalSheet<void>(
                context: context,
                builder: (_) {
                  return CountPicker(item, onItemChanged);
                },
              );
            },
            child: Container(
              width: 50,
              height: height * 0.06,
              decoration: BoxDecoration(
                color: AppColors.darkWhite,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Text(
                  item.count.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: InkWell(
              onTap: () => Q.dialog(
                ProductNameDialog(
                  onChanged: (value) =>
                      onItemChanged(item.copyWith(name: value.trim())),
                  product: item,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  enabled: false,
                  maxLength: 25,
                  style: const TextStyle(fontSize: 10),
                  controller: TextEditingController(text: item.name),
                  decoration: InputDecoration(
                    hintText: 'tap_to_name_product'.tr,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    counterText: '',
                    isDense: true,
                    hintStyle: const TextStyle(
                      fontSize: 10,
                      color: AppColors.lightBlack,
                      fontWeight: FontWeight.bold,
                    ),
                    focusColor: AppColors.lightBlack,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.teal,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.01),
          SingleImagePicker(
            (value) => onItemChanged(item.copyWith(photo: value)),
            item.photo,
          ),
        ],
      ),
    );
  }
}
