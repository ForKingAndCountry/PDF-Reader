// lib/core/utils/secure_pdf_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class SecurePdfStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<String> getLocalFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }

  Future<void> savePdfSecurely(String fileName, List<int> pdfBytes) async {
    final filePath = await getLocalFilePath(fileName);
    final file = File(filePath);
    await file.writeAsBytes(pdfBytes);
    await secureStorage.write(key: fileName, value: filePath);
  }

  Future<File> loadPdfSecurely(String fileName) async {
    final filePath = await secureStorage.read(key: fileName);
    if (filePath == null) {
      throw Exception('PDF not found');
    }
    return File(filePath);
  }

  Future<void> loadPdfFromAssetsAndSave(
      String assetPath, String fileName) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await savePdfSecurely(fileName, bytes);
  }
}
