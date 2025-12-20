import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class TabbarClass extends StatelessWidget {
  const TabbarClass({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          bottom: TabBar(tabs: [
            Tab(
              child: Icon(Icons.home),
            ),
            Tab(
              child: Icon(Icons.person),
            ),
            Tab(
              child: Icon(Icons.settings),
            ),
          ]),
        ),
        body: TabBarView(children: [
          Container(
            color: Colors.red,
            child: Column(children: [Icon(Icons.home),
            FloatingActionButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (context) => Column(
          children: [
            SizedBox(height: 20,),
            ListTile(leading: Icon(Icons.home), title: Text("Home")),
            SizedBox(height: 20,),
            ListTile(leading: Icon(Icons.person), title: Text("Person")),
            SizedBox(height: 20,),
            ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
            SizedBox(height: 20,),
            ListTile(leading: Icon(Icons.home), title: Text("Home")),
            SizedBox(height: 20,),
            ListTile(leading: Icon(Icons.person), title: Text("Person")),
            SizedBox(height: 20,),
            ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Close"))
          ],
        ),
        isScrollControlled: true
        );
        },
        child: Icon(Icons.text_increase),
        shape: CircleBorder(),
        backgroundColor: Colors.blueAccent,)]),
          ),
          Container(
            color: Colors.blue,
            child: Center(child: Lottie.network("https://lottie.host/88eba5dd-e5ed-4ba5-aefe-567a60f534ba/8FkkNfVc8b.json")),
          ),
          Container(
            color: Colors.green,
            child: Center(child: Icon(Icons.settings),),
          ),
        ]),
      ),
    );
  }
}