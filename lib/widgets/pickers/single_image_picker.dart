import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:image_picker/image_picker.dart';

class SingleImagePicker extends StatelessWidget {
  final ValueChanged<File> onImagePicked;
  final File? initalFile;

  const SingleImagePicker(this.onImagePicked, this.initalFile, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => getImage(context),
      child: Container(
        height: height * .06,
        // constraints: BoxConstraints.loose(Size.fromHeight(height * 0.2)),
        // constraints: BoxConstraints(maxHeight: height * 0.05),
        width: width * .16,
        decoration: BoxDecoration(
          // color: AppColors.darkWhite,
          // borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400]!,
              spreadRadius: 0.5,
              blurRadius: 10,
            ),
          ],
        ),
        child: initalFile == null
            ? Center(
                child: SvgPicture.asset(
                'assets/vectors/upload_image.svg',
                height: size.height * 0.05,
              ))
            : Image.file(initalFile!),
      ),
    );
  }

  Future<void> getImage(BuildContext context) async {
    try {
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        onImagePicked(File(pickedFile.path));
      }
    } catch (e) {
      if (e.toString().contains('permission')) {
        await _showPermissionDialog(context);
      }
    }
  }

  FutureOr<void> _showPermissionDialog(BuildContext context) async {
    return showPlatformDialog<void>(
      context: context,
      builder: (context) {
        return PlatformAlertDialog(
          title: Text('no_permission'.tr),
          content: Text('no_image_picking_permission'.tr),
          actions: [
            PlatformDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'.tr),
            ),
            PlatformDialogAction(
              onPressed: AppSettings.openAppSettings,
              child: Text('settings'.tr),
            ),
          ],
        );
      },
    );
  }
}
