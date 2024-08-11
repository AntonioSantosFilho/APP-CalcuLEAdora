import 'package:calculeadora/navbart.dart';
import 'package:calculeadora/teste.dart';
import 'package:flutter/material.dart';
import 'dart:math';

TextEditingController ietRiosCLController = TextEditingController();
TextEditingController ietRiosPTController = TextEditingController();

class IetRios extends StatelessWidget {
  const IetRios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 240, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
            255, 68, 103, 247), // Define a cor de fundo da AppBar
        title: const Text('CalcuLEAdora',
            style: TextStyle(color: Color(0xFFFFFFFF)),
            textAlign: TextAlign.center),
        centerTitle: true,
        leading: IconButton(
          color: const Color(0xFFFFFFFF),
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Navbart()),
            );
          },
        ),
        actions: [
          IconButton(
            color: const Color(0xFFFFFFFF),
            icon: const Icon(Icons.sunny),
            onPressed: () {
              // Adicione aqui a funcionalidade do ícone
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0x772666E0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Expanded(
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
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0x772666E0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0x772666E0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Color(0x772666E0)),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        hintText: '0,00',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 207, 207, 207)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //==================================================================================================
            Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0x772666E0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Expanded(
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
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0x772666E0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0x772666E0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Color(0x772666E0)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: '0,00',
                        hintStyle: const TextStyle(
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
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Todos os campos de texto estão preenchidos, permita o evento de clique do botão
                  calculo(double.parse(ietRiosCLController.text),
                      double.parse(ietRiosPTController.text));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15.0),
                  backgroundColor: Colors.blue, // Cor de fundo do botão
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Borda arredondada
                  ),
                ),
                child: const Text(
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

    print("\n\RIOS iet-cla: $iet_cla \n\nRIOS iet_pt: $iet_pt");
  }
}
