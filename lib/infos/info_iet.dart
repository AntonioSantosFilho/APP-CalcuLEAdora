import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoIET extends StatefulWidget {
  const InfoIET({super.key});

  @override
  State<InfoIET> createState() => _InfoIETState();
}

class _InfoIETState extends State<InfoIET> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = screenHeight * 0.80;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: containerHeight,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Cabeçalho
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF34C759),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.eco,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "IET",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Índice do Estado Trófico",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Conteúdo com rolagem
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seção de introdução
                    _buildSectionTitle("Sobre o IET", Icons.info_outline),
                    _buildParagraph(
                        "O Índice do Estado Trófico (IET) tem por finalidade classificar corpos d'água em diferentes graus de trofia, avaliando a qualidade da água quanto ao enriquecimento por nutrientes e seu efeito no crescimento excessivo de algas ou aumento da infestação de macrófitas aquáticas."),
                    _buildParagraph(
                        "O IET utiliza duas variáveis principais: a clorofila a e o fósforo total, enquanto a transparência não é considerada em muitos casos devido à sua representatividade limitada. O IET é composto pelo Índice do Estado Trófico para o fósforo (IET(PT)) e para a clorofila a (IET(CL)), ambos modificados por Lamparelli (2004)."),

                    const SizedBox(height: 24),

                    // Seção de equações
                    _buildSectionTitle(
                        "Equações para o Cálculo", Icons.functions),
                    _buildFormulaCard(
                        "Rios",
                        [
                          "IET (CL) = 10x(6-((-0,7-0,6x(ln CL))/ln 2))-20",
                          "IET (PT) = 10x(6-((0,42-0,36x(ln PT))/ln 2))-20"
                        ],
                        const Color(0xFF3486EB)),
                    const SizedBox(height: 12),
                    _buildFormulaCard(
                        "Reservatórios",
                        [
                          "IET (CL) = 10x(6-((0,92-0,34x(ln CL))/ln 2))",
                          "IET (PT) = 10x(6-(1,77-0,42x(ln PT)/ln 2))"
                        ],
                        const Color(0xFF34C759)),
                    const SizedBox(height: 12),
                    _buildFormulaCard(
                        "Onde",
                        [
                          "PT: concentração de fósforo total medida à superfície da água, em µg.L-1",
                          "CL: concentração de clorofila a medida à superfície da água, em µg.L-1",
                          "ln: logaritmo natural"
                        ],
                        Colors.grey.shade700),

                    const SizedBox(height: 24),

                    // Seção de classificação para rios
                    _buildSectionTitle("Classificação para Rios", Icons.water),
                    _buildTrophicStateTable(true),

                    const SizedBox(height: 24),

                    // Seção de classificação para reservatórios
                    _buildSectionTitle(
                        "Classificação para Reservatórios", Icons.water_damage),
                    _buildTrophicStateTable(false),

                    const SizedBox(height: 24),

                    // Seção de classificação geral
                    _buildSectionTitle(
                        "Classificação Geral do IET", Icons.category),
                    _buildGeneralClassificationTable(),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para título de seção
  Widget _buildSectionTitle(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF34C759).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF34C759),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFF34C759),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para parágrafo de texto
  Widget _buildParagraph(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Color(0xFF333333),
            fontSize: 15,
            height: 1.5,
          ),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  // Widget para card de fórmula
  Widget _buildFormulaCard(String title, List<String> formulas, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    title == "Onde" ? Icons.help_outline : Icons.functions,
                    color: color,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...formulas
                .map((formula) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        formula,
                        style: GoogleFonts.robotoMono(
                          textStyle: TextStyle(
                            color: color,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  // Widget para tabela de estado trófico
  Widget _buildTrophicStateTable(bool isRiver) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Legenda de cores
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildColorLegend('Ultraoligotrófico', Colors.blue.shade300),
                  _buildColorLegend('Oligotrófico', Colors.blue.shade600),
                  _buildColorLegend('Mesotrófico', Colors.green.shade400),
                  _buildColorLegend('Eutrófico', Colors.amber.shade500),
                  _buildColorLegend('Supereutrófico', Colors.orange.shade600),
                  _buildColorLegend('Hipereutrófico', Colors.red.shade600),
                ],
              ),
            ),

            // Tabela com rolagem horizontal
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: isRiver
                    ? _buildRiverTrophicTable()
                    : _buildReservoirTrophicTable(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Adicione esta função para criar a legenda de cores
  Widget _buildColorLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 12,
              color: Color(0xFF333333),
            ),
          ),
        ),
      ],
    );
  }

  // Tabela para rios
  Widget _buildRiverTrophicTable() {
    return DataTable(
      headingRowColor: MaterialStateProperty.all(
        const Color(0xFF34C759).withOpacity(0.1),
      ),
      columnSpacing: 16,
      headingTextStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Color(0xFF34C759),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      dataTextStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 13,
        ),
      ),
      columns: const [
        DataColumn(label: Text('Categoria (Estado Trófico)')),
        DataColumn(label: Text('IET')),
        DataColumn(label: Text('P-total (mg.m-3)')),
        DataColumn(label: Text('Clorofila a (mg.m-3)')),
      ],
      rows: [
        _buildColoredDataRow(
            ['Ultraoligotrófico', 'IET ≤ 47', 'P ≤ 13', 'CL ≤ 0,74'],
            Colors.blue.shade300),
        _buildColoredDataRow([
          'Oligotrófico',
          '47 < IET ≤ 52',
          '13 < P ≤ 35',
          '0,74 < CL ≤ 1,31'
        ], Colors.blue.shade600),
        _buildColoredDataRow([
          'Mesotrófico',
          '52 < IET ≤ 59',
          '35 < P ≤ 137',
          '1,31 < CL ≤ 2,96'
        ], Colors.green.shade400),
        _buildColoredDataRow(
            ['Eutrófico', '59 < IET ≤ 63', '137 < P ≤ 296', '2,96 < CL ≤ 4,70'],
            Colors.amber.shade500),
        _buildColoredDataRow([
          'Supereutrófico',
          '63 < IET ≤ 67',
          '296 < P ≤ 640',
          '4,70 < CL ≤ 7,46'
        ], Colors.orange.shade600),
        _buildColoredDataRow(
            ['Hipereutrófico', 'IET > 67', 'P > 640', 'CL > 7,46'],
            Colors.red.shade600),
      ],
    );
  }

  // Tabela para reservatórios
  Widget _buildReservoirTrophicTable() {
    return DataTable(
      headingRowColor: MaterialStateProperty.all(
        const Color(0xFF34C759).withOpacity(0.1),
      ),
      columnSpacing: 16,
      headingTextStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Color(0xFF34C759),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      dataTextStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 13,
        ),
      ),
      columns: const [
        DataColumn(label: Text('Categoria (Estado Trófico)')),
        DataColumn(label: Text('IET')),
        DataColumn(label: Text('Secchi (m)')),
        DataColumn(label: Text('P-total (mg.m-3)')),
        DataColumn(label: Text('Clorofila a (mg.m-3)')),
      ],
      rows: [
        _buildColoredDataRow(
            ['Ultraoligotrófico', 'IET ≤ 47', 'S ≥ 2,4', 'P ≤ 8', 'CL ≤ 1,17'],
            Colors.blue.shade300),
        _buildColoredDataRow([
          'Oligotrófico',
          '47 < IET ≤ 52',
          '2,4 > S ≥ 1,7',
          '8 < P ≤ 19',
          '1,17 < CL ≤ 3,24'
        ], Colors.blue.shade600),
        _buildColoredDataRow([
          'Mesotrófico',
          '52 < IET ≤ 59',
          '1,7 > S ≥ 1,1',
          '19 < P ≤ 52',
          '3,24 < CL ≤ 11,03'
        ], Colors.green.shade400),
        _buildColoredDataRow([
          'Eutrófico',
          '59 < IET ≤ 63',
          '1,1 > S ≥ 0,8',
          '52 < P ≤ 120',
          '11,03 < CL ≤ 30,55'
        ], Colors.amber.shade500),
        _buildColoredDataRow([
          'Supereutrófico',
          '63 < IET ≤ 67',
          '0,8 > S ≥ 0,6',
          '120 < P ≤ 233',
          '30,55 < CL ≤ 69,05'
        ], Colors.orange.shade600),
        _buildColoredDataRow(
            ['Hipereutrófico', 'IET > 67', 'S < 0,6', 'P > 233', 'CL > 69,05'],
            Colors.red.shade600),
      ],
    );
  }

  // Widget para tabela de classificação geral
  Widget _buildGeneralClassificationTable() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(1),
                  },
                  children: [
                    _buildTableHeader(
                        ['Categoria (Estado Trófico)', 'Ponderação']),
                    _buildColoredTableRow(
                        ['Ultraoligotrófico', '0,5'], Colors.blue.shade300),
                    _buildColoredTableRow(
                        ['Oligotrófico', '1'], Colors.blue.shade600),
                    _buildColoredTableRow(
                        ['Mesotrófico', '2'], Colors.green.shade400),
                    _buildColoredTableRow(
                        ['Eutrófico', '3'], Colors.amber.shade500),
                    _buildColoredTableRow(
                        ['Supereutrófico', '4'], Colors.orange.shade600),
                    _buildColoredTableRow(
                        ['Hipereutrófico', '5'], Colors.red.shade600),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Funções auxiliares para construir tabelas
  DataRow _buildColoredDataRow(List<String> cells, Color color) {
    return DataRow(
      color: MaterialStateProperty.all(color.withOpacity(0.1)),
      cells: cells
          .map((cell) => DataCell(
                Row(
                  children: [
                    if (cells.indexOf(cell) == 0) ...[
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(cell),
                  ],
                ),
              ))
          .toList(),
    );
  }

  TableRow _buildTableHeader(List<String> cells) {
    return TableRow(
      decoration: BoxDecoration(
        color: const Color(0xFF34C759).withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      children: cells
          .map((cell) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Text(
                  cell,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF34C759),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  TableRow _buildColoredTableRow(List<String> cells, Color color) {
    return TableRow(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  cells[0],
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Text(
            cells[1],
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ),
      ],
    );
  }

  DataRow _buildDataRow(List<String> cells) {
    return DataRow(
      cells: cells.map((cell) => DataCell(Text(cell))).toList(),
    );
  }

  TableRow _buildTableRow(List<String> cells) {
    return TableRow(
      children: cells
          .map((cell) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Text(
                  cell,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
