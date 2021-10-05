// import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:gadha/widgets/pickers/image_uploader_widget.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class BillIssueModel {
  final double? totalOrdersValue;
  final Asset? billImage;

  BillIssueModel({
    this.totalOrdersValue,
    this.billImage,
  });
}

class AgentToClientBillIssuer extends StatefulWidget {
  final ValueChanged<BillIssueModel>? onChanged;
  const AgentToClientBillIssuer({Key? key, this.onChanged}) : super(key: key);

  @override
  _AgentToClientBillIssuerState createState() =>
      _AgentToClientBillIssuerState();
}

class _AgentToClientBillIssuerState extends State<AgentToClientBillIssuer> {
  final TextEditingController _textEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<File>? _images;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 20),
          // width: size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'please_enter_bill_value'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: DottedBorder(
                        dashPattern: const <double>[3, 2],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(30),
                        color: AppColors.darkGreenAccent,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'total_order_price'.tr,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: _textEditingController,
                                    keyboardAppearance: Brightness.dark,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    style: const TextStyle(fontSize: 40),
                                    textAlign: TextAlign.center,
                                    cursorColor: AppColors.darkGreen,
                                    decoration: const InputDecoration.collapsed(
                                      hintText: '00.00',
                                      hintStyle: TextStyle(
                                        fontSize: 40,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please_re_enter_number'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'R . S',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ImageUploader(
                    onFilesPicked: (imageFiles) => _images = imageFiles,
                    title: 'bill_image'.tr,
                    subTitle: 'bill_should_incloud_all'.tr,
                  ),
                ),
                CustomMainButton(
                  onTap: () {
                    if (_formKey.currentState!.validate() &&
                        _images?.first != null) {
                      final generatedBill = BillIssueModel(
                        // billImage: _images!.first,
                        totalOrdersValue:
                            double.parse(_textEditingController.text.trim()),
                      );
                      return Navigator.of(context, rootNavigator: true)
                          .pop<BillIssueModel>(generatedBill);
                    }
                  },
                  text: 'issue_bill'.tr,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  borderRaduis: 50,
                  textSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
