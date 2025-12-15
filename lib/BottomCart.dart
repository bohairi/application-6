import 'package:flutter/material.dart';
import 'package:flutter_application_6/data_base.dart';
import 'package:flutter_application_6/model_card.dart';
import 'package:flutter_application_6/widgets/custom_cart.dart';

class BottomCart extends StatelessWidget {
  List <ModelCard> cart;
  BottomCart({super.key, required this.cart});
  @override
  Widget build(BuildContext context) {
    return cart.isEmpty ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_checkout, size: 80,color: Colors.grey,),
          SizedBox(height: 20,),
          Text("There is no Carts", style: TextStyle(fontSize: 20,color: Colors.grey),)
        ],
      )
    ) : Column(
      children: [
        SizedBox(height: 20,),
        Text("Total Price : ${totalPrice(cart)}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Expanded(
          child: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context,index){
            return CustomCart(model: cart[index],);
          }),
        ),
      ],
    );
  }
  double totalPrice (List <ModelCard> cart){
  double sum = 0;
  cart.forEach((m){
    sum += m.price;
  } );
  return sum;
}
}
