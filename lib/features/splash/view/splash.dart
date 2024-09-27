import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen1.dart';
// import 'package:jop_finder_app/features/splash/view/splash/Page1,2.dart';

class splashscreen extends StatefulWidget{
  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  void initState(){
    Future.delayed(Duration(seconds: 3),(){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>FirstScreen() ,));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(

            color: Colors.indigo,
            padding: EdgeInsets.all(100),
            child:Center(
              child:Image.asset('assets/images/Group 218.png',fit: BoxFit.fill,color: Colors.white,) ,
            )
        )
    );
  }
}
