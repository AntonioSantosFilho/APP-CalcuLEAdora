import 'package:calculeadora/calculadora_iqa_page.dart';
import 'package:calculeadora/details_page.dart';
import 'package:calculeadora/teste.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Navbart extends StatefulWidget {
  static final title = 'salomon_bottom_bar';

  @override
  _NavbartState createState() => _NavbartState();
}

class _NavbartState extends State<Navbart> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.35;
    final BoxFit fitType = kIsWeb ? BoxFit.contain : BoxFit.contain;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFbac6ff),
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
          backgroundColor: Color.fromARGB(202, 181, 212, 250),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Inicio"),
              selectedColor: Color.fromARGB(255, 42, 0, 229),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.info),
              title: Text("Info"),
              selectedColor: Colors.purple,
            ),

            SalomonBottomBarItem(
              icon: Icon(Icons.save),
              title: Text("Salvos"),
              selectedColor: Colors.teal,
            ),

            SalomonBottomBarItem(
              icon: Icon(Icons.exit_to_app),
              title: Text("Sair"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return MainPageC();
      case 1:
        return DetailPage();
      case 2:
        return DetailPage();
      case 3:
        return DetailPage();
      default:
        return Container();
    }
  }
}
