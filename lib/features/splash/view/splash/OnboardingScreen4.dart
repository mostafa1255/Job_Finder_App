
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen5.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FourthScreen extends StatelessWidget{
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/Career progress-amico 1 (1).png'),
            Container(
              child: Text('Make your career',style: TextStyle(fontSize: 35,color: Colors.black,),) ,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child:Text('We help you find your dream job based on your skillset, location, demand.',style: TextStyle(fontSize: 15,),),
            ),

            // SmoothPageIndicator(
            //   controller:_controller,
            //   count: 4,
            //   axisDirection: Axis.horizontal,
            //   effect: ExpandingDotsEffect(
            //     spacing: 6,
            //     radius: 10,
            //     dotWidth: 24,
            //     dotHeight: 16,
            //     paintStyle: PaintingStyle.fill,
            //     strokeWidth: 1.5,
            //     dotColor: Colors.grey,
            //     activeDotColor: Colors.indigo,
            //   ),
            // ),




            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 140),
                ),
                Container(
                  margin: EdgeInsets.only(right: 80),

                ),

                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                      ),

                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FifthScreen(),));
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