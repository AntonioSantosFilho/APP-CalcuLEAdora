import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar a data e hora
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;

class PDFGenerator {
  // Função para criar o PDF
  Future<Uint8List> createPDF(Map<String, String> valoresDigitados,
      Map<String, double> valoresCalculados) async {
    final pdf = pw.Document();

    // Carregar as imagens antes de adicionar a página
    final image1 = pw.MemoryImage(await _loadImage('assets/lea.png'));
    final image2 = pw.MemoryImage(await _loadImage('assets/petsaneamento.png'));
    final image3 = pw.MemoryImage(await _loadImage('assets/univasf.png'));
    final image4 = pw.MemoryImage(await _loadImage('assets/petmec.png'));

    // Definindo os pesos dos parâmetros e unidades
    final pesos = {
      'DBO': 0.10,
      'OD': 0.17,
      'Fósforo': 0.10,
      'Nitrogênio': 0.10,
      'Coliformes': 0.15,
      'Turbidez': 0.08,
      'Sólidos Suspensos': 0.08,
      'Temperatura': 0.10,
      'pH': 0.12,
    };

    final unidades = {
      'DBO': 'mg/L',
      'OD': 'mg/L',
      'Fósforo': 'mg/L',
      'Nitrogênio': 'mg/L',
      'Coliformes': 'NMP',
      'Turbidez': 'NTU',
      'Sólidos Suspensos': 'mg/L',
      'Temperatura': '°C',
      'pH': '',
    };

    // Criando a tabela
    final tableHeaders = [
      'Parâmetro',
      'Unidade',
      'Resultado\nda Análise',
      'Nota QI',
      'Peso',
      'Nota Elevada\nao Peso'
    ];

    final tableData = valoresCalculados.entries
        .where((entry) => entry.key != 'IQA') // Filtra o parâmetro "IQA"
        .map((entry) {
      final parametro = entry.key;
      final valorDigitado = valoresDigitados[parametro] ?? 'N/A';
      final valorCalculado = entry.value;
      final peso = pesos[parametro] ?? 0.0;
      final notaElevadaAoPeso = pow(valorCalculado, peso);

      return [
        parametro,
        unidades[parametro] ?? 'N/A',
        valorDigitado,
        valorCalculado.toStringAsFixed(2),
        peso.toStringAsFixed(2),
        notaElevadaAoPeso.toStringAsFixed(2)
      ];
    }).toList();

    // Adicionando a página ao PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          // Obtendo a data e hora atual
          final String dataHoraAtual =
              DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

          return pw.Stack(
            children: [
              // Posicionando as imagens no topo da página
              pw.Positioned(
                top: 0, // Define a distância do topo da página
                left: 0,
                right: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Image(image1, height: 30),
                    pw.Image(image2, height: 30),
                    pw.Image(image3, height: 30),
                    pw.Image(image4, height: 30),
                  ],
                ),
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(
                      height: 100), // Adiciona um espaço abaixo das imagens
                  pw.Center(
                    child: pw.Text(
                      'Relatório de Qualidade da Água - $dataHoraAtual',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Center(
                    child: pw.Text(
                      'Tabela de Resultados:',
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Table.fromTextArray(
                    headers: tableHeaders,
                    data: tableData,
                    border: pw.TableBorder.all(),
                    headerStyle: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal,
                      fontSize: 12,
                    ),
                    cellStyle: pw.TextStyle(fontSize: 12),
                    cellAlignment: pw.Alignment.center,
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'IQA Final: ${valoresCalculados['IQA']?.toStringAsFixed(2) ?? 'N/A'}',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Rodapé na parte inferior da página
              pw.Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: pw.Text(
                  'Desenvolvido por Antonio dos Santos, João Pedro de Brito e Miriam Cleide Amorim',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // Função para carregar imagem a partir do assets
  Future<Uint8List> _loadImage(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }
}

class DownloadPDFButton extends StatelessWidget {
  final Map<String, double> valoresIQA;

  final Map<String, String> valoresDigitados;
  DownloadPDFButton({required this.valoresIQA, required this.valoresDigitados});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final pdfGenerator = PDFGenerator();
        final pdfData =
            await pdfGenerator.createPDF(valoresDigitados, valoresIQA);

        // Salva o PDF ou compartilha
        await Printing.sharePdf(
          bytes: pdfData,
          filename: 'relatorio_iqa.pdf',
        );
      },
      icon: const Icon(Icons.save_alt),
      label: const Text('Baixar Relatório PDF'),
    );
  }
}
