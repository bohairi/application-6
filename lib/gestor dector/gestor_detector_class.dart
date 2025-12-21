import 'package:flutter/material.dart';
import 'package:flutter_application_6/gestor%20dector/second_page_class.dart';

class GestorDetectorClass extends StatefulWidget {
  GestorDetectorClass({super.key});

  @override
  State<GestorDetectorClass> createState() => _GestorDetectorClassState();
}

class _GestorDetectorClassState extends State<GestorDetectorClass> {
  @override
  bool flag = false;

  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
                  if(details.delta.dx < 0){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SecondPageClass()));
                  }
                },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.light, size: 50,
              color: flag? Colors.amber: Colors.black),
              SizedBox(height: 100,),
              GestureDetector(
                onTap: () {
                  setState(() {
                    flag = !flag;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(flag? "turn on" : "turn off"),));
                },
                child: Container(
                  color: Colors.amber,
                  width: 100,
                  height: 50,
                  child: Center(child: Text(!flag? "turn on" : "turn off",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}