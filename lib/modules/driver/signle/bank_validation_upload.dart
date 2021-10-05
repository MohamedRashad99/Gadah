import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/helpers/file_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/services/drivers_service.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

class BankValidationUpload extends StatefulWidget {
  const BankValidationUpload({Key? key}) : super(key: key);

  @override
  _BankValidationUploadState createState() => _BankValidationUploadState();
}

class _BankValidationUploadState extends State<BankValidationUpload> {
  File? _image;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    _image = (await FilePicker().pickMultiImage()).first;
    setState(() {});
  }

  Future<void> _uplaodImage() async {
    if (_image == null) return;
    try {
      setState(() => _isLoading = true);
      await DriverSerivce().uploadBankValidation(_image!);
      await Q.back();
      await Q.back();
      Q.alertWithSuccess('banck_validation_success'.tr);
    } catch (e) {
      log(e.toString());
      Q.alertWithErr('error_happened'.tr);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const StanderedAppBar(),
      body: SafeArea(
        child: _isLoading
            ? const CenterLoading()
            : Stack(
                children: [
                  Positioned.fill(
                    child: _builldInitialImagePicker(size),
                  ),
                  Positioned.fill(
                    bottom: null,
                    child: StanderedAppBar(
                      appBarType: AppBarType.navigator,
                      centerChild: Text(
                        'upload_bank_validation'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.lightGreen,
                          ),
                          onPressed: _image == null ? null : _uplaodImage,
                          icon: Icon(FontAwesomeIcons.paperPlane,
                              textDirection: directionReversed),
                          label: Text('upload'.tr),
                        ),
                        if (_image != null) ...[
                          const SizedBox(width: 12),
                          ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.grey),
                            onPressed: _pickImage,
                            child: Text('pick_another_image'.tr),
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _builldInitialImagePicker(Size size) {
    if (_image != null) {
      return PhotoView(
        imageProvider: FileImage(_image!),
        backgroundDecoration: const BoxDecoration(
          color: Colors.white,
        ),
      );
    }

    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: DottedBorder(
          borderType: BorderType.Circle,
          color: Colors.black54,
          radius: const Radius.circular(12),
          dashPattern: const [8, 4],
          strokeWidth: 2,
          padding: EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: SizedBox(
              height: size.width * 0.5,
              width: size.width * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add),
                    Text('image'.tr, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
