import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/data_base.dart';
import 'package:flutter_application_6/model_card.dart';
import 'package:flutter_application_6/widgets/custom_fav_card.dart';

class BottomFavorite extends StatefulWidget {
  const BottomFavorite({super.key});

  @override
  State<BottomFavorite> createState() => _BottomFavoriteState();
}

class _BottomFavoriteState extends State<BottomFavorite> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(stream: FirebaseFirestore.instance.collection("users").doc(uid).collection("isFav").snapshots(), builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator());
      }
      else if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
        return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_disabled, size: 150, color: Colors.grey,),
          SizedBox(height: 20,),
          Text("There is no favirote meals")
        ],
      ),);
      }
      final favorit = snapshot.data!.docs.map((cart) => ModelCard.fromMap(cart.data(), cart.id)).toList();
      return ListView.builder(itemCount: favorit.length,itemBuilder: (context,index){
        return CustomFavCard(modelCard: favorit[index], onTap: (){
          if(favorit[index].isfavorite){
            FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("isFav").doc(favorit[index].id).delete();
          }
          else{
            FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("isFav").doc(favorit[index].id).set(favorit[index].toMap());
          }
        });
      });
    });
    // List <ModelCard> favMeals = views.where((m) => m.isfavorite == true).toList();
    // return favMeals.isEmpty ? Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Icon(Icons.hourglass_disabled, size: 150, color: Colors.grey,),
    //       SizedBox(height: 20,),
    //       Text("There is no favirote meals")
    //     ],
    //   ),
    // ): ListView.builder(itemBuilder: (context,index){
    //   return CustomFavCard(modelCard: favMeals[index], 
    //   onTap: (){
    //     setState(() {
    //       int indexOfMealOfViews = views.indexOf(favMeals[index]);
    //       int indexOfMealOfCategory = categoryList.indexOf(favMeals[index]);
    //       views[indexOfMealOfViews] = views[indexOfMealOfViews].copyWith(isfavorite: false);
    //       categoryList[indexOfMealOfCategory] = categoryList[indexOfMealOfCategory].copyWith(isfavorite: false);
    //     });
    //   },);
    // },
    // itemCount: favMeals.length,);
    
  }
}