import 'package:flutter/material.dart';
import 'package:flutter_application_6/model_card.dart';

class CustomFavCard extends StatelessWidget {
  ModelCard modelCard;
  VoidCallback onTap;
  CustomFavCard({super.key, required this.modelCard, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              leading: Image.asset(modelCard.urlImaige),
              title: Text(modelCard.title),
              subtitle: Text(modelCard.subtitle),
              trailing: InkWell
              (
                onTap: onTap,
                child: Icon(Icons.favorite, color: Colors.red,)),
            ),
          ),
        ),
      ),
    );
  }
}