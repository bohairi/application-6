import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  String customHintText;
  String customLable;
  IconData icon;
  TextInputType? type;
  TextEditingController controller;
  final String? Function(String?)? inputMessage;
 bool flag;
  
  CustomTextFeild({
    required this.customHintText,
    required this.customLable,
    required this.icon,
     this.type,
     required this.inputMessage,
     required this.controller,
     required this.flag
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: inputMessage,
        keyboardType: type,
        obscureText: flag,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '$customHintText',
          labelText: '$customLable',
          labelStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          icon: Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 4
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
             borderSide: BorderSide(
              color: Colors.grey,
              width: 4
            )
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          )
          
        ),
      ),
    );
  }
}
