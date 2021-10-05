import 'package:flutter/material.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/services/complaints_service.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:gadha/widgets/signle/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import 'cubit/complains_cubit.dart';

class CreateComplaintDialog extends StatefulWidget {
  final OrderEntity? orderEntity;

  const CreateComplaintDialog({Key? key, this.orderEntity}) : super(key: key);
  @override
  _CreateComplaintDialogState createState() => _CreateComplaintDialogState();
}

class _CreateComplaintDialogState extends State<CreateComplaintDialog> {
  final _titleController = TextEditingController();
  final _msgController = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool _isLoading = false;
  File? _image;

  Future<void> createOne() async {
    if (!_key.currentState!.validate()) return;
    try {
      setState(() => _isLoading = true);
      await ComplaintsService().crateOne(
        title: _titleController.text.trim(),
        image: _image!,
        msg: _msgController.text.trim(),
        orderId: widget.orderEntity!.id,
      );
      ComplainsCubit.of(context).refresh();
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
            children: [
              Text('create_new_complaint'.tr),
              GadhaTextField(
                controller: _titleController,
                labelText: 'title'.tr,
                hintText: 'title'.tr,
                prefixIcon: const Icon(FontAwesomeIcons.user),
                validator: qValidator([
                  IsRequired('enter_complaint_title'.tr),
                  MinLength(5, 'too_short'.tr),
                ]),
              ),
              GadhaTextField(
                maxLines: 30,
                minLines: 8,
                controller: _msgController,
                labelText: 'message'.tr,
                hintText: 'message'.tr,
                prefixIcon: const Icon(FontAwesomeIcons.user),
                validator: qValidator([
                  IsRequired('enter_complaint_message'.tr),
                  MinLength(10, 'too_short'.tr),
                ]),
              ),
              CustomMainButton(
                onTap: () async {
                  final img =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  if (img != null) {
                    setState(() => _image = File(img.path));
                  }
                },
                borderRaduis: 25,
                text: 'pick compliant image'.tr,
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
