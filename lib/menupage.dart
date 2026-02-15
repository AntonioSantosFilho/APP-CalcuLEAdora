import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPageC extends StatefulWidget {
  final Function(int) onTabChange;
  const MainPageC({super.key, required this.onTabChange});

  @override
  State<MainPageC> createState() => _MainPageCState();
}

class _MainPageCState extends State<MainPageC> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenHeight * 0.65;

    // Definição das dimensões dos cards para larguras maiores e menores que 500px
    final double cardWidth =
        screenWidth > 500 ? screenWidth * 0.16 : screenWidth * 0.4;
    final double cardHeight =
        screenWidth > 500 ? screenWidth * 0.16 : screenWidth * 0.4;

    const EdgeInsets padding = EdgeInsets.all(16.0);
    final TextStyle titleStyle = GoogleFonts.montserrat(
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Índices de Qualidades",
                        style: GoogleFonts.gowunBatang(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5),
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (screenWidth > 500)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildCard('assets/1.png', () {
                              widget.onTabChange(7);
                            }),
                            buildCard('assets/2.png', () {
                              widget.onTabChange(4);
                            }),
                            buildCard('assets/3.png', () {
                              widget.onTabChange(5);
                            }),
                            buildCard('assets/4.png', () {
                              widget.onTabChange(6);
                            }),
                          ],
                        )
                      else
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildCard('assets/1.png', () {
                                  widget.onTabChange(7);
                                }),
                                buildCard('assets/4.png', () {
                                  widget.onTabChange(6);
                                }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildCard('assets/3.png', () {
                                  widget.onTabChange(5);
                                }),
                                buildCard('assets/2.png', () {
                                  widget.onTabChange(4);
                                }),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
