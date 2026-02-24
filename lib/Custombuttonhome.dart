import 'package:flutter/material.dart';

class Custombuttonhome extends StatelessWidget{
  String nameButton;
  VoidCallback action;
  Custombuttonhome({required this.nameButton,required this.action});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                foregroundColor: Colors.white
              ),
              onPressed: action, child: Text('$nameButton',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),)),
    );
  }
}