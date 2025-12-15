import 'package:flutter/material.dart';
import 'package:flutter_application_6/model_card.dart';

class CustomCart extends StatelessWidget {
  ModelCard model;
  CustomCart({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Card(
          elevation: 5,
          child: Row(
            children: [
              Image.asset(model.urlImaige),
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(model.title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Text(model.subtitle, style: TextStyle(fontSize: 20),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}