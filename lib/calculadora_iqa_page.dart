import 'package:calculeadora/result_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

// Controllers para os campos de entrada
TextEditingController dboController = TextEditingController();
TextEditingController odController = TextEditingController();
TextEditingController fosforoController = TextEditingController();
TextEditingController nitrogenioController = TextEditingController();
TextEditingController coliformesController = TextEditingController();
TextEditingController turbidezController = TextEditingController();
TextEditingController solidosSuspensosController = TextEditingController();
TextEditingController temperaturaController = TextEditingController();
TextEditingController phController = TextEditingController();

class Calculadoraiqa extends StatefulWidget {
  const Calculadoraiqa({super.key});

  @override
  State<Calculadoraiqa> createState() => _CalculadoraiqaState();
}

class _CalculadoraiqaState extends State<Calculadoraiqa> {
  // Mapa para armazenar ícones para cada parâmetro
  final Map<String, IconData> parameterIcons = {
    "DBO": Icons.opacity,
    "OD": Icons.air,
    "Fósforo": Icons.science,
    "Nitrogênio Total": Icons.eco,
    "Coliformes Totais": Icons.bug_report,
    "Turbidez": Icons.water,
    "Sólidos Suspensos Totais": Icons.grain,
    "Diferença de Temperatura": Icons.thermostat,
    "pH": Icons.balance,
  };

  // Mapa para armazenar descrições curtas para cada parâmetro
  final Map<String, String> parameterDescriptions = {
    "DBO":
        "Demanda Bioquímica de Oxigênio - mede a quantidade de oxigênio consumido na degradação da matéria orgânica.",
    "OD":
        "Oxigênio Dissolvido - indica a quantidade de oxigênio disponível na água para a respiração dos organismos aquáticos.",
    "Fósforo":
        "Nutriente essencial para os organismos aquáticos, mas em excesso pode causar eutrofização.",
    "Nitrogênio Total":
        "Nutriente importante para o crescimento de plantas aquáticas, mas em excesso pode causar problemas ambientais.",
    "Coliformes Totais": "Indicadores de contaminação fecal na água.",
    "Turbidez":
        "Medida da claridade da água, afetada por partículas suspensas.",
    "Sólidos Suspensos Totais":
        "Partículas sólidas suspensas na água que podem afetar sua qualidade.",
    "Diferença de Temperatura":
        "Variação de temperatura que pode afetar os organismos aquáticos.",
    "pH":
        "Medida da acidez ou alcalinidade da água, afeta a vida aquática e processos químicos.",
  };

