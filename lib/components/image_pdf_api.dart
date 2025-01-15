import 'dart:io';
import 'package:flutter/services.dart';
import 'package:karltransportapp/components/save_and_open_pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class ImagePdfApi {
  static Future<File> generateImagePdf(String imagePath) async {
    final pdf = Document();

    try {
      // Load image bytes
      final imageBytes = (await rootBundle.load(imagePath)).buffer.asUint8List();

      // Define the page theme and add the image
      const pageTheme = PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(10),
      );

      pdf.addPage(
        Page(
          pageTheme: pageTheme,
          build: (context) => Center(
            child: Image(MemoryImage(imageBytes), fit: BoxFit.contain),
          ),
        ),
      );

      // Save the PDF
      return SaveAndOpenDocument.savePdf(name: 'image.pdf', pdf: pdf);
    } catch (e) {
      throw Exception('Error creating PDF: $e');
    }
  }
}
