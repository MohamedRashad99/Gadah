import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageUploader extends StatefulWidget {
  final void Function(List<File> imageFiles) onFilesPicked;
  final int maxCount;
  final String title;
  final String subTitle;

  final int imageQuality;
  const ImageUploader({
    Key? key,
    required this.onFilesPicked,
    required this.title,
    required this.subTitle,
    this.maxCount = 1,
    this.imageQuality = 70,
  })  : assert(maxCount >= 0),
        super(key: key);

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final _images = <File>[];
  final picker = ImagePicker();
  late bool pickMulti;
  @override
  void initState() {
    pickMulti = widget.maxCount > 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pickMulti ? getMultiImage(context) : getImage(context),
      child: FormsPickingListTile(
        images: _images,
        title: widget.title,
        subtitle: widget.subTitle,
      ),
    );
  }

  Future<void> getMultiImage(BuildContext context) async {
    final _resultList = <File>[];
    try {
      final result = await MultiImagePicker.pickImages(
        maxImages: widget.maxCount,
        enableCamera: true,
      );
      for (final asset in result) {
        final file = File(
            join((await getApplicationDocumentsDirectory()).path, asset.name));
        if (await file.exists()) {
          await file.delete();
        }
        await file.create();
        final byteData = await asset.getByteData();
        await file.writeAsBytes(byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
        _resultList.add(file);
      }
    } on PermissionDeniedException {
      await _showPermissionDialog(context);
    } on PermissionPermanentlyDeniedExeption {
      await _showPermissionDialog(context);
    }
    _images.clear();
    setState(() => _images.addAll(_resultList));
    if (_images.isNotEmpty) widget.onFilesPicked(_images);
  }

  Future<void> getImage(BuildContext context) async {
    try {
      final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: widget.imageQuality,
      );
      _images.clear();
      setState(() => _images.add(File(pickedFile!.path)));
      if (_images.isNotEmpty) widget.onFilesPicked(_images);
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

class FormsPickingListTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<File> images;
  final VoidCallback? onTap;
  const FormsPickingListTile(
      {this.title, this.subtitle, required this.images, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      leading: Container(
        height: width * 0.2,
        width: (images.isNotEmpty ? images.length : 1) * width * 0.16,
        decoration: BoxDecoration(
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
        child: _buildPicPreview(),
      ),
      title: Text(
        title!,
        style: const TextStyle(
          color: AppColors.boldBlack,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      subtitle: Text(
        subtitle!,
        style: const TextStyle(
          color: AppColors.lightBlack,
          fontWeight: FontWeight.w600,
          fontSize: 9,
        ),
      ),
      trailing: _buildCheckIndicator(),
    );
  }

  Widget _buildCheckIndicator() {
    if (images.isEmpty) {
      return const SizedBox();
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: AppColors.darkGreenAccent,
          minRadius: 12,
          maxRadius: 17,
          child: Center(
            child: Text(
              images.length.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPicPreview() {
    if (images.isEmpty) {
      return const Center(
        child: Icon(FontAwesomeIcons.camera),
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: images
            .map(
              (e) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.file(
                    e,
                    width: width * 0.15,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: width * 0.005),
                ],
              ),
            )
            .toList(),
      );
    }
  }
}
