import 'package:flutter/material.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:gadha/widgets/signle/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import './data/bills_service.dart' as service;
import 'cubit/order_bills_cubit.dart';

class CreateBillDialog extends StatefulWidget {
  final OrderEntity orderEntity;
  final OrderBillsCubit cubit;

  const CreateBillDialog(
      {Key? key, required this.orderEntity, required this.cubit})
      : super(key: key);
  @override
  _CreateBillDialogState createState() => _CreateBillDialogState();
}

class _CreateBillDialogState extends State<CreateBillDialog> {
  final _amountController = TextEditingController();

  final _key = GlobalKey<FormState>();
  File? _image;

  bool _isLoading = false;

  Future<void> createOne() async {
    if (!_key.currentState!.validate()) return;

    try {
      if (_image == null) throw 'must_enter_bill_image'.tr;
      setState(() => _isLoading = true);
      await service.createOne(
        amount: num.parse(_amountController.text.trim()),
        orderId: widget.orderEntity.id,
        image: _image!,
      );
      await widget.cubit.refresh();
      await Q.back();
    } catch (e) {
      Q.alertWithErr(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _isLoading
                ? [const CenterLoading()]
                : [
                    Text('create_new_complaint'.tr),
                    GadhaTextField(
                      controller: _amountController,
                      labelText: 'price'.tr,
                      hintText: 'price'.tr,
                      prefixIcon: const Icon(FontAwesomeIcons.user),
                      validator: qValidator([
                        IsRequired('enter_bill_amount'.tr),
                      ]),
                    ),
                    SizedBox(height: height * 0.01),
                    if (_image != null)
                      Image.file(
                        _image!,
                        height: height * 0.3,
                        // height: widg * 0.3,
                      ),
                    SizedBox(height: height * 0.01),
                    CustomMainButton(
                      onTap: () async {
                        final img = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                        if (img != null) {
                          setState(() => _image = File(img.path));
                        }
                      },
                      borderRaduis: 25,
                      text: 'pick_bill_image'.tr,
                      textSize: 16,
                      fontWeight: FontWeight.bold,
                      height: size.height * 0.06,
                      isLoading: _isLoading,
                    ),
                    SizedBox(height: height * 0.01),
                    CustomMainButton(
                      onTap: createOne,
                      borderRaduis: 25,
                      text: 'send'.tr,
                      textSize: 16,
                      fontWeight: FontWeight.bold,
                      height: size.height * 0.06,
                      isLoading: _isLoading,
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
