import 'package:flutter/material.dart';
import 'package:flutter_application_6/widgets/CustomBottunTask.dart';

class CustomDescribtion extends StatelessWidget {
  String urlImaige;
  String title;
  String essay;
  CustomDescribtion({
    required this.urlImaige,
    required this.title,
    required this.essay
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,   
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      return Navigator.of(context).pop();
                    }, icon: Icon(Icons.arrow_back)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image(image: AssetImage(urlImaige)),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                  ],),
                ),
                SizedBox(height: 15,),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text(essay,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                  ),),
                  ],),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.multiline_chart),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomBottunTask(buttonChild: Icon(Icons.minimize,color: Colors.white,)),                  
                          Text("1"),
                          CustomBottunTask(buttonChild: Icon(Icons.add,color: Colors.white,)),                  
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBottunTask(buttonChild: Text("\$9.99",style: TextStyle(fontSize: 20,color: Colors.white),)),
                     CustomBottunTask(buttonChild: Text("ORDER NOW",style: TextStyle(fontSize: 20,color: Colors.white),))
                  ]
                )
            
              ],
            ),
          ),
        ),
      ),   
    );
  }
}