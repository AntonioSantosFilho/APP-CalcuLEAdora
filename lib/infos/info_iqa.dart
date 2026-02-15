import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoIQA extends StatefulWidget {
  const InfoIQA({super.key});

  @override
  State<InfoIQA> createState() => _InfoIQAState();
}

class _InfoIQAState extends State<InfoIQA> {
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
                color: Color(0xFF2666E0),
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
                          Icons.water_drop,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "IQA",
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
                    "Índice de Qualidade da Água",
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
                    _buildSectionTitle("Sobre o IQA", Icons.info_outline),
                    _buildParagraph(
                        "O Índice de Qualidade da Água (IQA) foi criado em 1970 pela National Sanitation Foundation nos Estados Unidos e adotado no Brasil a partir de 1975 pela CETESB. Hoje, o IQA é amplamente utilizado por diversos estados brasileiros para monitorar a qualidade da água, especialmente em relação ao seu uso para abastecimento público após tratamento."),
                    _buildParagraph(
                        "O IQA avalia a contaminação por esgotos domésticos e é composto por nove parâmetros de qualidade da água. Embora seja uma ferramenta útil, ele não considera substâncias tóxicas, como metais pesados e pesticidas, que também são cruciais para a análise da água."),

                    const SizedBox(height: 24),

                    // Seção de parâmetros
                    _buildSectionTitle("Parâmetros e seus Pesos", Icons.scale),
                    _buildParametersTable(),

                    const SizedBox(height: 24),

                    // Seção de classificação
                    _buildSectionTitle("Classificação do IQA", Icons.category),
                    _buildClassificationTable(),

                    const SizedBox(height: 24),

                    // Seção de descrição dos parâmetros
                    _buildSectionTitle(
                        "Descrição dos Parâmetros", Icons.description),
                    _buildParameterDescription(
                      "Oxigênio Dissolvido",
                      "Vital para a vida aquática, sendo consumido na decomposição da matéria orgânica. Baixos níveis indicam poluição por esgotos.",
                      Icons.air,
                      const Color(0xFF3486EB),
                    ),
                    _buildParameterDescription(
                      "Coliformes Termotolerantes",
                      "Indicadores de contaminação por esgotos, sugerem a presença de microorganismos patogênicos que causam doenças transmitidas pela água.",
                      Icons.bug_report,
                      const Color(0xFFFF9500),
                    ),
                    _buildParameterDescription(
                      "Potencial Hidrogeniônico (pH)",
                      "Mede a acidez ou alcalinidade da água, essencial para o equilíbrio dos ecossistemas aquáticos. O pH recomendado é entre 6 e 9.",
                      Icons.balance,
                      const Color(0xFF34C759),
                    ),
                    _buildParameterDescription(
                      "Demanda Bioquímica de Oxigênio (DBO)",
                      "Representa a quantidade de oxigênio consumida pela decomposição da matéria orgânica. Valores elevados indicam poluição.",
                      Icons.opacity,
                      const Color(0xFF3486EB),
                    ),
                    _buildParameterDescription(
                      "Temperatura da Água",
                      "Influencia a solubilidade do oxigênio e a vida aquática. Alterações bruscas podem impactar a saúde dos ecossistemas.",
                      Icons.thermostat,
                      const Color(0xFFFF9500),
                    ),
                    _buildParameterDescription(
                      "Nitrogênio Total",
                      "Nutriente essencial, mas em excesso pode causar eutrofização e prejudicar a qualidade da água.",
                      Icons.eco,
                      const Color(0xFF34C759),
                    ),
                    _buildParameterDescription(
                      "Fósforo Total",
                      "Assim como o nitrogênio, é um nutriente que em excesso pode causar a proliferação de algas e prejudicar o uso da água.",
                      Icons.science,
                      const Color(0xFF34C759),
                    ),
                    _buildParameterDescription(
                      "Turbidez",
                      "Indica a presença de sólidos suspensos na água, que podem afetar sua qualidade para consumo e outros usos.",
                      Icons.water,
                      const Color(0xFF3486EB),
                    ),
                    _buildParameterDescription(
                      "Resíduo Total",
                      "Refere-se ao material que resta após a evaporação da água. Pode causar assoreamento e danos aos ecossistemas.",
                      Icons.grain,
                      const Color(0xFF3486EB),
                    ),

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
              color: const Color(0xFF2666E0).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2666E0),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFF2666E0),
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

  // Widget para tabela de parâmetros
  Widget _buildParametersTable() {
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
                child: Table(
                  defaultColumnWidth: const FixedColumnWidth(250),
                  columnWidths: const {
                    0: FixedColumnWidth(250),
                    1: FixedColumnWidth(100),
                  },
                  children: [
                    _buildTableHeader(
                        ['Parâmetro de Qualidade da Água', 'Peso (w)']),
                    _buildTableRow(['Oxigênio Dissolvido', '0,17']),
                    _buildTableRow(['Coliformes Termotolerantes', '0,15']),
                    _buildTableRow(['Potencial Hidrogeniônico (pH)', '0,12']),
                    _buildTableRow(
                        ['Demanda Bioquímica de Oxigênio (DBO)', '0,10']),
                    _buildTableRow(['Temperatura da Água', '0,10']),
                    _buildTableRow(['Nitrogênio Total', '0,10']),
                    _buildTableRow(['Fósforo Total', '0,10']),
                    _buildTableRow(['Turbidez', '0,08']),
                    _buildTableRow(['Resíduo Total', '0,08']),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para tabela de classificação
  Widget _buildClassificationTable() {
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
            Text(
              "Faixas para Estados: BA, CE, ES, GO, MS, PB, PE, SP",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Table(
                  defaultColumnWidth: const FixedColumnWidth(150),
                  columnWidths: const {
                    0: FixedColumnWidth(150),
                    1: FixedColumnWidth(100),
                  },
                  children: [
                    _buildTableHeader(['Classificação', 'Faixa']),
                    _buildColoredTableRow(['Ótima', '80-100'], Colors.green),
                    _buildColoredTableRow(['Boa', '52-79'], Colors.lightGreen),
                    _buildColoredTableRow(['Razoável', '37-51'], Colors.amber),
                    _buildColoredTableRow(['Ruim', '20-36'], Colors.orange),
                    _buildColoredTableRow(['Péssima', '0-19'], Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para descrição de parâmetro
  Widget _buildParameterDescription(
      String title, String description, IconData icon, Color color) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: isSmallScreen
            ? Column(
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
                          icon,
                          color: color,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: color,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 14,
                              height: 1.4,
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

  // Funções auxiliares para construir tabelas
  TableRow _buildTableHeader(List<String> cells) {
    return TableRow(
      decoration: BoxDecoration(
        color: const Color(0xFF2666E0).withOpacity(0.1),
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
                      color: Color(0xFF2666E0),
                    ),
                  ),
                ),
              ))
          .toList(),
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

  TableRow _buildColoredTableRow(List<String> cells, Color color) {
    return TableRow(
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
              Text(
                cells[0],
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
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
}
