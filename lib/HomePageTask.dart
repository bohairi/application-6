import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_6/admin.dart';
import 'package:flutter_application_6/data_base.dart';
import 'package:flutter_application_6/model_card.dart';
import 'package:flutter_application_6/widgets/CustomGridviewTask.dart';
import 'package:flutter_application_6/widgets/custom_fav_card.dart';
import 'package:flutter_application_6/widgets/custom_widget_task.dart';

class HomePageTask extends StatefulWidget {
  List <ModelCard> cart = [];
  HomePageTask({super.key, required this.cart});
  @override
  State<HomePageTask> createState() => _HomePageTaskState();
}

class _HomePageTaskState extends State<HomePageTask> {
    String uid = FirebaseAuth.instance.currentUser!.uid;
  String typeOfCategory = "All";
  int indexofCategory = 0;
  searchInEditText (String query){
    if(query.isEmpty){
      searchInCategory(typeOfCategory);
    }
    else{
    final filterdText = categoryList.where((m) => m.title.toLowerCase().contains(query)).toList();
    categoryList = filterdText;}
  }
  
  searchInCategory(String type){
    typeOfCategory = type;
    if (type.toLowerCase() == "all"){
      setState(() {
        categoryList = views;
      });
    }
    else{
      final filterd = views.where((m) => m.category.toLowerCase() == type.toLowerCase()).toList();
      setState(() {
        categoryList = filterd;
      });
    }

  }
  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
     
      Container(
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 50,
                     child: Material(
                      shadowColor: Colors.grey,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                       child: TextField(
                        controller: searchText,
                        onChanged: (value) {                
                          setState(() {
                            searchInEditText(value);
                          });
                        },
                           decoration: InputDecoration(
                             prefixIcon: Icon(Icons.search,size: 30,),
                             hintText: "Search",
                             // labelText: "Search",
                             border: OutlineInputBorder(
                               borderSide: BorderSide.none
                             )
                           ),
                         ),
                     ),
                   ),
                  // Container(
                  //   height: 45,
                  //   width: MediaQuery.of(context).size.width * 0.7,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(20),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey,
                  //         blurRadius: 2,
                  //         spreadRadius: 1,
                  //         offset: Offset(0, 3)
                  //       )
                  //     ]
                  //   ),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       prefixIcon: Icon(Icons.search,size: 30,),
                  //       hintText: "Search",
                  //       // labelText: "Search",
                  //       border: OutlineInputBorder(
                  //         borderSide: BorderSide.none
                  //       )
                  //     ),
                  //   ),
                  // ),
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10)
          
                    ),
                    child: IconButton(onPressed: (){
                      FirebaseAuth.instance.signOut();
                    }, icon: Icon(Icons.logout,
                    color: Colors.white,
                    size: 30,),),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(),
                height: 35,
                child: ListView.builder(
                  itemExtent: MediaQuery.of(context).size.width * 0.25,
                  scrollDirection: Axis.horizontal,
                  itemCount: texts.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: () => 
                      setState(() {
                        searchInCategory(texts[index]);
                        indexofCategory = index;
                      }),
                      child: CustomWidgetTask(widget_title: texts[index], color: indexofCategory == index ? Colors.red : Colors.grey,colorOfText: indexofCategory == index ? Colors.white : Colors.black,));
                }),
              ),
              Expanded(
                child: StreamBuilder(stream: FirebaseFirestore.instance.collection("products").snapshots(), builder: (context,productSnapshot){
                  if(!productSnapshot.hasData){
                    return Center(child: Text("Nothing"),);
                  }
                  final products = productSnapshot.data!.docs.map((product) => ModelCard.fromMap(product.data(), product.id)).where((p) => p.category == typeOfCategory ||  typeOfCategory == "All" ).where((p) => p.title.toLowerCase().contains(searchText.text)).toList();
                  return StreamBuilder(stream: FirebaseFirestore.instance.collection("users").doc(uid).collection("isFav").snapshots(), builder: (context,favSnapshot){
                    if(!favSnapshot.hasData){
                      return Center(child: Text("Nothing"),);
                    }
                    final favId = favSnapshot.data!.docs.map((f) => f.id).toList();
                    final productsWithFav = products.map((p) => p.copyWith(isfavorite: favId.contains(p.id))).toList();
                    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemCount: productsWithFav.length, itemBuilder: (context,index){
                      return CustomGridviewTask(model: productsWithFav[index], onTap: ()async{
                        if(productsWithFav[index].isfavorite){
                         FirebaseFirestore.instance.collection("users").doc(uid).collection("isFav").doc(productsWithFav[index].id).delete();
                        }
                        else {
                          await addFav(productsWithFav[index]);
                        }
                      }, cart: widget.cart);
                      // CustomFavCard(modelCard: productsWithFav[index], onTap: () async{
                      //   if(productsWithFav[index].isfavorite){
                      //     //delete
                      //     FirebaseFirestore.instance.collection("users").doc(uid).collection("isFav").doc(productsWithFav[index].id).delete();
                      //   }
                      //   else{
                      //     await addFav(productsWithFav[index]);
                      //   }
                      // });
                    });
                  });
                }),
                // child: StreamBuilder(stream: filterCategory().snapshots(), builder: (context,snapshot){
                //   if(snapshot.connectionState == ConnectionState.waiting){
                //     return Center(child: CircularProgressIndicator(),);
                //   }
                //   else if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                //     return Center(child: Text("No Products"),);
                //   }
                //   final products = snapshot.data!.docs.map((doc) => ModelCard.fromMap(doc.data() as Map <String,dynamic>, doc.id)).toList();
                //   return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemCount: products.length, itemBuilder: (context,index){
                //     return CustomGridviewTask(model: products[index], onTap: (){
                //       addFav(products[index]);
                //     }, cart: products);
                //   });
                // }),
                // child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemCount: categoryList.length, itemBuilder: (context,index){
                //    return CustomGridviewTask(model: categoryList[index], 
                //    onTap: (){
                //     setState(() {
                //       final item = categoryList[index];
                //       final mainIndex = views.indexOf(item);
                //       views[mainIndex] = views[mainIndex].copyWith(
                //         isfavorite: !views[mainIndex].isfavorite
                //       );
                //       searchInCategory(typeOfCategory);
                //     });
                    
                //    },
                //    cart: widget.cart,);
                // }),
              )
            ],
          ),
        ),

      );
  }
  // Query filterCategory(){
  //   if(typeOfCategory == "All"){
  //     return FirebaseFirestore.instance.collection("products");
  //   }
  //   return FirebaseFirestore.instance.collection("products").where("category", isEqualTo: typeOfCategory);
  // }

  Future<void> addFav(ModelCard product) async{
    String id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("users").doc(id).collection("isFav").doc(product.id).set(product.toMap());
  }
}