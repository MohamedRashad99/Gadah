import 'dart:io';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FilePicker {
  Future<List<File>> pickMultiImage({int maxCount = 1}) async {
    final _resultList = <File>[];
    try {
      final result = await MultiImagePicker.pickImages(
        maxImages: maxCount,
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
      // await _showPermissionDialog(context);
    } on PermissionPermanentlyDeniedExeption {
      // await _showPermissionDialog(context);
    }
    return _resultList;
  }
}
