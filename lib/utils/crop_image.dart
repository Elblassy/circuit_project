import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:mime/mime.dart';

Future<File?> cropImage(String imagePath) async {
  File? croppedFile = await ImageCropper.cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: Platform.isAndroid
      ? [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
      ]
      : [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Crop',
      ));
  if (croppedFile != null) {
    String? mimeStr = lookupMimeType(croppedFile.path);
    if (mimeStr != null) {
      var fileType = mimeStr.split('/');
      print('file type $fileType');
      print('lenght ${await croppedFile.length()/8000} kb');
    }
    print('done cropping');
  }

  return croppedFile;
}