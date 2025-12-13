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
    List <ModelCard> favMeals = views.where((m) => m.isfavorite == true).toList();
    return favMeals.isEmpty ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_disabled, size: 150, color: Colors.grey,),
          SizedBox(height: 20,),
          Text("There is no favirote meals")
        ],
      ),
    ): ListView.builder(itemBuilder: (context,index){
      return CustomFavCard(modelCard: favMeals[index], 
      onTap: (){
        setState(() {
          int indexOfMealOfViews = views.indexOf(favMeals[index]);
          int indexOfMealOfCategory = categoryList.indexOf(favMeals[index]);
          views[indexOfMealOfViews] = views[indexOfMealOfViews].copyWith(isfavorite: false);
          categoryList[indexOfMealOfCategory] = categoryList[indexOfMealOfCategory].copyWith(isfavorite: false);
        });
      },);
    },
    itemCount: favMeals.length,);
    
  }
}