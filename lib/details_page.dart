import 'package:calculeadora/navbart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  final Function(int) onTabChange;
  const DetailPage({super.key, required this.onTabChange});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // Lista de dados para os cards com cores e ícones
  final List<Map<String, dynamic>> infoCards = [
    {
      'title': 'Índice de Qualidade da Água',
      'acronym': 'IQA',
      'description':
          'Avalia a qualidade da água para abastecimento público após tratamento.',
      'icon': Icons.water_drop,
      'color': Color(0xFF3486EB),
      'onTap': 14,
    },
    {
      'title': 'Índice do Estado Trófico',
      'acronym': 'IET',
      'description': 'Classifica corpos d\'água em diferentes graus de trofia.',
      'icon': Icons.eco,
      'color': Color(0xFF34C759),
      'onTap': 16,
    },
    {
      'title': 'Índice de Qualidade do Ar',
      'acronym': 'IQAr',
      'description':
          'Avalia os efeitos dos poluentes do ar na saúde da população.',
      'icon': Icons.air,
      'color': Color(0xFFFF9500),
      'onTap': 15,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenHeight * 0.65;
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
                          Icons.info_outline,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "Informações",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Conheça os índices ambientais",
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

            // Conteúdo com rolagem - MODIFICADO AQUI
            Expanded(
              child: Container(
                // Define uma altura máxima para o container de rolagem
                constraints: BoxConstraints(
                  maxHeight:
                      containerHeight * 0.7, // Ajuste conforme necessário
                ),
                // Adicione margens para não encostar nas bordas
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  // Opcional: adicione uma borda sutil para visualizar o container
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selecione um índice para saber mais",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Cards de informações
                      ...infoCards
                          .map((card) => _buildInfoCard(
                                title: card['title'],
                                acronym: card['acronym'],
                                description: card['description'],
                                icon: card['icon'],
                                color: card['color'],
                                onTap: () => widget.onTabChange(card['onTap']),
                                isSmallScreen: isSmallScreen,
                              ))
                          .toList(),

                      const SizedBox(height: 20),

                      // Seção de referências
                      _buildReferencesSection(),
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

  Widget _buildInfoCard({
    required String title,
    required String acronym,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool isSmallScreen,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ícone
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Título e sigla
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            acronym,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Descrição
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Botão "Saiba mais"
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Saiba mais",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: color,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            color: color,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Referências",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildReferenceItem(
          "CETESB. Índices de Qualidade das Águas. Companhia Ambiental do Estado de São Paulo, 2021.",
        ),
        _buildReferenceItem(
          "CONAMA. Resolução nº 491/2018. Conselho Nacional do Meio Ambiente, 2018.",
        ),
        _buildReferenceItem(
          "LAMPARELLI, M.C. Grau de trofia em corpos d'água do estado de São Paulo: avaliação dos métodos de monitoramento. Tese de Doutorado, USP, 2004.",
        ),
      ],
    );
  }

  Widget _buildReferenceItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.circle,
            size: 8,
            color: Color(0xFF666666),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
