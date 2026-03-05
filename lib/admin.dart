import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/ShowProductsScreen.dart';
import 'package:flutter_application_6/model_card.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController img = TextEditingController();
  String selectedCategory = "All";
class _AdminState extends State<Admin> {
    bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    List<String> texts = [
      "All",
      "Burger",
      "Chicken",
      "Rice",
      "Pizza",
    ];

    // اللون الوردي المستخدم في الصورة
    const Color primaryColor = Color(0xFFF6666B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // البطاقة البيضاء (Container) التي تحتوي على العناصر
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add New Product',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // حقول الإدخال
                    customTextField(hint:'Product Name',controller: name),
                    DropdownButtonFormField(
                      initialValue: texts[0],
                      items:
                          texts
                              .map(
                                (t) =>
                                    DropdownMenuItem( child: Text(t), value: t),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value.toString();
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    customTextField(hint:'Price', controller: price),
                    customTextField(hint:'Description',controller: description),
                    customTextField(hint:'Image URL', controller: img),

                    const SizedBox(height: 10),

                    // زر إضافة المنتج
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () async{
                          setState(() {
                            isLoading = true;
                          });
                          await addProduct(ModelCard(title: name.text, subtitle: description.text, urlImaige: img.text, category: selectedCategory, price:double.parse(price.text) ));
                          setState(() {
                            isLoading = false;
                          });
                          name.clear();
                          description.clear();
                          price.clear();
                          description.clear();
                          img.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Add Product',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Showproductsscreen()));
              }, child: Text("Show Products", style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),)
            ],
          ),
        ),
      ),
    );
  }

  // ودجت مخصصة للحقول لتقليل تكرار الكود
  Widget customTextField({required TextEditingController controller,required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }

  Future<void> addProduct(ModelCard newProduct) async{
    final docRef = FirebaseFirestore.instance.collection("products").doc();
    newProduct = newProduct.copyWith(id: docRef.id);
    await docRef.set(newProduct.toMap());
  }
}
