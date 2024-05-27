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
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OnboardingInitial(),
    );
  }
}
