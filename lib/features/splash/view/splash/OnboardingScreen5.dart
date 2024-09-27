import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen6.dart';
// import 'package:jobsearch/Page4.dart';
// import 'package:jobsearch/Page6.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FifthScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('images/Career progress-pana 1.png'),
            Container(
              child: Text('Search your dream job fast and ease',style: TextStyle(fontSize: 35,color: Colors.black,),) ,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child:Text('Figure out your top five priorities -- whether it is company culture, salaryor a specific job position. ',style: TextStyle(fontSize: 15,),),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 170),
                ),
                Container(
                  margin: EdgeInsets.only(right: 90),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SixScreen(),));
                    },
                    child:Text('Skip',style: TextStyle(fontSize: 17,color: Colors.grey,),) ,
                  ),
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),

                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SixScreen(),));
                    },
                    child:Container(
                      width: 80,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),

                      child:Container(
                          child:Center(
                            child:Text('Next',style:TextStyle(fontSize: 24,color: Colors.white) ,),
                          )
                      ),
                    )
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}