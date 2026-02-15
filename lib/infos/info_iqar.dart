import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoIQAR extends StatefulWidget {
  const InfoIQAR({super.key});

  @override
  State<InfoIQAR> createState() => _InfoIQARState();
}

class _InfoIQARState extends State<InfoIQAR> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenHeight * 0.80;
    final bool isSmallScreen = screenWidth < 600;

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
              padding: EdgeInsets.symmetric(
                  vertical: isSmallScreen ? 16 : 24,
                  horizontal: isSmallScreen ? 16 : 20),
              decoration: const BoxDecoration(
                color: Color(0xFFFF9500),
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
                          Icons.air,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "IQAR",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 24 : 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Índice de Qualidade do Ar",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 14 : 16,
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
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seção de introdução
                    _buildSectionTitle("Sobre o IQAR", Icons.info_outline),
                    _buildParagraph(
                        "O Índice de Qualidade do Ar (IQAR) é utilizado para avaliar os efeitos dos poluentes na população e auxiliar os tomadores de decisão na identificação de áreas que precisam de maior intervenção. Ele permite classificar a qualidade do ar em categorias que variam de Boa a Crítica, facilitando a interpretação dos dados."),
                    _buildParagraph(
                        "O IQAR é calculado a partir de uma fórmula que relaciona a concentração de diferentes poluentes com níveis críticos, permitindo uma avaliação precisa dos riscos à saúde."),

                    const SizedBox(height: 24),

                    // Seção de fórmula
                    _buildSectionTitle("Fórmula de Cálculo", Icons.functions),
                    _buildFormulaCard(
                        "IQAR = (ISup - IInf) / (CSup - CInf) * (C - CInf) + IInf",
                        [
                          "ISup – valor crítico superior do índice",
                          "IInf – valor crítico inferior do índice",
                          "CSup – concentração do poluente que corresponde ao ISup",
                          "CInf – concentração do poluente que corresponde ao CInf",
                          "C – concentração medida para o poluente em questão"
                        ]),

                    const SizedBox(height: 24),

                    // Seção de classificação
                    _buildSectionTitle("Classificação e Efeitos na Saúde",
                        Icons.health_and_safety),
                    _buildHealthEffectsTable(),

                    const SizedBox(height: 24),

                    // Seção de faixas de concentração
                    _buildSectionTitle(
                        "Faixas de Concentração dos Poluentes", Icons.science),
                    _buildPollutantConcentrationTable(),

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
              color: const Color(0xFFFF9500).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFF9500),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFFFF9500),
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
  Widget _buildFormulaCard(String formula, List<String> definitions) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                formula,
                style: GoogleFonts.robotoMono(
                  textStyle: TextStyle(
                    color: const Color(0xFFFF9500),
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Onde:",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...definitions
                .map((definition) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        definition,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: const Color(0xFF333333),
                            fontSize: isSmallScreen ? 13 : 14,
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

  // Widget para tabela de efeitos na saúde
  Widget _buildHealthEffectsTable() {
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
                  _buildColorLegend('Boa', Colors.green),
                  _buildColorLegend('Regular', Colors.lightGreen),
                  _buildColorLegend('Inadequada', Colors.amber),
                  _buildColorLegend('Má', Colors.orange),
                  _buildColorLegend('Péssima', Colors.deepOrange),
                  _buildColorLegend('Crítica', Colors.red),
                ],
              ),
            ),

            // Tabela de efeitos na saúde - reformatada para evitar sobreposição
            _buildEffectsTable(),
          ],
        ),
      ),
    );
  }

// Substitua o método _buildEffectsTable() pelo seguinte:

  Widget _buildEffectsTable() {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    // Dados para a tabela
    final List<Map<String, dynamic>> healthEffects = [
      {
        'quality': 'Boa',
        'index': '0-50',
        'effects': 'Praticamente não há riscos à saúde.',
        'color': Colors.green
      },
      {
        'quality': 'Regular',
        'index': '51-100',
        'effects':
            'Pessoas de grupos sensíveis (crianças, idosos e pessoas com doenças respiratórias e cardíacas) podem apresentar sintomas como tosse seca e cansaço. A população em geral não é afetada.',
        'color': Colors.lightGreen
      },
      {
        'quality': 'Inadequada',
        'index': '101-199',
        'effects':
            'Toda a população pode apresentar sintomas como tosse seca, cansaço, ardor nos olhos, nariz e garganta. Pessoas de grupos sensíveis podem apresentar efeitos mais sérios na saúde.',
        'color': Colors.amber
      },
      {
        'quality': 'Má',
        'index': '200-299',
        'effects':
            'Toda a população pode apresentar agravamento dos sintomas como tosse seca, cansaço, ardor nos olhos, nariz e garganta, além de falta de ar e respiração ofegante. Efeitos ainda mais graves para grupos sensíveis.',
        'color': Colors.orange
      },
      {
        'quality': 'Péssima',
        'index': '300-399',
        'effects':
            'Toda a população pode apresentar sérios riscos de manifestações de doenças respiratórias e cardiovasculares. Aumento de mortes prematuras em grupos sensíveis.',
        'color': Colors.deepOrange
      },
      {
        'quality': 'Crítica',
        'index': 'Acima de 400',
        'effects':
            'Toda a população enfrenta sérios riscos de saúde. Medidas de emergência são necessárias.',
        'color': Colors.red
      },
    ];

    return Column(
      children: [
        // Cabeçalho da tabela
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFF9500).withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: isSmallScreen ? 80 : 120,
                child: Text(
                  'Qualidade do Ar',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: const Color(0xFFFF9500),
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                width: isSmallScreen ? 50 : 80,
                child: Text(
                  'Índice',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: const Color(0xFFFF9500),
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                  ),
                  softWrap: true,
                ),
              ),
              Expanded(
                child: Text(
                  'Descrição dos Efeitos sobre a Saúde',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: const Color(0xFFFF9500),
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 12 : 14,
                      height: 1.3,
                    ),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),

        // Linhas da tabela
        ...healthEffects
            .map((effect) => _buildEffectRow(effect['quality'], effect['index'],
                effect['effects'], effect['color'], isSmallScreen))
            .toList(),
      ],
    );
  }

