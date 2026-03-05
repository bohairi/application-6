import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/model_card.dart';

class Showproductsscreen extends StatefulWidget {
  const Showproductsscreen({super.key});

  @override
  State<Showproductsscreen> createState() => _ShowproductsscreenState();
}

class _ShowproductsscreenState extends State<Showproductsscreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF6666B),
        title: Center(child: Text("Products")),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (context, productsSnapshot) {
          if (!productsSnapshot.hasData) {
            return Center(child: Text("Nothing of products"));
          }
          final products =
              productsSnapshot.data!.docs
                  .map((doc) => ModelCard.fromMap(doc.data(), doc.id))
                  .toList();
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return cardOfProduct(
                products[index],
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Edit Product"),
                          content: TextField(controller: controller, ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancle"),
                            ),
                            TextButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("products")
                                    .doc(products[index].id)
                                    .update({"name": controller.text});
                                controller.clear();
                                Navigator.pop(context);
                              },
                              child: Text("Edite"),
                            ),
                          ],
                        );
                      },
                    );
                    // FirebaseFirestore.instance.collection("products").doc(products[index].id).update({
                    //   "name" : "batata"
                    // });
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {},
                  icon: IconButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("products")
                          .doc(products[index].id)
                          .delete();
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget cardOfProduct(ModelCard product, Widget edit, Widget delete) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Text(product.category),
                SizedBox(width: 15),
                Text(product.title),
              ],
            ),
            Row(children: [edit, delete]),
          ],
        ),
      ),
    );
  }
}