  // Lista para organizar os parâmetros em dois grupos
  final List<Map<String, dynamic>> parameterGroups = [
    {
      "title": "Parâmetros Físicos",
      "color": Color(0xFF3486EB),
      "icon": Icons.water_drop,
      "parameters": [
        "Turbidez",
        "Sólidos Suspensos Totais",
        "Diferença de Temperatura"
      ]
    },
    {
      "title": "Parâmetros Químicos",
      "color": Color(0xFF34C759),
      "icon": Icons.science,
      "parameters": ["DBO", "OD", "Fósforo", "Nitrogênio Total", "pH"]
    },
    {
      "title": "Parâmetros Biológicos",
      "color": Color(0xFFFF9500),
      "icon": Icons.bug_report,
      "parameters": ["Coliformes Totais"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    final Map<String, String> valoresDigitados = {};
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight =
        screenHeight * 0.75; // Aumentei um pouco a altura do container

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: containerHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Título da seção
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Text(
                      "Calculadora IQA",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xFF2666E0),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Preencha os parâmetros abaixo",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Área de rolagem para os parâmetros
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Iteramos pelos grupos de parâmetros
                      ...parameterGroups
                          .map((group) => _buildParameterGroup(group)),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Botão de calcular (fixo na parte inferior)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: () {
                    if (_areAllFieldsFilled()) {
                      // Capturar os valores digitados
                      valoresDigitados['DBO'] = dboController.text;
                      valoresDigitados['OD'] = odController.text;
                      valoresDigitados['Fósforo'] = fosforoController.text;
                      valoresDigitados['Nitrogênio'] =
                          nitrogenioController.text;
                      valoresDigitados['Coliformes'] =
                          coliformesController.text;
                      valoresDigitados['Turbidez'] = turbidezController.text;
                      valoresDigitados['Sólidos Suspensos'] =
                          solidosSuspensosController.text;
                      valoresDigitados['Temperatura'] =
                          temperaturaController.text;
                      valoresDigitados['pH'] = phController.text;

                      // Calcular os resultados IQA
                      final resultadosIQA = {
                        'DBO': calcularIQADBO(parseInput(dboController.text))
                            .toDouble(),
                        'OD': calcularIQAOD(parseInput(odController.text))
                            .toDouble(),
                        'Fósforo': calcularIQAFosforo(
                                parseInput(fosforoController.text))
                            .toDouble(),
                        'Nitrogênio': calcularIQANitrogenio(
                                parseInput(nitrogenioController.text))
                            .toDouble(),
                        'Coliformes': calcularIQAColiformes(
                                parseInput(coliformesController.text))
                            .toDouble(),
                        'Turbidez': calcularIQATurbidez(
                                parseInput(turbidezController.text))
                            .toDouble(),
                        'Sólidos Suspensos': calcularIQASolidosTotais(
                                parseInput(solidosSuspensosController.text))
                            .toDouble(),
                        'Temperatura': calcularIQADiferencaTemperatura(
                                parseInput(temperaturaController.text))
                            .toDouble(),
                        'pH': calcularIQApH(parseInput(phController.text))
                            .toDouble(),
                        'IQA': pow(
                                    calcularIQADBO(
                                        parseInput(dboController.text)),
                                    0.10)
                                .toDouble() *
                            pow(calcularIQAOD(parseInput(odController.text)), 0.17)
                                .toDouble() *
                            pow(calcularIQAFosforo(parseInput(fosforoController.text)), 0.10)
                                .toDouble() *
                            pow(calcularIQANitrogenio(parseInput(nitrogenioController.text)), 0.10)
                                .toDouble() *
                            pow(
                                    calcularIQAColiformes(
                                        parseInput(coliformesController.text)),
                                    0.15)
                                .toDouble() *
                            pow(calcularIQATurbidez(parseInput(turbidezController.text)), 0.08)
                                .toDouble() *
                            pow(calcularIQASolidosTotais(parseInput(solidosSuspensosController.text)), 0.08)
                                .toDouble() *
                            pow(
                                    calcularIQADiferencaTemperatura(
                                        parseInput(temperaturaController.text)),
                                    0.10)
                                .toDouble() *
                            pow(calcularIQApH(parseInput(phController.text)), 0.12)
                                .toDouble(),
                      };

                      // Passar os valores para a próxima página
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            valoresIQA: resultadosIQA,
                            valoresDigitados: valoresDigitados,
                          ),
                        ),
                      );
                    } else {
                      _showErrorSnackbar();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: const Color(0xFF2666E0),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calculate, size: 24),
                      const SizedBox(width: 10),
                      Text(
                        "Calcular IQA",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para construir um grupo de parâmetros
  Widget _buildParameterGroup(Map<String, dynamic> group) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho do grupo
          Container(
            margin: const EdgeInsets.only(left: 8, bottom: 8),
            child: Row(
              children: [
                Icon(
                  group["icon"],
                  color: group["color"],
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  group["title"],
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: group["color"],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Parâmetros no grupo
          ...group["parameters"].map<Widget>((paramName) {
            // Mapeamento dos nomes de parâmetros para os controllers
            final Map<String, TextEditingController> controllerMap = {
              "DBO": dboController,
              "OD": odController,
              "Fósforo": fosforoController,
              "Nitrogênio Total": nitrogenioController,
              "Coliformes Totais": coliformesController,
              "Turbidez": turbidezController,
              "Sólidos Suspensos Totais": solidosSuspensosController,
              "Diferença de Temperatura": temperaturaController,
              "pH": phController,
            };

            // Mapeamento dos nomes de parâmetros para as funções de cálculo
            final Map<String, Function> calculoMap = {
              "DBO": calcularIQADBO,
              "OD": calcularIQAOD,
              "Fósforo": calcularIQAFosforo,
              "Nitrogênio Total": calcularIQANitrogenio,
              "Coliformes Totais": calcularIQAColiformes,
              "Turbidez": calcularIQATurbidez,
              "Sólidos Suspensos Totais": calcularIQASolidosTotais,
              "Diferença de Temperatura": calcularIQADiferencaTemperatura,
              "pH": calcularIQApH,
            };

            // Mapeamento dos nomes de parâmetros para as funções de descrição de fórmula
            final Map<String, Function> formulaDescMap = {
              "DBO": _getFormulaDBO,
              "OD": _getFormulaOD,
              "Fósforo": _getFormulaFosforo,
              "Nitrogênio Total": _getFormulaNitrogenio,
              "Coliformes Totais": _getFormulaColiformes,
              "Turbidez": _getFormulaTurbidez,
              "Sólidos Suspensos Totais": _getFormulaSolidosTotais,
              "Diferença de Temperatura": _getFormulaTemperatura,
              "pH": _getFormulaPH,
            };

            // Mapeamento dos nomes de parâmetros para os títulos de campo
            final Map<String, String> fieldTitleMap = {
              "DBO": "DBO (mg/L)",
              "OD": "OD (%saturação)",
              "Fósforo": "Fósforo (mg/L)",
              "Nitrogênio Total": "Nitrogênio Total (mg/L)",
              "Coliformes Totais": "Coliformes Totais (NMP/100mL)",
              "Turbidez": "Turbidez (NTU)",
              "Sólidos Suspensos Totais": "Sólidos Suspensos Totais (mg/L)",
              "Diferença de Temperatura": "Diferença de Temperatura (°C)",
              "pH": "pH",
            };

            return _buildParameterCard(
              fieldTitleMap[paramName] ?? paramName,
              controllerMap[paramName] ?? TextEditingController(),
              calculoMap[paramName] ?? ((v) => 0.0),
              formulaDescMap[paramName] ?? ((v) => ""),
              parameterIcons[paramName] ?? Icons.help_outline,
              parameterDescriptions[paramName] ?? "",
              group["color"],
            );
          }).toList(),
        ],
      ),
    );
  }

  // Widget para construir um cartão de parâmetro individual
  Widget _buildParameterCard(
    String labelText,
    TextEditingController controller,
    Function formulaCallback,
    Function formulaDescriptionCallback,
    IconData icon,
    String description,
    Color groupColor,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho do parâmetro com ícone e título
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: groupColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: groupColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    labelText,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Descrição do parâmetro
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: Text(
                description,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Campo de entrada
            TextField(
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              controller: controller,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF333333),
                ),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                hintText: '0,00',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: Icon(Icons.input, color: Colors.grey.shade500),
              ),
            ),

            // Botão para mostrar a fórmula
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                icon: Icon(Icons.info_outline, size: 16, color: groupColor),
                label: Text(
                  "Ver fórmula",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 12,
                      color: groupColor,
                    ),
                  ),
                ),
                onPressed: () {
                  _showFormulaDialog(
                    context,
                    controller.text,
                    formulaCallback,
                    formulaDescriptionCallback,
                    labelText,
                    icon,
                    groupColor,
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFormulaDialog(
    BuildContext context,
    String inputValue,
    Function formulaCallback,
    Function formulaDescriptionCallback,
    String parameterName,
    IconData icon,
    Color groupColor,
  ) {
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
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Cabeçalho do diálogo
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: groupColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon,
                        color: groupColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fórmula para $parameterName",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                          Text(
                            "Valor inserido: ${parsedValue.toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Fórmula utilizada
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fórmula aplicada:",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formulaUsed,
                        style: GoogleFonts.robotoMono(
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: groupColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Resultado do cálculo
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: groupColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: groupColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Resultado do QI:",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            result.isNaN
                                ? "Valor inválido"
                                : result.toStringAsFixed(2),
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: result.isNaN ? Colors.red : groupColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Botão de fechar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: groupColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Fechar",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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

  void _showErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 10),
            const Text('Por favor, preencha todos os campos.'),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  bool _areAllFieldsFilled() {
    return dboController.text.isNotEmpty &&
        odController.text.isNotEmpty &&
        fosforoController.text.isNotEmpty &&
        nitrogenioController.text.isNotEmpty &&
        coliformesController.text.isNotEmpty &&
        turbidezController.text.isNotEmpty &&
        solidosSuspensosController.text.isNotEmpty &&
        temperaturaController.text.isNotEmpty &&
        phController.text.isNotEmpty;
  }

  double parseInput(String input) {
    if (input.isEmpty) return 0.0;
    String sanitizedInput = input.replaceAll(',', '.');
    return double.tryParse(sanitizedInput) ?? 0.0;
  }

  // Fórmulas para DBO
  String _getFormulaDBO(double dbo) {
    if (dbo >= 0 && dbo <= 5) {
      return "99 * exp(-0.1232728 * $dbo)";
    } else if (dbo > 5 && dbo <= 15) {
      return "104.67 - 31.5463 * log($dbo)";
    } else if (dbo > 15 && dbo <= 30) {
      return "4394.91 * pow($dbo, -1.99809)";
    } else if (dbo > 30) {
      return "Valor padrão: 2.00";
    } else {
      return "Valor fora do intervalo esperado";
    }
  }

  double calcularIQADBO(double dbo) {
    if (dbo >= 0 && dbo <= 5) {
      return 99 * exp(-0.1232728 * dbo);
    } else if (dbo > 5 && dbo <= 15) {
      return 104.67 - 31.5463 * log(dbo);
    } else if (dbo > 15 && dbo <= 30) {
      return 4394.91 * pow(dbo, -1.99809);
    } else if (dbo > 30) {
      return 2.00;
    } else {
      throw Exception('Valor de DBO fora do intervalo esperado');
    }
  }

  // Fórmulas para OD
  String _getFormulaOD(double oxigenioDissolvido) {
    if (oxigenioDissolvido >= 0 && oxigenioDissolvido <= 50) {
      return "3 + 0.34 * $oxigenioDissolvido + 0.008095 * pow($oxigenioDissolvido, 2) + 1.35252e-5 * pow($oxigenioDissolvido, 3)";
    } else if (oxigenioDissolvido > 50 && oxigenioDissolvido <= 85) {
      return "3 - 1.166 * $oxigenioDissolvido + 0.058 * pow($oxigenioDissolvido, 2) - 3.803435e-4 * pow($oxigenioDissolvido, 3)";
    } else if (oxigenioDissolvido > 85 && oxigenioDissolvido <= 100) {
      return "3 + 3.7745 * pow($oxigenioDissolvido, 0.704889)";
    } else if (oxigenioDissolvido > 100 && oxigenioDissolvido <= 140) {
      return "3 + 2.9 * $oxigenioDissolvido - 0.02496 * pow($oxigenioDissolvido, 2) + 5.60919e-5 * pow($oxigenioDissolvido, 3)";
    } else if (oxigenioDissolvido > 140) {
      return "Valor padrão: 50.00";
    } else {
      return "Valor fora do intervalo esperado";
    }
  }

  double calcularIQAOD(double oxigenioDissolvido) {
    if (oxigenioDissolvido >= 0 && oxigenioDissolvido <= 50) {
      return 3 +
          0.34 * oxigenioDissolvido +
          0.008095 * pow(oxigenioDissolvido, 2) +
          1.35252e-5 * pow(oxigenioDissolvido, 3);
    } else if (oxigenioDissolvido > 50 && oxigenioDissolvido <= 85) {
      return 3 -
          1.166 * oxigenioDissolvido +
          0.058 * pow(oxigenioDissolvido, 2) -
          3.803435e-4 * pow(oxigenioDissolvido, 3);
    } else if (oxigenioDissolvido > 85 && oxigenioDissolvido <= 100) {
      return 3 + 3.7745 * pow(oxigenioDissolvido, 0.704889);
    } else if (oxigenioDissolvido > 100 && oxigenioDissolvido <= 140) {
      return 3 +
          2.9 * oxigenioDissolvido -
          0.02496 * pow(oxigenioDissolvido, 2) +
          5.60919e-5 * pow(oxigenioDissolvido, 3);
    } else if (oxigenioDissolvido > 140) {
      return 50.00;
    } else {
      throw Exception(
          'Valor de Oxigênio Dissolvido fora do intervalo esperado');
    }
  }

  // Fórmulas para Fósforo
  String _getFormulaFosforo(double fosforo) {
    if (fosforo >= 0 && fosforo <= 1) {
      return "99 * exp(-0.91629 * $fosforo)";
    } else if (fosforo > 1 && fosforo <= 5) {
      return "57.6 - 20.178 * $fosforo + 2.1326 * pow($fosforo, 2)";
    } else if (fosforo > 5 && fosforo <= 10) {
      return "19.8 * exp(-0.13544 * $fosforo)";
    } else if (fosforo > 10) {
      return "Valor padrão: 5.00";
    } else {
      return "Valor fora do intervalo esperado";
    }
  }

  double calcularIQAFosforo(double fosforo) {
    if (fosforo >= 0 && fosforo <= 1) {
      return 99 * exp(-0.91629 * fosforo);
    } else if (fosforo > 1 && fosforo <= 5) {
      return 57.6 - 20.178 * fosforo + 2.1326 * pow(fosforo, 2);
    } else if (fosforo > 5 && fosforo <= 10) {
      return 19.8 * exp(-0.13544 * fosforo);
    } else if (fosforo > 10) {
      return 5.00;
    } else {
      throw Exception('Valor de Fósforo fora do intervalo esperado');
    }
  }

  // Fórmulas para Nitrogênio
  String _getFormulaNitrogenio(double nitrogenio) {
    if (nitrogenio >= 0 && nitrogenio <= 10) {
      return "100 - 8.169 * $nitrogenio + 0.3059 * pow($nitrogenio, 2)";
    } else if (nitrogenio > 10 && nitrogenio <= 60) {
      return "101.9 - 23.1023 * log($nitrogenio)";
    } else if (nitrogenio > 60 && nitrogenio <= 100) {
      return "159.3148 * exp(-0.0512842 * $nitrogenio)";
    } else if (nitrogenio > 100) {
      return "Valor padrão: 1.00";
    } else {
      return "Valor fora do intervalo esperado";
    }
  }

  double calcularIQANitrogenio(double nitrogenio) {
    if (nitrogenio >= 0 && nitrogenio <= 10) {
      return 100 - 8.169 * nitrogenio + 0.3059 * pow(nitrogenio, 2);
    } else if (nitrogenio > 10 && nitrogenio <= 60) {
      return 101.9 - 23.1023 * log(nitrogenio);
    } else if (nitrogenio > 60 && nitrogenio <= 100) {
      return 159.3148 * exp(-0.0512842 * nitrogenio);
    } else if (nitrogenio > 100) {
      return 1.00;
    } else {
      throw Exception('Valor de Nitrogênio fora do intervalo esperado');
    }
  }

  double logBase10(double x) {
    return log(x) / log(10);
  }

  // Fórmulas para Coliformes
  String _getFormulaColiformes(double coliformes) {
    double newvar = logBase10(coliformes);
    if (newvar >= 0 && newvar <= 1) {
      return "100 - 33 * logBase10($coliformes)";
    } else if (newvar > 1 && newvar <= 5) {
      return "100 - 37.2 * logBase10($coliformes) + 3.60743 * pow(logBase10($coliformes), 2)";
    } else if (newvar > 5) {
      return "Para valores maiores que 5 é usado a constante 3";
    } else {
      return "Valor fora do intervalo esperado";
    }
  }

  double calcularIQAColiformes(double coliformes) {
    if (coliformes <= 0) coliformes = 0.01; // Evitar log de zero ou negativo
    double newvar = logBase10(coliformes);

    if (newvar >= 0 && newvar <= 1) {
      return 100 - 33 * logBase10(coliformes);
    } else if (newvar > 1 && newvar <= 5) {
      return 100 -
          37.2 * logBase10(coliformes) +
          3.60743 * pow(logBase10(coliformes), 2);
    } else if (newvar > 5) {
      return 3;
    } else {
      throw Exception('Valor de coliformes fora do intervalo esperado');
    }
  }

  // Fórmulas para Turbidez
  String _getFormulaTurbidez(double turbidez) {
    if (turbidez >= 0 && turbidez <= 25) {
      return "100.17 - 2.67 * $turbidez + 0.03775 * pow($turbidez, 2)";
    } else if (turbidez > 25 && turbidez <= 100) {
      return "84.76 * exp(-0.016206 * $turbidez)";
    } else if (turbidez > 100) {
      return "Valor padrão: 5.00";
    } else {
      return "Valor fora do intervalo esperado";
    }
  }

  double calcularIQATurbidez(double turbidez) {
    if (turbidez >= 0 && turbidez <= 25) {
      return 100.17 - 2.67 * turbidez + 0.03775 * pow(turbidez, 2);
    } else if (turbidez > 25 && turbidez <= 100) {
      return 84.76 * exp(-0.016206 * turbidez);
    } else if (turbidez > 100) {
      return 5.00;
    } else {
      throw Exception('Valor de Turbidez fora do intervalo esperado');
    }
  }

  // Fórmulas para Sólidos Totais
  String _getFormulaSolidosTotais(double solidosTotais) {
    if (solidosTotais >= 0 && solidosTotais <= 150) {
      return "79.75 + 0.166 * $solidosTotais - 0.001088 * pow($solidosTotais, 2)";
    } else if (solidosTotais > 150 && solidosTotais <= 500) {
      return "101.67 - 0.13917 * $solidosTotais";
    } else if (solidosTotais > 500) {
      return "Valor padrão: 32.00";
    } else {
      return "Valor fora do intervalo esperado";
    }
  }

  double calcularIQASolidosTotais(double solidosTotais) {
    if (solidosTotais >= 0 && solidosTotais <= 150) {
      return 79.75 + 0.166 * solidosTotais - 0.001088 * pow(solidosTotais, 2);
    } else if (solidosTotais > 150 && solidosTotais <= 500) {
      return 101.67 - 0.13917 * solidosTotais;
    } else if (solidosTotais > 500) {
      return 32.00;
    } else {
      throw Exception('Valor de Sólidos Totais fora do intervalo esperado');
    }
  }

  // Fórmulas para Temperatura
  String _getFormulaTemperatura(double temperatura) {
    return "Valor constante: 94.00";
  }

  double calcularIQADiferencaTemperatura(double temperatura) {
    return 94.00; // Constante
  }

  // Fórmulas para pH
  String _getFormulaPH(double ph) {
    if (ph >= 0 && ph <= 2) {
      return "2.00";
    } else if (ph > 2 && ph <= 4) {
      return "13.6 - 10.6 * $ph + 2.4364 * pow($ph, 2)";
    } else if (ph >= 4 && ph <= 6.2) {
      return "155.5 - 77.36 * $ph + 10.2481 * pow($ph, 2)";
    } else if (ph > 6.2 && ph <= 7) {
      return "-657.2 + 197.38 * $ph - 12.9167 * pow($ph, 2)";
    } else if (ph > 7 && ph <= 8) {
      return "-427.8 + 142.05 * $ph - 9.695 * pow($ph, 2)";
    } else if (ph > 8 && ph <= 8.5) {
      return "216 - 16 * $ph";
    } else if (ph > 8.5 && ph <= 9) {
      return "1415823 * exp(-1.1507 * $ph)";
    } else if (ph > 9 && ph <= 10) {
      return "50 - 32 * ($ph - 9)";
    } else if (ph > 10 && ph <= 12) {
      return "633 - 106.5 * $ph + 4.5 * pow($ph, 2)";
    } else if (ph > 12 && ph <= 14) {
      return "3.00";
    } else {
      return "Valor fora do intervalo esperado";
    }
  }

  double calcularIQApH(double ph) {
    if (ph >= 0 && ph < 2) {
      return 2.00;
    } else if (ph >= 2 && ph < 4) {
      return 13.6 - 10.6 * ph + 2.4364 * pow(ph, 2);
    } else if (ph >= 4 && ph < 6.2) {
      return 155.5 - 77.36 * ph + 10.2481 * pow(ph, 2);
    } else if (ph >= 6.2 && ph < 7) {
      return -657.2 + 197.38 * ph - 12.9167 * pow(ph, 2);
    } else if (ph >= 7 && ph < 8) {
      return -427.8 + 142.05 * ph - 9.695 * pow(ph, 2);
    } else if (ph >= 8 && ph < 8.5) {
      return 216 - 16 * ph;
    } else if (ph >= 8.5 && ph < 9) {
      return 1415823 * exp(-1.1507 * ph);
    } else if (ph >= 9 && ph < 10) {
      return 50 - 32 * (ph - 9);
    } else if (ph >= 10 && ph < 12) {
      return 633 - 106.5 * ph + 4.5 * pow(ph, 2);
    } else if (ph >= 12 && ph <= 14) {
      return 3.00;
    } else {
      throw Exception('Valor de pH fora do intervalo esperado');
    }
  }
}
