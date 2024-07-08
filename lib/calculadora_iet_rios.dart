import 'package:flutter/material.dart';
import 'dart:math';

TextEditingController ietRiosCLController = TextEditingController();
TextEditingController ietRiosPTController = TextEditingController();

class IetRios extends StatelessWidget {
  const IetRios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 240, 255),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(6),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Color(0x772666E0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 6, // 60% da largura disponível
                    child: Text(
                      " IET (CL) µg/L:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 4, // 30% da largura disponível
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: ietRiosCLController,
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0x772666E0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0x772666E0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0x772666E0)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: '0,00',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 207, 207, 207)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //==================================================================================================
            Container(
              margin: EdgeInsets.all(6),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Color(0x772666E0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 6, // 60% da largura disponível
                    child: Text(" IET (PT) µg/L::",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 4, // 30% da largura disponível
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: ietRiosPTController,
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0x772666E0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0x772666E0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0x772666E0)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: '0,00',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 207, 207, 207)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //==================================================================================================
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Todos os campos de texto estão preenchidos, permita o evento de clique do botão
                  calculo(double.parse(ietRiosCLController.text),
                      double.parse(ietRiosPTController.text));
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15.0),
                  backgroundColor: Colors.blue, // Cor de fundo do botão
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Borda arredondada
                  ),
                ),
                child: Text(
                  "Calcular",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Cor do texto do botão
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculo(double cloro, double pt) {
    double iet_cla = 10 * (6 - ((-0.7 - 0.6 * (log(cloro)) / log(2)) - 20));

    double iet_pt = 10 * (6 - ((0.42 - 0.36 * log(pt)) / log(2))) - 20;

    print("\n\no valor de iet-cla: $iet_cla \n\n o valor de iet_pt: $iet_pt");
  }
}
