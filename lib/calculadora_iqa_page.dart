import 'package:flutter/material.dart';
import 'dart:math';

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
  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildInputField(
                "DBO (mg/L)", dboController, calcularIQADBO, _getFormulaDBO),
            _buildInputField(
                "OD (mg/L)", odController, calcularIQAOD, _getFormulaOD),
            _buildInputField("Fósforo (mg/L)", fosforoController,
                calcularIQAFosforo, _getFormulaFosforo),
            _buildInputField("Nitrogênio Total (mg/L)", nitrogenioController,
                calcularIQANitrogenio, _getFormulaNitrogenio),
            _buildInputField("Coliformes Totais (NMP)", coliformesController,
                calcularIQAColiformes, _getFormulaColiformes),
            _buildInputField("Turbidez (NTU)", turbidezController,
                calcularIQATurbidez, _getFormulaTurbidez),
            _buildInputField(
                "Sólidos Suspensos Totais (mg/L)",
                solidosSuspensosController,
                calcularIQASolidosTotais,
                _getFormulaSolidosTotais),
            _buildInputField("Temperatura (°C)", temperaturaController,
                calcularIQADiferencaTemperatura, _getFormulaTemperatura),
            _buildInputField("pH", phController, calcularIQApH, _getFormulaPH),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_areAllFieldsFilled()) {
                    teste();
                    ResultadoIQA();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Por favor, preencha todos os campos.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15.0),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "Calcular",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String labelText, TextEditingController controller,
      Function formulaCallback, Function formulaDescriptionCallback) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Color(0x772666E0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              labelText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controller,
              style:
                  TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0x772666E0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0x772666E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0x772666E0)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintText: '0,00',
                hintStyle: TextStyle(color: Color.fromARGB(255, 207, 207, 207)),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
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
        return AlertDialog(
          title: Text("Fórmula usada"),
          content: Text(
              "Para o valor $parsedValue, a fórmula usada é:\n\n$formulaUsed\n\nO resultado é: $result"),
          actions: [
            TextButton(
              child: Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
    String sanitizedInput = input.replaceAll(',', '.');
    return double.tryParse(sanitizedInput) ?? 0.0;
  }

  void ResultadoIQA() {
    double dbo = parseInput(dboController.text);
    double od = parseInput(odController.text);
    double fosforo = parseInput(fosforoController.text);
    double nitrogenio = parseInput(nitrogenioController.text);
    double coliformes = parseInput(coliformesController.text);
    double turbidez = parseInput(turbidezController.text);
    double solidosSuspensos = parseInput(solidosSuspensosController.text);
    double temperatura = parseInput(temperaturaController.text);
    double ph = parseInput(phController.text);

    double pesoPH = 0.12;
    double pesoDBO5 = 0.10;
    double pesoNitrogenio = 0.10;
    double pesoFosforo = 0.10;
    double pesoTemperatura = 0.10;
    double pesoTurbidez = 0.08;
    double pesoOxigenioDissolvido = 0.17;
    double pesoSolidosTotais = 0.08;
    double pesoEColi = 0.15;

    num resultado = pow(calcularIQADBO(dbo), pesoDBO5) *
        pow(calcularIQANitrogenio(nitrogenio), pesoNitrogenio) *
        pow(calcularIQAFosforo(fosforo), pesoFosforo) *
        pow(calcularIQADiferencaTemperatura(temperatura), pesoTemperatura) *
        pow(calcularIQATurbidez(turbidez), pesoTurbidez) *
        pow(calcularIQASolidosTotais(solidosSuspensos), pesoSolidosTotais) *
        pow(calcularIQAOD(od), pesoOxigenioDissolvido) *
        pow(calcularIQApH(ph), pesoPH) *
        pow(calcularIQAColiformes(coliformes), pesoEColi);

    print("\n\n\nO resultado do IQA é: $resultado");
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

  // Fórmulas para Coliformes
  String _getFormulaColiformes(double coliformes) {
    if (coliformes >= 0 && coliformes <= 1) {
      return "100 - 33 * log($coliformes)";
    } else if (coliformes > 1 && coliformes <= 5) {
      return "100 - 37.2 * log($coliformes) + 3.60743 * pow(log($coliformes), 2)";
    } else if (coliformes > 5) {
      return "Para valores maiores que 5 é usado a constante 3";
    } else {
      return "Valor fora do intervalo esperado";
    }
  }

  double calcularIQAColiformes(double coliformes) {
    if (coliformes >= 0 && coliformes <= 1) {
      return 100 - 33 * log(coliformes);
    } else if (coliformes > 1 && coliformes <= 5) {
      return 100 - 37.2 * log(coliformes) + 3.60743 * pow(log(coliformes), 2);
    } else if (coliformes > 5) {
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
      return 2.00;
    } else {
      throw Exception('Valor de pH fora do intervalo esperado');
    }
  }

  void teste() {
    double dbo = parseInput(dboController.text);
    double od = parseInput(odController.text);
    double fosforo = parseInput(fosforoController.text);
    double nitrogenio = parseInput(nitrogenioController.text);
    double coliformes = parseInput(coliformesController.text);
    double turbidez = parseInput(turbidezController.text);
    double solidosSuspensos = parseInput(solidosSuspensosController.text);
    double temperatura = parseInput(temperaturaController.text);
    double ph = parseInput(phController.text);

    print(
        "calcularIQAColiformes(${coliformes}): ${calcularIQAColiformes(coliformes)}");
    print("calcularIQApH(${ph}): ${calcularIQApH(ph)}");
    print("calcularIQADBO(${dbo}): ${calcularIQADBO(dbo)}");
    print(
        "calcularIQANitrogenio(${nitrogenio}): ${calcularIQANitrogenio(nitrogenio)}");
    print("calcularIQAFosforo(${fosforo}): ${calcularIQAFosforo(fosforo)}");
    print(
        "calcularIQADiferencaTemperatura(): ${calcularIQADiferencaTemperatura(temperatura)}");
    print("calcularIQATurbidez(${turbidez}): ${calcularIQATurbidez(turbidez)}");
    print(
        "calcularIQASolidosTotais(${solidosSuspensos}): ${calcularIQASolidosTotais(solidosSuspensos)}");
    print("calcularIQAOD(${od}): ${calcularIQAOD(od)}");
  }
}
