import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yalla_notlop_app/features/order/data/repos/share_repo/share_repo.dart';

class ShareRepoImp implements ShareRepo {
  @override
  Future<void> shareImage(
    Uint8List imageBytes, {
    required String fileName,
    required String text,
  }) async {
    try {
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/$fileName.png';

      final file = File(imagePath);
      await file.writeAsBytes(imageBytes);

      final xFile = XFile(file.path);
      await SharePlus.instance.share(ShareParams(files: [xFile]));
    } catch (e) {
      throw Exception('فشلت عملية المشاركة: $e');
    }
  }
}
