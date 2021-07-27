import 'package:flutter/material.dart';
import 'package:shoesapp/homepage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoes App',
      theme: ThemeData(
        fontFamily: 'Nunito' ,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      
    );
  }
}



// in this app work for both the web and app 
//this is gonna be intresting 
// lets kick start