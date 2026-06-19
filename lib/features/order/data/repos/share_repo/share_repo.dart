import 'dart:typed_data';

abstract class ShareRepo {
  /// يقوم بحفظ الصورة مؤقتاً ومشاركتها
  Future<void> shareImage(Uint8List imageBytes, {required String fileName, required String text});
}
