import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

bool _isPicking = false;

Future<File?> pickImage() async {
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
    log('Error picking image: $e');
    return null;
  } finally {
    _isPicking = false;
  }
}
