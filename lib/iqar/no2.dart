import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController no2Controller = TextEditingController();

class NO2 extends StatefulWidget {
  const NO2({super.key});

  @override
  State<NO2> createState() => _NO2State();
}

class _NO2State extends State<NO2> {
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
                      "Indicador NO₂",
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
                          _buildInputField("NO₂ (µg/m³)", no2Controller,
                              calcularNO2, _getFormulaNO2),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_areAllFieldsFilled()) {
                                  double valor = double.parse(
                                      no2Controller.text.replaceAll(',', '.'));
                                  double resultado = calcularNO2(valor);
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
    return no2Controller.text.isNotEmpty;
  }

  double calcularNO2(double cl) {
    if (cl >= 0 && cl <= 200) {
      return (40 / 200) * cl;
    } else if (cl > 200 && cl <= 240) {
      return ((80 - 41) / (240 - 200)) * (cl - 200) + 41;
    } else if (cl > 240 && cl <= 320) {
      return ((120 - 81) / (320 - 240)) * (cl - 240) + 81;
    } else if (cl > 320 && cl <= 1130) {
      return ((200 - 121) / (1130 - 320)) * (cl - 320) + 121;
    } else if (cl > 1130) {
      return ((cl - 1130) * (200 / 100)) + 200;
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

  String _getFormulaNO2(double cl) {
    if (cl >= 0 && cl <= 200) {
      return "IQAr = (40 / 200) * concentração";
    } else if (cl > 200 && cl <= 240) {
      return "IQAr = ((80 - 41) / (240 - 200)) * (concentração - 200) + 41";
    } else if (cl > 240 && cl <= 320) {
      return "IQAr = ((120 - 81) / (320 - 240)) * (concentração - 240) + 81";
    } else if (cl > 320 && cl <= 1130) {
      return "IQAr = ((200 - 121) / (1130 - 320)) * (concentração - 320) + 121";
    } else if (cl > 1130) {
      return "IQAr = ((concentração - 1130) * (200 / 100)) + 200";
    } else {
      return "Valor fora do intervalo.";
    }
  }
}
