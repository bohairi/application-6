import 'package:flutter/material.dart';
import 'package:flutter_application_6/BottomCart.dart';
import 'package:flutter_application_6/BottomFavorite.dart';
import 'package:flutter_application_6/HomepageTask.dart';
import 'package:flutter_application_6/data_base.dart';
import 'package:flutter_application_6/model_card.dart';

class ClassBottomNavigation extends StatefulWidget {
  ClassBottomNavigation({super.key});

  @override
  State<ClassBottomNavigation> createState() => _ClassBottomNavigationState();
}

class _ClassBottomNavigationState extends State<ClassBottomNavigation> {
  List <ModelCard> cart = [];
  int index = 0;
  Map <String,Widget> icons_bottom_bar = {
    "Home" : Icon(Icons.home),
    "Cart" : Icon(Icons.shop_sharp),
    "Favorite" : Icon(Icons.favorite)
  };
  
  void initState() {
    categoryList = views;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List <Widget> pages = [
    HomePageTask(cart: cart,),
    BottomCart(cart: cart,),
    BottomFavorite()
  ];
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