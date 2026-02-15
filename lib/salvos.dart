import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedResultsPage extends StatefulWidget {
  const SavedResultsPage({super.key});

  @override
  _SavedResultsPageState createState() => _SavedResultsPageState();
}

class _SavedResultsPageState extends State<SavedResultsPage> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> _loadAllPreferences() async {
    String? existingData = prefs.getString('timeData');

    if (existingData != null) {
      Map<String, dynamic> dataMap = json.decode(existingData);
      return dataMap.entries.map((entry) {
        Map<String, dynamic> data = entry.value;
        data['timestamp'] = entry.key;
        return data;
      }).toList();
    } else {
      return [];
    }
  }

  void _showDetailsPopup(BuildContext context,
      Map<String, String> valoresDigitados, double iqaValue) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Detalhes dos Valores Digitados',
            style: GoogleFonts.gowunBatang(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .5),
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Table(
                  border: TableBorder.all(color: Colors.black),
                  children: [
                    const TableRow(
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              'Parâmetro',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.4,
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              'Entrada',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...valoresDigitados.entries.map((entry) {
                      String parameterWithUnit =
                          _getParameterWithUnit(entry.key);
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(parameterWithUnit),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              entry.value,
                              style: const TextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
                const Divider(thickness: 2),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Resultado do IQA: ${iqaValue.toStringAsFixed(2)}',
                    style: GoogleFonts.gowunBatang(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  String _getParameterWithUnit(String parameter) {
    Map<String, String> parameterUnits = {
      'pH': 'pH',
      'OD': 'mg/L', // Oxigênio Dissolvido
      'Turbidez': 'NTU', // Turbidez
      'Coliformes Fecais': 'NMP/100mL', // Coliformes Fecais
      'DBO': 'mg/L', // Demanda Bioquímica de Oxigênio
      'Coliformes': 'NMP', // Coliformes Fecais
      'Temperatura': '°C', // Temperatura da Água
      'Nitrogênio': 'mg/L', // Nitrogênio Total
      'Fósforo': 'mg/L', // Fósforo Total
      'Sólidos Suspensos': 'mg/L', // Resíduo Total
    };
    return parameterUnits.containsKey(parameter)
        ? '$parameter (${parameterUnits[parameter]})'
        : parameter;
  }

  void _deleteResult(String timestamp) async {
    String? existingData = prefs.getString('timeData');
    if (existingData != null) {
      Map<String, dynamic> dataMap = json.decode(existingData);
      dataMap.remove(timestamp);
      await prefs.setString('timeData', json.encode(dataMap));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resultados Salvos - IQA',
          style: GoogleFonts.gowunBatang(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: .5),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadAllPreferences(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum dado salvo.'));
          } else {
            List<Map<String, dynamic>> dataList = snapshot.data!;
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = dataList[index];
                String timestamp = data['timestamp'];
                DateTime dateTime =
                    DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
                String formattedDate =
                    "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
                double iqaValue = (data['valoresIQA']['IQA'] as double);

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    title: Text('IQA: ${iqaValue.toStringAsFixed(2)}'),
                    subtitle: Text('Salvo em: $formattedDate'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.info_outline,
                              color: Colors.blueAccent),
                          onPressed: () {
                            _showDetailsPopup(
                              context,
                              Map<String, String>.from(
                                  data['valoresDigitados']),
                              iqaValue,
                            );
                          },
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            _deleteResult(timestamp);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
