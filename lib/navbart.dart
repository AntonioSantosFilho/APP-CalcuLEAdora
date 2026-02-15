import 'package:calculeadora/calculadora_iet_reservatorios.dart';
import 'package:calculeadora/calculadora_iet_rios.dart';
import 'package:calculeadora/calculadora_iqa_page.dart';
import 'package:calculeadora/details_page.dart';
import 'package:calculeadora/infos/info_iet.dart';
import 'package:calculeadora/infos/info_iqa.dart';
import 'package:calculeadora/infos/info_iqar.dart';
import 'package:calculeadora/iqar/co.dart';
import 'package:calculeadora/iqar/mp10.dart';
import 'package:calculeadora/iqar/mp2ponto5.dart';
import 'package:calculeadora/iqar/no2.dart';
import 'package:calculeadora/iqar/o3.dart';
import 'package:calculeadora/iqar/so2.dart';
import 'package:calculeadora/manupage_iqar.dart';
import 'package:calculeadora/result_page.dart';
import 'package:calculeadora/salvos.dart';
import 'package:calculeadora/menupage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Navbart extends StatefulWidget {
  static const title = 'salomon_bottom_bar';

  const Navbart({super.key});

  @override
  _NavbartState createState() => _NavbartState();
}

class _NavbartState extends State<Navbart> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.35;
    const BoxFit fitType = kIsWeb ? BoxFit.contain : BoxFit.contain;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFbac6ff),
        body: Stack(
          children: [
            // Background Image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: imageHeight, // Define a altura como 30% da tela
              child: Image.asset(
                'assets/menuBannerCalculeadora.png', // Substitua pelo caminho da sua imagem

                fit: fitType, // Use a variável `fitType`

                alignment: Alignment.topCenter,
              ),
            ),
            // Content
            Column(
              children: <Widget>[
                Expanded(child: _buildPage(_currentIndex)),
              ],
            ),
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: const Color(0xFFbac6ff),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("INICIO"),
              selectedColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.info),
              title: const Text("INFORMAÇÕES"),
              selectedColor: Colors.purple,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.save),
              title: const Text("SALVOS"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  void updateIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return MainPageC(
          onTabChange: updateIndex, // Passando o callback para a outra classe
        );
      case 1:
        return DetailPage(
          onTabChange: updateIndex,
        );
      case 2:
        return SavedResultsPage();
      case 3:
        return DetailPage(
          onTabChange: updateIndex,
        );
      case 4:
        return MainPageIqar(
          onTabChange: updateIndex, // Passando o callback para a outra classe
        );
      case 5:
        return const IetRios();
      case 6:
        return const IetReservatorios();
      case 7:
        return const Calculadoraiqa();

//IQAr ==========================================================================================
      case 8:
        return const Mp10();

      case 9:
        return const O3();

      case 10:
        return const CO();

      case 11:
        return const NO2();

      case 12:
        return const SO2();

      case 13:
        return const MP25();

//INFOS ==========================================================================================
      case 14:
        return const InfoIQA();

      case 15:
        return const InfoIQAR();

      case 16:
        return const InfoIET();

      default:
        return Container();
    }
  }
}
