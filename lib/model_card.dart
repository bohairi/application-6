import 'package:flutter/material.dart';

class ModelCard {
final String title;
final String subtitle;
final String urlImaige;
final bool isfavorite;

ModelCard({required this.title, required this.subtitle, required this.urlImaige, required this.isfavorite});

ModelCard copyWith({
String? title,
String? subtitle,
String? urlImaige,
bool? isfavorite,
}){
  return ModelCard(title: this.title, subtitle: this.subtitle , urlImaige: this.urlImaige, isfavorite: isfavorite ?? this.isfavorite);
}
}

