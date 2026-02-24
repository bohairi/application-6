import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/LoginScreen.dart';
import 'package:flutter_application_6/Register_screen.dart';
import 'package:flutter_application_6/admin.dart';
import 'package:flutter_application_6/class_bottom_navigation.dart';
import 'package:flutter_application_6/gestor%20dector/gestor_detector_class.dart';
import 'package:flutter_application_6/gestor%20dector/scale_class.dart';
import 'package:flutter_application_6/tabBar/tabBar_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: userState(),
      debugShowCheckedModeBanner: false,
    );
  }
  StreamBuilder<User?> userState(){
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return CircularProgressIndicator();
      }
      else if(snapshot.hasData){
        return FutureBuilder(future: FirebaseFirestore.instance.collection("users").doc(snapshot.data!.uid).get(), builder: (context,roleSnapshot){
          if(!roleSnapshot.hasData){
            return Scaffold(body: Center(child: CircularProgressIndicator(),));
          }
          final role = roleSnapshot.data!["role"];
          if(role == "admin"){
            return Admin();
          }
          else if(role == "user"){
            return ClassBottomNavigation();
          }
          return Center(child: CircularProgressIndicator(),);
        });
      }
      return Loginscreen();
    });
  }
}

