// lib/features/pdf_loader/presentation/pdf_loader_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_pdf_reader/core/utils/secure_pdf_storage.dart';
import 'package:in_app_pdf_reader/core/widgets/pdf_viewer_screen.dart';


class PdfLoaderScreen extends StatefulWidget {
  const PdfLoaderScreen({super.key});

  @override
  _PdfLoaderScreenState createState() => _PdfLoaderScreenState();
}

class _PdfLoaderScreenState extends State<PdfLoaderScreen> {
  final SecurePdfStorage securePdfStorage = SecurePdfStorage();

  final List<Map<String, String>> pdfLinks = [
    {'image': 'assets/images/The-Battle-For-Destiny.png', 'pdf': 'assets/The-Battle-For-Destiny.pdf'},
    {'image': 'assets/images/The-Misplaced-Bride.png', 'pdf': 'assets/The-Misplaced-Bride.pdf'},
    {'image': 'assets/images/The-Real-Way-Out.png', 'pdf': 'assets/The-Real-Way-Out.pdf'},
    {'image': 'assets/images/The-Story-of-Din.png', 'pdf': 'assets/The-Story-of-Din.pdf'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Loader'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: pdfLinks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              String assetPath = pdfLinks[index]['pdf']!;
              String fileName = assetPath.split('/').last;

              await securePdfStorage.loadPdfFromAssetsAndSave(assetPath, fileName);
              File pdfFile = await securePdfStorage.loadPdfSecurely(fileName);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewerScreen(pdfFile: pdfFile),
                ),
              );
            },
            child: Image.asset(pdfLinks[index]['image']!),
          );
        },
      ),
    );
  }
}
