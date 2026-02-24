import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/CustomColor.dart';
import 'package:flutter_application_6/CustomSplashforntStyle.dart';
import 'package:flutter_application_6/CustomTextFeild.dart';
import 'package:flutter_application_6/Custombuttonhome.dart';
import 'package:flutter_application_6/HomepageTask.dart';
import 'package:flutter_application_6/Register_screen.dart';
import 'package:flutter_application_6/admin.dart';
import 'package:flutter_application_6/class_bottom_navigation.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  Future<String> logIn() async{
      try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: loginEmailController.text,
    password: loginPasswordController.text,
  );
  return "done";
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    return('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    return('Wrong password provided for that user.');
  }
}
  return "error";
    }
    final loginEmailController = TextEditingController();
    final loginPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    List<CustomTextFeild> fields = [
      CustomTextFeild(
        customHintText: 'Email',
        customLable: 'Email',
        icon: Icons.person,
          inputMessage: (value){
          if(value!.isEmpty ) return 'Please write your email';
          // if(!RegExp(r'.*[a-zA-Z].*').hasMatch(value)) return "Username must contain letters";
        },
        controller: loginEmailController,flag: false,
      ),
      CustomTextFeild(
        customHintText: 'more than 6 digits',
        customLable: 'Password',
        icon: Icons.lock,
        inputMessage: (value){
          if(value!.isEmpty ) return 'Please write your password';
          if(!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) return "The password not valid ";
        }, 
        controller: loginPasswordController,flag: true,
             ),
    ];
    final _Formkey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: CustomColor.colorDecor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // CustomReturn(),
            Text('Login Screen', style: CustomSplashForntStyle.splashFont),
            Form(
              key: _Formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: fields.map((f) => f).toList()
              ),
            ),
            
            Custombuttonhome(nameButton: 'Login to account', action: ()async {
              if(_Formkey.currentState!.validate()){
                String result = await logIn();
                if(result == "done"){
                  final doc = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
                  if(doc['role'] == "user"){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ClassBottomNavigation()));
                  }
                  else if(doc['role'] == "admin"){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Admin()));
                  }
                }
                 else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
              loginEmailController.clear();
              loginPasswordController.clear();
             }
              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account! ",style: TextStyle(color: Colors.white,fontSize: 15),),
                InkWell(child: Text("Sing Up", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold,fontSize: 17),),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> RegisterScreen()));
                },)
              ],
            ),
          ],
        ),
      ),
    );
  }
}