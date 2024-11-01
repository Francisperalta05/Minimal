import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSelector {
  static Future<File> selectImage({required ImageSource source}) async {
    await Permission.camera.request();
    File image = File((await ImagePicker().pickImage(
      source: source,
      imageQuality: 25,
    ))!
        .path);

    File imageCompressed = await compressFile(image);

    return imageCompressed;
  }

  static Future<File> compressFile(File file) async {
    Uint8List? result = await FlutterImageCompress.compressWithFile(
      (await FlutterNativeImage.compressImage(
        file.path,
        quality: 40,
      ))
          .absolute
          .path,
      quality: 40,
      format: CompressFormat.jpeg,
    );

    Directory tempDir = await getTemporaryDirectory();

    File imageRes = await (await File(
                "${tempDir.path}/images_${DateTime.now().toIso8601String()}")
            .create())
        .writeAsBytes(result!);

    return imageRes;
  }
}
