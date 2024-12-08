// lib/main.dart
import 'package:flutter/material.dart';
import 'package:in_app_pdf_reader/core/features/pdf_loader/presentation/pdf_loader_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PdfLoaderScreen(),
    );
  }
}
