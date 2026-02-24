import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/CustomColor.dart';
import 'package:flutter_application_6/CustomSplashforntStyle.dart';
import 'package:flutter_application_6/CustomTextFeild.dart';
import 'package:flutter_application_6/Custombuttonhome.dart';
import 'package:flutter_application_6/LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addUser() {
  return users
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .set({
      'full_name': emailController.text,
      'role': 'user',
    })
    .then((value) => print("User Added"))
    .catchError((error) => print("Failed to add user: $error"));
}

  Future<String> singUp() async{
    try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailController.text,
    password: PasswordController.text,
  );
  return "done";
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    return('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    return('The account already exists for that email.');
  }
} catch (e) {
  return(e.toString());
}
  return "error";
  }
  final emailController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final UserNameController = TextEditingController();
    final PasswordController = TextEditingController();

    final _Formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     List<CustomTextFeild> fields = [
      CustomTextFeild(
        customHintText: 'example@gmail.com',
        customLable: 'Email',
        icon: Icons.email,
        type: TextInputType.emailAddress,
        inputMessage: (value){
          if(value!.isEmpty ) return 'Please write your email';
          // if(!value.contains(r'^[\w-\.]+@([\w-]+\.)+[\w-]$')) return "Must email have '@'";
        },
        controller: emailController,flag: false,
      ),
      CustomTextFeild(
        customHintText: '07********',
        customLable: 'Phone number',
        icon: Icons.phone,
        type: TextInputType.phone,
         inputMessage: (value){
          if(!value!.contains("07")) return 'Please begin with 07 etc.';
          if(value.isEmpty ) return 'Please write your email';
          if(value.length != 10) return "The number must be from 10 numbers";
        },
        controller: phoneNumberController,
        flag: false,
      ),
      CustomTextFeild(
        customHintText: 'User Name',
        customLable: 'User Name',
        icon: Icons.person,
        type: TextInputType.name,
         inputMessage: (value){
          if(value!.isEmpty ) return 'Please write your email';
          if(!RegExp(r'.*[a-zA-Z].*').hasMatch(value)) return "Username must contain letters";
        },
        controller: UserNameController,flag: false,
      ),
      CustomTextFeild(
        customHintText: 'more than 6 digits',
        customLable: 'Password',
        icon: Icons.lock,
         inputMessage: (value){
          if(value!.isEmpty ) return 'Please write your email';
          if(!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) return "The password not valid ";
        },
        controller: PasswordController,flag: true,
      ),
    ];
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: CustomColor.colorDecor,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // CustomReturn(),
              Container(
                margin: EdgeInsets.only(left: 80),
                child: Text(
                  'Save Your Account',
                  style: CustomSplashForntStyle.splashFont,
                ),
              ),
              Form(
                key: _Formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: fields.map((f) => f).toList()
                ),
              ),
              Custombuttonhome(
                nameButton: 'Account Regisration',
                action: () {
                  if(_Formkey.currentState!.validate()){
                    singUp();
                    addUser();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> Loginscreen()));
                  }
                },
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Have an account! ",style: TextStyle(color: Colors.white,fontSize: 15),),
                InkWell(child: Text("Login", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold,fontSize: 17),),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Loginscreen()));
                },)
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}