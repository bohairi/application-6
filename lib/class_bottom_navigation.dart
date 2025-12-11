import 'package:flutter/material.dart';
import 'package:flutter_application_6/BottomCart.dart';
import 'package:flutter_application_6/BottomFavorite.dart';
import 'package:flutter_application_6/HomepageTask.dart';

class ClassBottomNavigation extends StatefulWidget {
  const ClassBottomNavigation({super.key});

  @override
  State<ClassBottomNavigation> createState() => _ClassBottomNavigationState();
}

class _ClassBottomNavigationState extends State<ClassBottomNavigation> {
  int index = 0;
  Map <String,Widget> icons_bottom_bar = {
    "Home" : Icon(Icons.home),
    "Cart" : Icon(Icons.shop_sharp),
    "Favorite" : Icon(Icons.favorite)
  };
  List <Widget> pages = [
    HomePageTask(),
    BottomCart(),
    BottomFavorite()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          title: Text("FoodGo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontFamily: 'ahmadFont'
          ),),
          subtitle: Text("Order your favourite food!"),
          trailing: Icon(Icons.person,
          size: 50,),
        ),
      ),
      body: pages[index],
      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() {
          index = value;
        }),
        items: icons_bottom_bar.entries.map((e) => BottomNavigationBarItem(icon: e.value, label: e.key)).toList()),
    );
  }
}