import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController o3Controller = TextEditingController();

class O3 extends StatefulWidget {
  const O3({super.key});

  @override
  State<O3> createState() => _O3State();
}

class _O3State extends State<O3> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenHeight * 0.65;

    const EdgeInsets padding = EdgeInsets.all(16.0);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: containerHeight,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 246, 248, 251),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Indicador O₃",
                      style: GoogleFonts.gowunBatang(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .1),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Insira a Concentração medida",
                            style: GoogleFonts.gowunBatang(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .1),
                            ),
                          ),
                          const SizedBox(height: 30),
                          _buildInputField("O₃ (µg/m³)", o3Controller,
                              calcularO3, _getFormulaO3),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_areAllFieldsFilled()) {
                                  double valor = double.parse(
                                      o3Controller.text.replaceAll(',', '.'));
                                  double resultado = calcularO3(valor);
                                  _showResultadoDialog(context, resultado);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Por favor, preencha todos os campos.')),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(15.0),
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                "Calcular",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String labelText, TextEditingController controller,
      Function formulaCallback, Function formulaDescriptionCallback) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0x772666E0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              labelText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              controller: controller,
              style: const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0x772666E0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Color(0x772666E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0x772666E0)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                hintText: '0,00',
                hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              _showFormulaDialog(context, controller.text, formulaCallback,
                  formulaDescriptionCallback);
            },
          ),
        ],
      ),
    );
  }

  bool _areAllFieldsFilled() {
    return o3Controller.text.isNotEmpty;
  }

  double calcularO3(double cl) {
    if (cl >= 0 && cl <= 100) {
      return (40 / 100) * cl;
    } else if (cl > 100 && cl <= 130) {
      return ((80 - 41) / (130 - 100)) * (cl - 100) + 41;
    } else if (cl > 130 && cl <= 160) {
      return ((120 - 81) / (160 - 130)) * (cl - 130) + 81;
    } else if (cl > 160 && cl <= 200) {
      return ((200 - 121) / (200 - 160)) * (cl - 160) + 121;
    } else if (cl > 200) {
      return ((cl - 200) * (200 / 100)) + 200;
    } else {
      return double.nan;
    }
  }

  void _showResultadoDialog(BuildContext context, double resultado) {
    String nivel;
    String descricao;
    Color cor;

    if (resultado >= 0 && resultado <= 40) {
      nivel = "Boa";
      descricao = "N1 – Boa\n\nA qualidade do ar está satisfatória.";
      cor = Colors.green;
    } else if (resultado > 40 && resultado <= 80) {
      nivel = "Moderada";
      descricao =
          "N2 – Moderada\n\nPessoas de grupos sensíveis (crianças, idosos e pessoas com doenças respiratórias e cardíacas) podem apresentar sintomas como tosse seca e cansaço. A população em geral, não é afetada.";
      cor = Colors.yellow;
    } else if (resultado > 80 && resultado <= 120) {
      nivel = "Ruim";
      descricao =
          "N3 – Ruim\n\nToda a população pode apresentar sintomas como tosse seca, cansaço, ardor nos olhos, nariz e garganta. Grupos sensíveis podem apresentar efeitos mais sérios na saúde.";
      cor = Colors.orange;
    } else if (resultado > 120 && resultado <= 200) {
      nivel = "Muito Ruim";
      descricao =
          "N4 – Muito Ruim\n\nToda a população pode apresentar agravamento dos sintomas como tosse seca, cansaço e falta de ar. Grupos sensíveis podem ter efeitos ainda mais graves.";
      cor = Colors.red;
    } else {
      nivel = "Péssima";
      descricao =
          "N5 – Péssima\n\nToda a população pode apresentar sérios riscos de manifestações de doenças respiratórias e cardiovasculares.";
      cor = Colors.purple;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Qualidade do Ar: $nivel"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.info,
                color: cor,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                descricao,
                style: TextStyle(fontSize: 16, color: cor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showFormulaDialog(BuildContext context, String inputValue,
      Function formulaCallback, Function formulaDescriptionCallback) {
    double parsedValue = parseInput(inputValue);
    String formulaUsed;
    double result;
    try {
      result = formulaCallback(parsedValue);
      formulaUsed = formulaDescriptionCallback(parsedValue);
    } catch (e) {
      formulaUsed = "Valor fora do intervalo esperado.";
      result = double.nan;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Fórmula em uso"),
          content: Text(
              "Para o valor ${parsedValue.toStringAsFixed(2)}, a fórmula usada é:\n\n$formulaUsed\n\nO resultado do IQA é: ${result.toStringAsFixed(2)}"),
          actions: [
            TextButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  double parseInput(String input) {
    String sanitizedInput = input.replaceAll(',', '.');
    return double.tryParse(sanitizedInput) ?? 0.0;
  }

  String _getFormulaO3(double cl) {
    if (cl >= 0 && cl <= 100) {
      return "IQAr = (40 / 100) * concentração";
    } else if (cl > 100 && cl <= 130) {
      return "IQAr = ((80 - 41) / (130 - 100)) * (concentração - 100) + 41";
    } else if (cl > 130 && cl <= 160) {
      return "IQAr = ((120 - 81) / (160 - 130)) * (concentração - 130) + 81";
    } else if (cl > 160 && cl <= 200) {
      return "IQAr = ((200 - 121) / (200 - 160)) * (concentração - 160) + 121";
    } else if (cl > 200) {
      return "IQAr = ((concentração - 200) * (200 / 100)) + 200";
    } else {
      return "Valor fora do intervalo.";
    }
  }
}