// Adicione este novo método para construir cada linha da tabela
  Widget _buildEffectRow(String quality, String index, String effects,
      Color color, bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coluna de qualidade
            SizedBox(
              width: isSmallScreen ? 80 : 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      quality,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: isSmallScreen ? 12 : 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),

            // Coluna de índice
            SizedBox(
              width: isSmallScreen ? 50 : 80,
              child: Text(
                index,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: isSmallScreen ? 12 : 13,
                  ),
                ),
                softWrap: true,
              ),
            ),

            // Coluna de efeitos
            Expanded(
              child: Text(
                effects,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: isSmallScreen ? 12 : 13,
                    height: 1.5,
                  ),
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
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

  // Widget para tabela de concentração de poluentes
  Widget _buildPollutantConcentrationTable() {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 64,
                  ),
                  child: DataTable(
                    headingRowHeight: isSmallScreen ? 60 : 56,
                    headingRowColor: MaterialStateProperty.all(
                      const Color(0xFFFF9500).withOpacity(0.1),
                    ),
                    columnSpacing: 16,
                    headingTextStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: const Color(0xFFFF9500),
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 12 : 14,
                      ),
                    ),
                    dataTextStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: isSmallScreen ? 12 : 13,
                      ),
                    ),
                    columns: [
                      DataColumn(
                          label: Container(
                              width: isSmallScreen ? 60 : 80,
                              child: const Text('Qualidade', softWrap: true))),
                      DataColumn(
                          label: Container(
                              width: isSmallScreen ? 60 : 80,
                              child:
                                  const Text('PTS (µg/m³)', softWrap: true))),
                      DataColumn(
                          label: Container(
                              width: isSmallScreen ? 60 : 80,
                              child:
                                  const Text('PM10 (µg/m³)', softWrap: true))),
                      DataColumn(
                          label: Container(
                              width: isSmallScreen ? 60 : 80,
                              child:
                                  const Text('SO₂ (µg/m³)', softWrap: true))),
                      DataColumn(
                          label: Container(
                              width: isSmallScreen ? 60 : 80,
                              child:
                                  const Text('NO₂ (µg/m³)', softWrap: true))),
                      DataColumn(
                          label: Container(
                              width: isSmallScreen ? 60 : 80,
                              child: const Text('CO (ppm)', softWrap: true))),
                      DataColumn(
                          label: Container(
                              width: isSmallScreen ? 60 : 80,
                              child: const Text('O₃ (µg/m³)', softWrap: true))),
                    ],
                    rows: [
                      _buildColoredDataRow([
                        'Boa',
                        '0-80',
                        '0-50',
                        '0-80',
                        '0-100',
                        '0-4,5',
                        '0-80'
                      ], Colors.green),
                      _buildColoredDataRow([
                        'Regular',
                        '81-240',
                        '51-150',
                        '81-365',
                        '101-320',
                        '4,6-9,0',
                        '81-160'
                      ], Colors.lightGreen),
                      _buildColoredDataRow([
                        'Inadequada',
                        '241-375',
                        '151-250',
                        '366-586',
                        '321-1130',
                        '9,1-12,4',
                        '161-322'
                      ], Colors.amber),
                      _buildColoredDataRow([
                        'Má',
                        '376-625',
                        '251-350',
                        '587-800',
                        '1131-2260',
                        '12,5-15,0',
                        '323-400'
                      ], Colors.orange),
                      _buildColoredDataRow([
                        'Péssima',
                        '626-875',
                        '421-500',
                        '1601-2100',
                        '2261-3000',
                        '30,1-40',
                        '801-1000'
                      ], Colors.deepOrange),
                      _buildColoredDataRow([
                        'Crítica',
                        '> 876',
                        '> 500',
                        '> 2100',
                        '> 3000',
                        '> 40',
                        '> 1000'
                      ], Colors.red),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Adicione esta função para criar linhas coloridas na tabela
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
                    Flexible(
                      child: Text(
                        cell,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  // Funções auxiliares para construir tabelas
  DataRow _buildDataRow(List<String> cells) {
    return DataRow(
      cells: cells
          .map((cell) => DataCell(
                Flexible(
                  child: Text(
                    cell,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
