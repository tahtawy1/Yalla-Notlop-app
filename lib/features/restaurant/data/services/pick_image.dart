import 'dart:io';

import 'package:image_picker/image_picker.dart';

bool _isPicking = false;

Future<File?> pickkImage() async {
  try {
    if (_isPicking) return null;

    _isPicking = true;

    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  } catch (e) {
    rethrow;
  } finally {
    _isPicking = false;
  }
}
