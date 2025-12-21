import 'package:flutter/material.dart';
import 'package:flutter_application_6/class_bottom_navigation.dart';
import 'package:flutter_application_6/gestor%20dector/gestor_detector_class.dart';
import 'package:flutter_application_6/gestor%20dector/scale_class.dart';
import 'package:flutter_application_6/tabBar/tabBar_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScaleClass(),
      debugShowCheckedModeBanner: false,
    );
  }
}

