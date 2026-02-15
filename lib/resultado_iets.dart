import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class ResultPageIET extends StatelessWidget {
  final Map<String, double> valores;
  final Map<String, String> valoresDigitados;
  final String tipo; // "Rio" ou "Reservatório"

  const ResultPageIET({
    Key? key,
    required this.valores,
    required this.valoresDigitados,
    required this.tipo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calcular média
    double media = (valores['CL']! + valores['PT']!) / 2;
    String classificacao = _getClassificacao(media);
    Color classificacaoColor = _getClassificacaoColor(classificacao);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Resultado IET $tipo",
          style: GoogleFonts.gowunBatang(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor:
            tipo == "Rio" ? Colors.blue.shade700 : Colors.green.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: tipo == "Rio"
                ? [Colors.blue.shade700, Colors.blue.shade100]
                : [Colors.green.shade700, Colors.green.shade100],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildResultsCard(
                  tipo,
                  valores,
                  valoresDigitados,
                  media,
                  classificacao,
                  classificacaoColor,
                ),
                const SizedBox(height: 20),
                _buildDetailedResults(media, classificacao),
                const SizedBox(height: 20),
                _buildClassificationTable(),
                const SizedBox(height: 20),
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Índice de Estado Trófico (IET)",
              style: GoogleFonts.gowunBatang(
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "O IET avalia a qualidade da água quanto ao enriquecimento por nutrientes e seu efeito no crescimento excessivo de algas.",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsCard(
    String title,
    Map<String, double> valores,
    Map<String, String> valoresDigitados,
    double media,
    String classificacao,
    Color classificacaoColor,
  ) {
    Color backgroundColor =
        tipo == "Rio" ? Colors.blue.shade200 : Colors.green.shade200;
    Color textColor =
        tipo == "Rio" ? Colors.blue.shade800 : Colors.green.shade800;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "IET $title",
                  style: GoogleFonts.gowunBatang(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: classificacaoColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    classificacao,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            _buildParameterRow("Clorofila (CL)", valoresDigitados['CL'] ?? "0",
                valores['CL']!.toStringAsFixed(2)),
            const SizedBox(height: 8),
            _buildParameterRow(
                "Fósforo Total (PT)",
                valoresDigitados['PT'] ?? "0",
                valores['PT']!.toStringAsFixed(2)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "IET Médio:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    media.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
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

  Widget _buildParameterRow(
      String label, String valorDigitado, String resultado) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Valor: $valorDigitado",
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "IET: $resultado",
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedResults(double media, String classificacao) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Interpretação do Resultado",
              style: GoogleFonts.gowunBatang(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getClassificacaoColor(classificacao).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color:
                        _getClassificacaoColor(classificacao).withOpacity(0.5)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.water_drop,
                        color: _getClassificacaoColor(classificacao),
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        classificacao,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _getClassificacaoColor(classificacao),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getClassificacaoDescricao(classificacao),
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassificationTable() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Classificação do IET",
              style: GoogleFonts.gowunBatang(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              columnWidths: const {
                0: FlexColumnWidth(1.5),
                1: FlexColumnWidth(3),
              },
              children: [
                _buildTableRow("Valor", "Classificação", isHeader: true),
                _buildTableRow("≤ 47", "Ultraoligotrófico",
                    color: Colors.blue.shade50),
                _buildTableRow("47 < IET ≤ 52", "Oligotrófico",
                    color: Colors.blue.shade100),
                _buildTableRow("52 < IET ≤ 59", "Mesotrófico",
                    color: Colors.green.shade100),
                _buildTableRow("59 < IET ≤ 63", "Eutrófico",
                    color: Colors.yellow.shade100),
                _buildTableRow("63 < IET ≤ 67", "Supereutrófico",
                    color: Colors.orange.shade100),
                _buildTableRow("> 67", "Hipereutrófico",
                    color: Colors.red.shade100),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String col1, String col2,
      {bool isHeader = false, Color? color}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? Colors.grey.shade200 : color,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            col1,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            col2,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.refresh),
          label: const Text("Sair", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 166, 120, 120),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  String _getClassificacao(double valor) {
    if (valor <= 47) {
      return "Ultraoligotrófico";
    } else if (valor <= 52) {
      return "Oligotrófico";
    } else if (valor <= 59) {
      return "Mesotrófico";
    } else if (valor <= 63) {
      return "Eutrófico";
    } else if (valor <= 67) {
      return "Supereutrófico";
    } else {
      return "Hipereutrófico";
    }
  }

  Color _getClassificacaoColor(String classificacao) {
    switch (classificacao) {
      case "Ultraoligotrófico":
        return Colors.blue.shade700;
      case "Oligotrófico":
        return Colors.blue.shade500;
      case "Mesotrófico":
        return Colors.green.shade600;
      case "Eutrófico":
        return Colors.yellow.shade700;
      case "Supereutrófico":
        return Colors.orange.shade700;
      case "Hipereutrófico":
        return Colors.red.shade700;
      default:
        return Colors.grey;
    }
  }

  String _getClassificacaoDescricao(String classificacao) {
    switch (classificacao) {
      case "Ultraoligotrófico":
        return "Corpos d'água limpos, de produtividade muito baixa, com concentrações insignificantes de nutrientes que não acarretam prejuízos aos usos da água.";
      case "Oligotrófico":
        return "Corpos d'água limpos, de baixa produtividade, com concentrações baixas de nutrientes, sem interferências indesejáveis sobre os usos da água.";
      case "Mesotrófico":
        return "Corpos d'água com produtividade intermediária, com possíveis implicações sobre a qualidade da água, mas em níveis aceitáveis na maioria dos casos.";
      case "Eutrófico":
        return "Corpos d'água com alta produtividade, com redução da transparência, em geral afetados por atividades humanas, com ocorrência de alterações indesejáveis na qualidade da água.";
      case "Supereutrófico":
        return "Corpos d'água com alta produtividade, com redução da transparência, em geral afetados por atividades humanas, com ocorrência de alterações indesejáveis na qualidade da água, como a ocorrência de episódios de florações de algas.";
      case "Hipereutrófico":
        return "Corpos d'água afetados significativamente pelas elevadas concentrações de matéria orgânica e nutrientes, com comprometimento acentuado nos seus usos, associado a episódios de florações de algas ou mortandades de peixes.";
      default:
        return "Classificação não disponível.";
    }
  }
}
