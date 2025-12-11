import 'package:flutter/material.dart';

class CustomWidgetTask extends StatelessWidget {
  String widget_title;
  CustomWidgetTask({required this.widget_title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        child: Container(
          // margin: EdgeInsets.only(right: 10),
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              widget_title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          
        ),
      ),
    );
  }
}
