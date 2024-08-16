import 'dart:convert';
import 'package:calculeadora/navbart.dart';
import 'package:calculeadora/pdf.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'salvos.dart'; // Importe a nova página

class ResultPage extends StatefulWidget {
  final Map<String, double> valoresIQA;
  final Map<String, String> valoresDigitados;

  ResultPage({required this.valoresIQA, required this.valoresDigitados});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState(); // initState da classe state (boa prática)
    _loadPreferences();
  }

  void _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _savePreferences() async {
    prefs = await SharedPreferences.getInstance();

    final valoresIQA = widget.valoresIQA;
    final valoresDigitados = widget.valoresDigitados;

    // Carregar mapa existente (se houver)
    String? existingData = prefs.getString('timeData');
    Map<String, dynamic> dataMap =
        existingData != null ? json.decode(existingData) : {};

    // Adicionar nova entrada ao mapa
    String uniqueKey = DateTime.now().millisecondsSinceEpoch.toString();
    dataMap[uniqueKey] = {
      'valoresIQA': valoresIQA,
      'valoresDigitados': valoresDigitados,
    };

    // Salvar o mapa atualizado
    prefs.setString('timeData', json.encode(dataMap));
  }

  String _getQualityDescription(double iqa) {
    if (iqa >= 80 && iqa <= 100) {
      return 'Qualidade Excelente:\n\n'
          'A água nesta faixa é considerada de excelente qualidade. Ela apresenta baixos níveis de poluentes e altas concentrações de oxigênio dissolvido, o que é ideal para a preservação da vida aquática e para o consumo humano, após tratamento convencional. A presença de nutrientes e de material em suspensão é mínima, tornando-a adequada para a maioria dos usos.';
    } else if (iqa >= 51 && iqa <= 79) {
      return 'Qualidade Boa:\n\n'
          'Nesta faixa, a qualidade da água ainda é considerada boa. Embora possa haver a presença de alguns poluentes em níveis moderados, a água ainda é capaz de sustentar a vida aquática e é apropriada para uso recreativo e para abastecimento humano, desde que tratada. A concentração de oxigênio dissolvido é suficiente para suportar a biodiversidade, mas pode haver alguma presença de nutrientes que favoreçam o crescimento de algas.';
    } else if (iqa >= 36 && iqa <= 50) {
      return 'Qualidade Regular:\n\n'
          'A água com IQA nesta faixa é considerada de qualidade regular. Pode apresentar níveis elevados de poluentes, como matéria orgânica e nutrientes, o que pode afetar negativamente a vida aquática e reduzir a clareza da água. A quantidade de oxigênio dissolvido começa a se tornar insuficiente para a manutenção de alguns organismos aquáticos mais sensíveis. A água nesta faixa pode requerer tratamento mais intensivo para ser adequada ao consumo humano.';
    } else if (iqa >= 20 && iqa <= 35) {
      return 'Qualidade Ruim:\n\n'
          'A qualidade da água nesta faixa é classificada como ruim. Há uma presença significativa de poluentes, como matéria orgânica, sedimentos e produtos químicos tóxicos. A concentração de oxigênio dissolvido é baixa, o que pode resultar na morte de organismos aquáticos e na diminuição da biodiversidade. A água pode apresentar um cheiro ou gosto desagradável, e seu uso é limitado, exigindo tratamento avançado para o abastecimento.';
    } else {
      return 'Qualidade Péssima:\n\n'
          'A água nesta faixa é considerada de qualidade péssima. Está fortemente poluída, com níveis extremamente altos de contaminantes, incluindo produtos químicos tóxicos, metais pesados e nutrientes em excesso que podem causar proliferação de algas e outras plantas aquáticas indesejadas. O oxigênio dissolvido é quase inexistente, tornando impossível a sobrevivência da maioria das formas de vida aquática. Esta água é inadequada para quase todos os usos, incluindo o abastecimento e a recreação, sem tratamentos extensivos.';
    }
  }

  Color _getCellColor(String quality) {
    switch (quality.toLowerCase()) {
      case 'ótima':
        return Colors.green;
      case 'boa':
        return Colors.lightGreen;
      case 'razoável':
        return Colors.yellow;
      case 'ruim':
        return Colors.orange;
      case 'péssima':
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double iqaValue = widget.valoresIQA['IQA'] ?? 0.0;
    final String qualityDescription = _getQualityDescription(iqaValue);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 103, 247),
        title: const Text('CalcuLEAdora',
            style: TextStyle(color: Color(0xFFFFFFFF)),
            textAlign: TextAlign.center),
        centerTitle: true,
        leading: IconButton(
          color: const Color.fromARGB(255, 255, 255, 255),
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Resultado do Cálculo de IQA",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "O índice de qualidade IQA é: ${iqaValue.toStringAsFixed(2)}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Faixas de IQA utilizadas nos seguintes Estados: AL, MG, MT, PR, RJ, RN, RS',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Faixas de IQA utilizadas nos seguintes Estados: BA, CE, ES, GO, MS, PB, PE, SP',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Avaliação da Qualidade da Água',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '91-100',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '80-100',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        color: _getCellColor('Ótima'),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Ótima',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '71-90',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '52-79',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        color: _getCellColor('Boa'),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Boa',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '51-70',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '37-51',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        color: _getCellColor('Razoável'),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Razoável',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 10, 10, 10)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '26-50',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '20-36',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        color: _getCellColor('Ruim'),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Ruim',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 14, 14, 14)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '0-25',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '0-19',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        color: _getCellColor('Péssima'),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Péssima',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color.fromARGB(255, 31, 31, 31)),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  qualityDescription,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _savePreferences();
                    },
                    icon: Icon(Icons.save),
                    label: const Text("Salvar"),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  DownloadPDFButton(
                    valoresIQA: widget.valoresIQA,
                    valoresDigitados: widget.valoresDigitados,
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Navbart(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(Icons.arrow_back),
                    label: Text("Voltar para o menu"),
                  ),
                ],
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
