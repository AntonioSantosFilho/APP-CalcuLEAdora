import 'dart:convert';
import 'package:calculeadora/navbart.dart';
import 'package:calculeadora/pdf.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'salvos.dart';

class QualityDescription {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  QualityDescription({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });
}

class ResultPage extends StatefulWidget {
  final Map<String, double> valoresIQA;
  final Map<String, String> valoresDigitados;

  const ResultPage({
    super.key,
    required this.valoresIQA,
    required this.valoresDigitados,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late SharedPreferences prefs;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
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

    setState(() {
      _isSaved = true;
    });

    // Mostrar snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text('Resultado salvo com sucesso!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Resetar o estado após 3 segundos
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isSaved = false;
        });
      }
    });
  }

  QualityDescription _getQualityDescription(double iqa) {
    if (iqa >= 80 && iqa <= 100) {
      return QualityDescription(
        title: 'Ótima',
        description:
            'A água nesta faixa é considerada de ótima qualidade. Ela apresenta baixos níveis de poluentes e altas concentrações de oxigênio dissolvido, o que é ideal para a preservação da vida aquática e para o consumo humano após tratamento convencional.',
        color: Colors.green,
        icon: Icons.check_circle,
      );
    } else if (iqa >= 51 && iqa <= 79) {
      return QualityDescription(
        title: 'Boa',
        description:
            'Nesta faixa, a qualidade da água ainda é considerada boa. Embora possa haver a presença de alguns poluentes em níveis moderados, a água ainda é capaz de sustentar a vida aquática e é apropriada para uso recreativo e para abastecimento humano, desde que tratada.',
        color: Colors.lightGreen,
        icon: Icons.thumb_up,
      );
    } else if (iqa >= 36 && iqa <= 50) {
      return QualityDescription(
        title: 'Razoável',
        description:
            'A água com IQA nesta faixa é considerada de qualidade razoável. Pode apresentar níveis elevados de poluentes, como matéria orgânica e nutrientes, o que pode afetar negativamente a vida aquática e reduzir a clareza da água.',
        color: Colors.amber,
        icon: Icons.warning,
      );
    } else if (iqa >= 20 && iqa <= 35) {
      return QualityDescription(
        title: 'Ruim',
        description:
            'A qualidade da água nesta faixa é classificada como ruim. Há uma presença significativa de poluentes, como matéria orgânica, sedimentos e produtos químicos tóxicos. A concentração de oxigênio dissolvido é baixa, o que pode resultar na morte de organismos aquáticos.',
        color: Colors.orange,
        icon: Icons.error,
      );
    } else {
      return QualityDescription(
        title: 'Péssima',
        description:
            'A água nesta faixa é considerada de qualidade péssima. Está fortemente poluída, com níveis extremamente altos de contaminantes, incluindo produtos químicos tóxicos, metais pesados e nutrientes em excesso que podem causar proliferação de algas e outras plantas aquáticas indesejadas.',
        color: Colors.red,
        icon: Icons.dangerous,
      );
    }
  }

  Color _getCellColor(String quality) {
    switch (quality.toLowerCase()) {
      case 'ótima':
        return Colors.green.withOpacity(0.7);
      case 'boa':
        return Colors.lightGreen.withOpacity(0.7);
      case 'razoável':
        return Colors.amber.withOpacity(0.7);
      case 'ruim':
        return Colors.orange.withOpacity(0.7);
      case 'péssima':
        return Colors.red.withOpacity(0.7);
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double iqaValue = widget.valoresIQA['IQA'] ?? 0.0;
    QualityDescription qualityDescription = _getQualityDescription(iqaValue);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF4467F7),
        elevation: 0,
        title: Text(
          'Resultado IQA',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho com valor do IQA
            Container(
              width: double.infinity,
              color: Color(0xFF4467F7),
              padding: EdgeInsets.only(bottom: 30, left: 20, right: 20),
              child: Column(
                children: [
                  // Valor do IQA
                  Text(
                    iqaValue.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  // Badge de qualidade
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: qualityDescription.color,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          qualityDescription.icon,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Qualidade ${qualityDescription.title}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Curva decorativa
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                height: 30,
                color: Color(0xFF4467F7),
              ),
            ),

            // Conteúdo principal
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Descrição da qualidade
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                qualityDescription.icon,
                                color: qualityDescription.color,
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Qualidade ${qualityDescription.title}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: qualityDescription.color,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            qualityDescription.description,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Tabela de faixas de IQA
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.table_chart,
                                color: Color(0xFF4467F7),
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Faixas de IQA",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4467F7),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Table(
                              border: TableBorder.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4467F7).withOpacity(0.1),
                                  ),
                                  children: [
                                    _buildTableHeader(
                                        'Faixas (AL, MG, MT, PR, RJ, RN, RS)'),
                                    _buildTableHeader(
                                        'Faixas (BA, CE, ES, GO, MS, PB, PE, SP)'),
                                    _buildTableHeader('Avaliação'),
                                  ],
                                ),
                                _buildTableRow('91-100', '80-100', 'Ótima'),
                                _buildTableRow('71-90', '52-79', 'Boa'),
                                _buildTableRow('51-70', '37-51', 'Razoável'),
                                _buildTableRow('26-50', '20-36', 'Ruim'),
                                _buildTableRow('0-25', '0-19', 'Péssima'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Botões de ação
                  Row(
                    children: [
                      // Botão Salvar
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isSaved ? null : _savePreferences,
                          icon: Icon(_isSaved ? Icons.check : Icons.save),
                          label: Text(_isSaved ? "Salvo" : "Salvar"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4467F7),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            disabledBackgroundColor: Colors.grey.shade400,
                          ),
                        ),
                      ),

                      SizedBox(width: 16),

                      // Botão PDF - Usando o widget original
                      Expanded(
                        child: DownloadPDFButton(
                          valoresIQA: widget.valoresIQA,
                          valoresDigitados: widget.valoresDigitados,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Botão Voltar para o menu
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Navbart(),
                          ),
                        );
                      },
                      icon: Icon(Icons.home),
                      label: Text("Voltar para o menu"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  TableRow _buildTableRow(String range1, String range2, String quality) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            range1,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            range2,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          color: _getCellColor(quality),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            quality,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

// Clipper personalizado para criar a curva decorativa
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height / 2);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), 0);
    var secondEndPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
