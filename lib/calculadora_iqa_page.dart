import 'package:flutter/material.dart';

// Definindo os controladores
TextEditingController dboController = TextEditingController();
TextEditingController odController = TextEditingController();
TextEditingController fosforoController = TextEditingController();
TextEditingController nitrogenioController = TextEditingController();
TextEditingController coliformesController = TextEditingController();
TextEditingController turbidezController = TextEditingController();
TextEditingController solidosSuspensosController = TextEditingController();
TextEditingController temperaturaController = TextEditingController();
TextEditingController phController = TextEditingController();

// Parseando os valores de texto para double
double dbo = double.parse(dboController.text);
double od = double.parse(odController.text);
double fosforo = double.parse(fosforoController.text);
double nitrogenio = double.parse(nitrogenioController.text);
double coliformes = double.parse(coliformesController.text);
double turbidez = double.parse(turbidezController.text);
double solidosSuspensos = double.parse(solidosSuspensosController.text);
double temperatura = double.parse(temperaturaController.text);
double ph = double.parse(phController.text);

class Calculadoraiqa extends StatelessWidget {
  const Calculadoraiqa({super.key});

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
                      " DBO (mg/L)",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 4, // 30% da largura disponível
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: dboController,
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
                    child: Text(" OD (mg/L)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 4, // 30% da largura disponível
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: odController,
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
                    child: Text(" Fósforo (mg/L)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 4, // 30% da largura disponível
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: fosforoController,
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
                    flex: 6,
                    child: Text(" Nitrogênio Total (mg/L)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: nitrogenioController,
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
                    flex: 6,
                    child: Text(" Coliformes Totais (NMP)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: coliformesController,
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
                    flex: 6,
                    child: Text(" Turbidez (NTU)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: turbidezController,
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
                    flex: 6,
                    child: Text(" Sólidos Suspensos Totais (mg/L)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: solidosSuspensosController,
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
                    flex: 6,
                    child: Text(" Temperatura (°C)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: temperaturaController,
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
                    flex: 6,
                    child: Text(" pH",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: phController,
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
            SizedBox(
              height: 12,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (dboController.text.isNotEmpty &&
                      odController.text.isNotEmpty &&
                      fosforoController.text.isNotEmpty &&
                      nitrogenioController.text.isNotEmpty &&
                      coliformesController.text.isNotEmpty &&
                      turbidezController.text.isNotEmpty &&
                      solidosSuspensosController.text.isNotEmpty &&
                      temperaturaController.text.isNotEmpty &&
                      phController.text.isNotEmpty) {
                    // Todos os campos de texto estão preenchidos, permita o evento de clique do botão
                    Calculo();
                  } else {
                    // Nem todos os campos de texto estão preenchidos, mostre uma mensagem de erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Por favor, preencha todos os campos.')),
                    );
                  }
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
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void Calculo() {
    // Get the values from the controllers

    // Calculate the sum
    double sum = dbo +
        od +
        fosforo +
        nitrogenio +
        coliformes +
        turbidez +
        solidosSuspensos +
        temperatura +
        ph;

    // Print the sum
    print('Sum: $sum');
  }
}
