import 'dart:io';
import 'package:karltransportapp/components/save_and_open_pdf.dart';
import 'package:pdf/widgets.dart' as pw;  // Use the correct namespace for the pdf package
class SimplePdfApi {
  static Future<File> generateContractPdf(Map<String, String> contractData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: contractData.entries.map((entry) {
              return pw.Text(
                '${entry.key}: ${entry.value}',
                style: const pw.TextStyle(fontSize: 18),
              );
            }).toList(),
          ),
        ),
      ),
    );

    return SaveAndOpenDocument.savePdf(name: 'contract.pdf', pdf: pdf);
  }

  static generateSimpleTextPdf(String s, String t) {}
}