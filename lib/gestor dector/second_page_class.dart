import 'package:flutter/material.dart';
import 'package:flutter_application_6/gestor%20dector/gestor_detector_class.dart';

class SecondPageClass extends StatelessWidget {
  const SecondPageClass({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if( details.globalPosition.dx > 0 ){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> GestorDetectorClass()));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Second Page",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),
      ),
    );
  }
}