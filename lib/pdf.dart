import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFGenerator {
  // Função para criar o PDF
  Future<Uint8List> createPDF(Map<String, double> valoresIQA) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Relatório de Qualidade da Água',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Valores Calculados:',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                ...valoresIQA.entries.map(
                  (entry) => pw.Text(
                    '${entry.key}: ${entry.value.toStringAsFixed(2)}',
                    style: pw.TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}

class DownloadPDFButton extends StatelessWidget {
  final Map<String, double> valoresIQA;

  DownloadPDFButton({required this.valoresIQA});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final pdfGenerator = PDFGenerator();
        final pdfData = await pdfGenerator.createPDF(valoresIQA);

        // Salva o PDF ou compartilha
        await Printing.sharePdf(
          bytes: pdfData,
          filename: 'relatorio_iqa.pdf',
        );
      },
      child: Text('Baixar Relatório PDF'),
    );
  }
}
