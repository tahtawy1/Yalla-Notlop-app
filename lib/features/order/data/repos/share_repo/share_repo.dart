import 'dart:typed_data';

abstract class ShareRepo {
  Future<void> shareImage(
    Uint8List imageBytes, {
    required String fileName,
    required String text,
  });
}
