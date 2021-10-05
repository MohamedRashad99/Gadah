import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UserPhotoUpload extends StatefulWidget {
  final String? initalImage;
  final ValueChanged<File> onImageSubmit;
  const UserPhotoUpload(
      {required this.onImageSubmit, this.initalImage, Key? key})
      : super(key: key);

  @override
  _UserPhotoUploadState createState() => _UserPhotoUploadState();
}

class _UserPhotoUploadState extends State<UserPhotoUpload> {
  final picker = ImagePicker();
  File? _image;
  ImageSource _imageSource = ImageSource.gallery;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => _buildPanelSwitch(context, () async => getImage()),
        child: _image == null
            ? userPhoto(photoUrl: widget.initalImage)
            : userPhoto(imageFile: _image),
      ),
    );
  }

  void _setState(VoidCallback lSetState) {
    if (mounted) {
      setState(lSetState);
    }
  }

  Future<File> urlToFile(String imageUrl) async {
    // generate random number.
    final rng = math.Random();
    // get temporary directory of device.
    final tempDir = await getTemporaryDirectory();
    // get temporary path from temporary directory.
    final tempPath = tempDir.path;
    // create a new file in temporary path with random file name.
    final file = File('$tempPath${rng.nextInt(100)}.png');
    // call http.get method and pass imageUrl into it to get response.
    // ignore: unused_local_variable
    final _url = Uri.parse(imageUrl);
    // final response = await Con.get(_url);
    // write bodyBytes received in response to file.
    // await file.writeAsBytes(response.bodyBytes);
    // now return the file which is created with random name in
    // temporary directory and image bytes from response is written to // that file.
    return file;
  }

  Future<void> getImage() async {
    try {
      final pickedFile = await picker.getImage(
        source: _imageSource,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500,
      );
      _setState(() => _image = File(pickedFile!.path));
      widget.onImageSubmit(_image!);
    } catch (e) {
      log('CANCELLED, Error: $e');
      return;
    }
  }

  Widget userPhoto({String? photoUrl, File? imageFile}) {
    if (photoUrl != null) {
      return Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.darkWhite,
            backgroundImage: NetworkImage(photoUrl),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.boldBlackAccent,
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.cog,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (imageFile != null) {
      return Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.darkWhite,
            backgroundImage: FileImage(imageFile),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.boldBlackAccent,
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.cog,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Stack(
      children: const <Widget>[
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.darkWhite,
          child: FaIcon(
            FontAwesomeIcons.userAlt,
            size: 40,
            color: AppColors.lightGreenAccent2,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: AppColors.boldBlackAccent,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.cog,
                color: Colors.white,
                size: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _buildPanelSwitch(BuildContext context, VoidCallback callback) {
    if (isMaterial(context)) {
      _androidPopupContent(context, callback);
    } else {
      showPlatformModalSheet(
        context: context,
        builder: (_) => PlatformWidget(
          cupertino: (_, __) => _cupertinoSheetContent(context, callback),
        ),
      );
    }
  }

  void _androidPopupContent(BuildContext context, VoidCallback callback) {
    callback();
    // return PlatformActionSheet().displaySheet(
    //   context: context,
    //   title: Center(
    //     child: Padding(
    //       padding: const EdgeInsets.all(0),
    //       child: Text(
    //         'image_source'.tr,
    //         style: Theme.of(context).textTheme.headline6,
    //       ),
    //     ),
    //   ),
    //   message: Padding(
    //     padding: const EdgeInsets.all(5.0),
    //     child: Center(
    //       child: Text(
    //         'image_source_des'.tr,
    //         textAlign: TextAlign.center,
    //       ),
    //     ),
    //   ),
    //   actions: [
    //     ActionSheetAction(
    //       text: 'from_gallery'.tr,
    //       onPressed: () {
    //         Navigator.pop(context);
    //         _setState(() => _imageSource = ImageSource.gallery);
    //         Future.delayed(const Duration(milliseconds: 200), () {
    //           callback();
    //         });
    //       },
    //     ),
    //     ActionSheetAction(
    //       text: 'from_camera'.tr,
    //       onPressed: () {
    //         Navigator.pop(context);
    //         _setState(() => _imageSource = ImageSource.camera);
    //         Future.delayed(const Duration(milliseconds: 200), () {
    //           callback();
    //         });
    //       },
    //     ),
    //     ActionSheetAction(
    //       text: 'Cancel',
    //       onPressed: () => Navigator.pop(context),
    //       isCancel: true,
    //       defaultAction: true,
    //     )
    //   ],
    // );
  }

  Widget _cupertinoSheetContent(BuildContext context, VoidCallback callback) {
    return CupertinoActionSheet(
      title: Center(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Text(
            'image_source'.tr,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      message: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            'image_source_des'.tr,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            _setState(() => _imageSource = ImageSource.gallery);
            Future.delayed(const Duration(milliseconds: 200), () {
              callback();
            });
          },
          child: Text(
            'from_gallery'.tr,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            _setState(() => _imageSource = ImageSource.camera);
            Future.delayed(const Duration(milliseconds: 200), () {
              callback();
            });
          },
          child: Text(
            'from_camera'.tr,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
        child: Text('Cancel'.tr),
      ),
    );
  }
}
