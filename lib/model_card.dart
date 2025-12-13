import 'package:flutter/material.dart';

class ModelCard {
final String title;
final String subtitle;
final String urlImaige;
final bool isfavorite;
final String category;

ModelCard({required this.title, required this.subtitle, required this.urlImaige, required this.isfavorite, required this.category});

ModelCard copyWith({
String? title,
String? subtitle,
String? urlImaige,
bool? isfavorite,
String? category
}){
  return ModelCard(title: title?? this.title, subtitle: subtitle ?? this.subtitle , urlImaige: urlImaige ?? this.urlImaige, isfavorite: isfavorite ?? this.isfavorite, category: category ?? this.category);
}
}

