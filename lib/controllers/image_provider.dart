import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';

class ImageUploader extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  var uuid = Uuid();
  List<String> imageFile = [];
  String? pdfPath;
  String? pdfUrl;
  String? imageUrl;
  String? imagePath;

  void pickImage() async {
    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);

    if (_imageFile != null) {
      _imageFile = await cropImage(_imageFile);

      if (_imageFile != null) {
        imageFile.add(_imageFile.path);
        imageUpload(_imageFile);
        imagePath = _imageFile.path;
      } else {
        return;
      }
    }
  }

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      pdfPath = result.files.single.path;
      pdfUpload(pdfPath!);
    } else {
      // User canceled the picker
    }
  }

  Future<XFile?> cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 1080,
      maxHeight: 1920,
      compressQuality: 80,
      aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'JobHunt',
          toolbarColor: Color(kGreen2.value),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      notifyListeners();
      return XFile(croppedFile.path);
    } else {
      return null;
    }
  }

  Future<String?> imageUpload(XFile upload) async {
    File image = File(upload.path);
    final ref = FirebaseStorage.instance
        .ref()
        .child("jobhub")
        .child("${uuid.v1()}.jpg");

    try {
      await ref.putFile(image);
      imageUrl = await ref.getDownloadURL();
      print("Ini image url ${imageUrl}");
      return imageUrl;
    } catch (e) {
      print("Error upload $e");
      return null;
    }
  }

  Future<String?> pdfUpload(String upload) async {
    File pdf = File(upload);
    final ref = FirebaseStorage.instance
        .ref()
        .child("jobhub")
        .child("${uuid.v1()}.pdf");

    try {
      await ref.putFile(pdf);
      pdfUrl = await ref.getDownloadURL();
      print("Ini pdf url ${pdfUrl}");
      return pdfUrl;
    } catch (e) {
      print("Error upload $e");
      return null;
    }
  }
}
