import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appbar_animated/appbar_animated.dart';
import 'package:flutter/widgets.dart';

// BANNER IMAGE MENU APP

// https://www.canva.com/design/DAGGcdy-g-Y/D5Vt6W8_ClRVmGP0MVIw7A/edit?utm_content=DAGGcdy-g-Y&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldLayoutBuilder(
        backgroundColorAppBar: const ColorBuilder(
            Colors.transparent, Color.fromARGB(76, 33, 149, 243)),
        textColorAppBar: const ColorBuilder(Colors.white),
        appBarBuilder: _appBar,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                'assets/menuBannerCalculeadora.png',
                fit: BoxFit.contain,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.26,
                ),
                height: 900,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text(
                          "Índices de Qualidades",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/menuBannerCalculeadora.png',
                                          height: 200,
                                          width: 200,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/menuBannerCalculeadora.png',
                                          height: 200,
                                          width: 200,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/menuBannerCalculeadora.png',
                                          height: 200,
                                          width: 200,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/menuBannerCalculeadora.png',
                                          height: 200,
                                          width: 200,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context, ColorAnimated colorAnimated) {
    return Text("");
  }
}
