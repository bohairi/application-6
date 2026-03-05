import 'package:flutter/material.dart';

class ModelCard {
final String? id;
final String title;
final String subtitle;
final String urlImaige;
final bool isfavorite;
final String category;
final double price;

ModelCard({this.id,required this.title, required this.subtitle, required this.urlImaige, this.isfavorite = false, required this.category, required this.price});

ModelCard copyWith({
String? id,
String? title,
String? subtitle,
String? urlImaige,
bool? isfavorite,
String? category,
double? price
}){
  return ModelCard(id: id?? this.id,title: title?? this.title, subtitle: subtitle ?? this.subtitle , urlImaige: urlImaige ?? this.urlImaige, isfavorite: isfavorite ?? this.isfavorite, category: category ?? this.category, price: price ?? this.price);
}

//toMap
Map<String,dynamic> toMap(){
  return {
    "id" : id,
    "name" : title,
    "category" : category,
    "price" : price,
    "description" : subtitle,
    "img" : urlImaige,
    "isfavorite" : isfavorite,
  };
}
//fromMap
factory ModelCard.fromMap(Map<String,dynamic> map, String docID){
  return ModelCard(isfavorite: map["isfavorite"],id: docID, title: map["name"], subtitle: map["description"], urlImaige: map["img"], category: map["category"], price: map["price"]);
}
}

