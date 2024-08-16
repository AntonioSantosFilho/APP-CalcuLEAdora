import 'package:calculeadora/calculadora_iet_reseratorios.dart';
import 'package:calculeadora/calculadora_iet_rios.dart';
import 'package:calculeadora/calculadora_iqa_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainPageC extends StatelessWidget {
  const MainPageC({super.key});

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
    const TextStyle titleStyle = TextStyle(
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
                      const Text(
                        "Índices de Qualidades",
                        style: titleStyle,
                      ),
                      const SizedBox(height: 30),
                      if (screenWidth > 500)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildCard('assets/1.png', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Calculadoraiqa()),
                              );
                            }),
                            buildCard('assets/2.png', () {
                              print('Card2 clicked!');
                            }),
                            buildCard('assets/3.png', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IetRios()),
                              );
                            }),
                            buildCard('assets/4.png', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IetReservatorios()),
                              );
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Calculadoraiqa()),
                                  );
                                }),
                                buildCard('assets/4.png', () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            IetReservatorios()),
                                  );
                                }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildCard('assets/3.png', () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => IetRios()),
                                  );
                                }),
                                buildCard('assets/2.png', () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            IetReservatorios()),
                                  );
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
