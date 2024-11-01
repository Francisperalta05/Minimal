import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSelector {
  static Future<File> selectImage({required ImageSource source}) async {
    await Permission.camera.request();
    File image = File((await ImagePicker().pickImage(
      source: source,
      imageQuality: 25,
    ))!
        .path);

    return image;
  }
}
