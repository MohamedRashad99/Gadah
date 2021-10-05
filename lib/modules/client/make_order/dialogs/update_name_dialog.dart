import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/modules/client/make_order/models/order_item_to_add.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class ProductNameDialog extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final OrderItemToAdd product;
  const ProductNameDialog(
      {required this.onChanged, required this.product, Key? key})
      : super(key: key);
  @override
  _ProductNameDialogState createState() => _ProductNameDialogState();
}

class _ProductNameDialogState extends State<ProductNameDialog> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.product.name);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textField = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: _textEditingController,
        onChanged: widget.onChanged,
        keyboardType: TextInputType.text,
        autocorrect: false,
        autofocus: true,
        maxLength: 25,
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(
          counterText: '',
          hintStyle: const TextStyle(
            fontSize: 12,
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
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          height: height * 0.25,
          width: width * 0.80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'write_your_product_name'.tr,
                style: const TextStyle(
                  color: AppColors.boldBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textField,
              CustomMainButton(
                onTap: Q.back,
                text: 'enter'.tr,
                padding: const EdgeInsets.symmetric(vertical: 12),
                borderRaduis: 30,
                fontWeight: FontWeight.bold,
                height: 55,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
