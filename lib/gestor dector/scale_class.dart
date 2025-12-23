import 'package:flutter/material.dart';
 import 'package:vector_math/vector_math_64.dart' show Vector3;

class ScaleClass extends StatefulWidget {
  ScaleClass({super.key});

  @override
  State<ScaleClass> createState() => _ScaleClassState();
}

class _ScaleClassState extends State<ScaleClass> {
  Vector3 scale = Vector3(1, 1, 1);

  double startDragx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        
        onHorizontalDragStart: (details) {
          startDragx = details.localPosition.dx;
        },
        onHorizontalDragUpdate: (details) {
          double drag = (details.localPosition.dx - startDragx)/300;

          setState(() {
               scale = Vector3((1+drag).clamp(0.5, 2.0)
          , (1+drag).clamp(0.5, 2.0), 1);
          });
          
        },
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3(scale),
          child: Center(
            child: Container(
              width: 200,
              height: 200,
              color: Colors.blueAccent,
              child: Center(child: Text("hi", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
          ),
        ),
      ),
    );
  }
}