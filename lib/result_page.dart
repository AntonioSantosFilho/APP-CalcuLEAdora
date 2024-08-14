import 'package:calculeadora/calculadora_iqa_page.dart';
import 'package:calculeadora/pdf.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ResultPage extends StatefulWidget {
  final Map<String, double> valoresIQA;
  final Map<String, String> valoresDigitados;
  ResultPage({required this.valoresIQA, required this.valoresDigitados});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final valoresIQA = widget.valoresIQA;
    final valoresDigitados = widget.valoresDigitados;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 68, 103, 247),
        title: Text('CalcuLEAdora',
            style: TextStyle(color: Color(0xFFFFFFFF)),
            textAlign: TextAlign.center),
        centerTitle: true,
        leading: IconButton(
          color: Color.fromARGB(255, 255, 255, 255),
          icon: Icon(Icons.chevron_left),
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
                      print("");
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Salvar"),
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
