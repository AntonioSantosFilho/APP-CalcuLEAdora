import 'package:calculeadora/result_page.dart';
import 'package:calculeadora/resultado_iets.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

TextEditingController ietClController = TextEditingController();
TextEditingController ietPtController = TextEditingController();

class IetRios extends StatefulWidget {
  const IetRios({super.key});

  @override
  State<IetRios> createState() => _IetRiosState();
}

class _IetRiosState extends State<IetRios> {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> valoresDigitados = {};
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenHeight * 0.65;

    // Definição das dimensões dos cards para larguras maiores e menores que 500px
    final double cardWidth =
        screenWidth > 500 ? screenWidth * 0.16 : screenWidth * 0.4;
    final double cardHeight =
        screenWidth > 500 ? screenWidth * 0.16 : screenWidth * 0.4;

    const EdgeInsets padding = EdgeInsets.all(16.0);
    const TextStyle titleStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );

    BoxDecoration cardDecoration(String asset) => BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(asset),
            fit: BoxFit.fill,
          ),
        );

    Widget buildCard(String asset, Function onTap) {
      return Flexible(
        fit: FlexFit.loose,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
                color: Color.fromARGB(255, 71, 71, 71), width: 0.2),
          ),
          child: InkWell(
            onTap: () => onTap(),
            child: Container(
              decoration: cardDecoration(asset),
              height: cardHeight,
              width: cardWidth,
            ),
          ),
        ),
      );
    }

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
                      "Indicadores IET Rios",
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
                          const SizedBox(height: 10),
                          _buildInputField("CL (µg/L)", ietClController,
                              calcularIETcl, _getFormulaIETcl),
                          _buildInputField("PT (µg/L)", ietPtController,
                              calcularIETpt, _getFormulaIETpt),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_areAllFieldsFilled()) {
                                  // Capturar os valores digitados
                                  valoresDigitados['CL'] = ietClController.text;
                                  valoresDigitados['PT'] = ietPtController.text;
                                  print(
                                      " ${(double.parse(ietClController.text) + double.parse(ietPtController.text) / 2)}");

                                  // Calcular os resultados IQA
                                  final resultadosIET = {
                                    'CL': calcularIETcl(
                                            parseInput(ietClController.text))
                                        .toDouble(),
                                    'PT': calcularIETpt(
                                            parseInput(ietPtController.text))
                                        .toDouble(),
                                  };

                                  // No botão da tela de Reservatórios
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultPageIET(
                                        valores: resultadosIET,
                                        valoresDigitados: valoresDigitados,
                                        tipo: "Rio",
                                      ),
                                    ),
                                  );
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.blue.shade50,
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.functions,
                        color: Colors.blue.shade700,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Fórmula em uso",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Value section
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Valor inserido:",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          parsedValue.toStringAsFixed(2),
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Formula section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 16,
                          color: Colors.blue.shade700,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Fórmula aplicada:",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.shade200,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        formulaUsed,
                        style: GoogleFonts.sourceCodePro(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue.shade900,
                            height: 1.5,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Result section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade200,
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Resultado:",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          result.toStringAsFixed(2),
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Close button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Colors.blue.shade200,
                          width: 1,
                        ),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "FECHAR",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _areAllFieldsFilled() {
    return ietClController.text.isNotEmpty && ietPtController.text.isNotEmpty;
  }

  double parseInput(String input) {
    String sanitizedInput = input.replaceAll(',', '.');
    return double.tryParse(sanitizedInput) ?? 0.0;
  }

  void calculo(double cl, double pt) {
    double ietCla = 10 * (6 - (0.92 - 0.34 * log(cl) / log(2)));
    double ietPt = 10 * (6 - (1.77 - 0.42 * log(pt) / log(2)));
    print("\nRIOS iet-cla: $ietCla \n\nRIOS iet_pt: $ietPt");
  }

  double calcularIETcl(double cl) {
    return 10 * (6 - (0.92 - 0.34 * log(cl) / log(2)));
  }

  double calcularIETpt(double pt) {
    return 10 * (6 - (1.77 - 0.42 * log(pt) / log(2)));
  }

  String _getFormulaIETcl(double clorofila) {
    return "IET(Cla) = 10 × {6 - [0,92 - 0,34 × (ln(Cla)/ln(2))]}";
  }

  String _getFormulaIETpt(double clorofila) {
    return "IET(PT) = 10 × {6 - [1,77 - 0,42 × (ln(PT)/ln(2))]}";
  }
}
