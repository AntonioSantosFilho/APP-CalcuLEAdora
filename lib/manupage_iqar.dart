import 'package:calculeadora/navbart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPageIqar extends StatefulWidget {
  final Function(int) onTabChange;
  const MainPageIqar({super.key, required this.onTabChange});

  @override
  State<MainPageIqar> createState() => _MainPageIqarState();
}

class _MainPageIqarState extends State<MainPageIqar> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenHeight * 0.65;

    // Dimensões do card
    final double cardWidth = screenWidth * 0.85; // Largura dos cards
    final double cardHeight =
        screenHeight * 0.1; // Altura dos cards (10% da tela)

    // Função para criar um card horizontal com título e imagem
    Widget buildHorizontalCard(String title, String asset, Function onTap) {
      return Card(
        color: Colors.blueGrey[50], // Mudando a cor do fundo do card
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: () => onTap(),
          child: Container(
            height: cardHeight,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      asset,
                      height: cardHeight - 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Lista de dados para os cards
    final List<Map<String, dynamic>> cardsData = [
      {
        'title': 'MP2,5',
        'asset': 'assets/iqar/mp25.png',
        'onTap': () => widget.onTabChange(13),
      },
      {
        'title': 'MP10',
        'asset': 'assets/iqar/mp10.png',
        'onTap': () => widget.onTabChange(8),
      },
      {
        'title': 'Monóxido de Carbono',
        'asset': 'assets/iqar/co.png',
        'onTap': () => widget.onTabChange(10),
      },
      {
        'title': 'Dióxido de Nitrogênio',
        'asset': 'assets/iqar/no2.png',
        'onTap': () => widget.onTabChange(11),
      },
      {
        'title': 'Ozônio',
        'asset': 'assets/iqar/o3.png',
        'onTap': () => widget.onTabChange(9),
      },
      {
        'title': 'Dióxido de Enxofre',
        'asset': 'assets/iqar/so2.png',
        'onTap': () => widget.onTabChange(12),
      },
    ];

    // Função para gerar uma lista de cards
    List<Widget> buildVerticalCardList() {
      return cardsData.map((card) {
        return buildHorizontalCard(
          card['title'],
          card['asset'],
          card['onTap'],
        );
      }).toList();
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
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 15),
                Text(
                  "Indicadores do IQAr",
                  style: GoogleFonts.gowunBatang(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .1),
                  ),
                ),
                const SizedBox(height: 30),
                ...buildVerticalCardList(), // Gerar os cards verticalmente
              ],
            ),
          ),
        ),
      ),
    );
  }
}
