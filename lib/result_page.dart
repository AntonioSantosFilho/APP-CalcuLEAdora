import 'dart:convert';

import 'package:calculeadora/calculadora_iqa_page.dart';
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

  @override
  Widget build(BuildContext context) {
    final valoresIQA = widget.valoresIQA;
    final valoresDigitados = widget.valoresDigitados;

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
                "O índice de qualidade IQA é: ${valoresIQA['IQA']}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: const TextSpan(
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black), // Estilo padrão do texto
                    children: [
                      TextSpan(
                        text:
                            "O Índice de Qualidade da Água, com base nos valores obtidos para cada parâmetro analisado, é considerado ",
                      ),
                      TextSpan(
                        text:
                            "[boa/média/ruim]", // Substitua pela variável correspondente
                        style: TextStyle(
                          color: Colors.blue, // Cor diferente
                          fontWeight: FontWeight.bold, // Negrito
                        ),
                      ),
                      TextSpan(
                        text:
                            ". Esse resultado reflete a condição geral da água, indicando que ela é ",
                      ),
                      TextSpan(
                        text:
                            "[adequada para o consumo e atividades/requer atenção em alguns aspectos/não recomendada para uso].", // Substitua pela variável correspondente
                        style: TextStyle(
                          color: Colors.blue, // Cor diferente
                          fontWeight: FontWeight.bold, // Negrito
                        ),
                      ),
                      TextSpan(
                        text:
                            " A qualidade da água pode variar dependendo dos fatores ambientais e das atividades humanas na região, sendo essencial o monitoramento contínuo para garantir a segurança e a saúde da população.",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _savePreferences();
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Salvar"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SavedResultsPage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Ver Resultados Salvos"),
                  ),
                  DownloadPDFButton(
                    valoresIQA: valoresIQA,
                    valoresDigitados: valoresDigitados,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
