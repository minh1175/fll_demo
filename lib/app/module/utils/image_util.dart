import 'dart:async';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

Future<File?> compressFile(File file) async {
  // if (file.lengthSync() < IMAGE_COMPRESS_SIZE) {
  //   return file;
  // }

  var quality = 80;
  // if (file.lengthSync() > 6 * IMAGE_COMPRESS_SIZE) {
  //   quality = 20;
  // } else if (file.lengthSync() > 2 * IMAGE_COMPRESS_SIZE) {
  //   quality = 30;
  // } else if (file.lengthSync() > 1 * IMAGE_COMPRESS_SIZE) {
  //   quality = 60;
  // }

  var dir = await path_provider.getTemporaryDirectory();
  var targetPath = dir.absolute.path +"/"+DateTime.now().millisecondsSinceEpoch.toString()+ ".jpg";

  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: quality,
    rotate: 0,
    minHeight: 500,
    minWidth: 500,
  );

  // print(file.lengthSync());
  // print(result!.lengthSync());
  return result;
}