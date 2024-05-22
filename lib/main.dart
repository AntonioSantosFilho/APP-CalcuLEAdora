import 'package:calculeadora/appbarexample.dart';
import 'package:calculeadora/calculadora_iqa_page.dart';
import 'package:flutter/material.dart';
import 'onboarding_initial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha App Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DetailPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFD4EAF5),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(
              255, 68, 103, 247), // Define a cor de fundo da AppBar
          title: Text('CalcuLEAdora',
              style: TextStyle(color: Color(0xFFFFFFFF)),
              textAlign: TextAlign.center),
          centerTitle: true,
          leading: IconButton(
            color: Color(0xFFFFFFFF),
            icon: Icon(Icons.menu),
            onPressed: () {
              // Adicione aqui a funcionalidade do ícone
            },
          ),
          actions: [
            IconButton(
              color: Color(0xFFFFFFFF),
              icon: Icon(Icons.sunny),
              onPressed: () {
                // Adicione aqui a funcionalidade do ícone
              },
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Calculadoraiqa(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      backgroundColor: Color(0xFF2666E0)),
                  child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        'Calculadora de IQA',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ))),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      backgroundColor: Color(0xFF2666E0)),
                  child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        'Calculadora de IET',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ))),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    backgroundColor: Color(0xFF2666E0)),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: Text(
                    'Calculadora de IQAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    backgroundColor: Color(0xFF2666E0)),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: Text(
                    'Sobre o APP',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
