
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:jobsearch/Page5.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SixScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/Good team-pana 1 (1).png'),
            Container(
              child: Text('Make your dream career with job',style: TextStyle(fontSize: 35,color: Colors.black,),) ,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child:Text('We help you find your dream job according to your skillset, location & preference to build your career.',style: TextStyle(fontSize: 15,),),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Container(
                  margin: EdgeInsets.only(bottom: 140),
                ) ,

                Container(
                  margin: EdgeInsets.only(right: 80),

                ),

                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                      ),

                      onPressed: (){

                      },
                      child:Container(
                        width: 220,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),

                        child:Center(
                          child:Text('Explore',style:TextStyle(fontSize: 24,color: Colors.white) ,)  ,
                        ),
                      )
                  ) ,
                )


              ],
            )
          ],
        ),
      ),
    );
  }
}