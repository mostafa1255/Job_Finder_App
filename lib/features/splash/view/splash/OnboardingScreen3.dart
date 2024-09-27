import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen4.dart';
// import 'package:jobsearch/Page4.dart';
// import 'package:jobsearch/Page6.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ThirdScreen extends StatelessWidget{
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
            Image.asset('assets/images/Resume-amico 1 (2).png'),
            Container(
              child: Text('Apply to best jobs',style: TextStyle(fontSize: 35,color: Colors.black,),) ,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child:Text('You can apply to your desirable jobs very quickly and easily with ease.',style: TextStyle(fontSize: 15,),),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FourthScreen(),));
                    },
                    child:Text('Skip',style: TextStyle(fontSize: 17,color: Colors.grey,),) ,
                  ),
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),

                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FourthScreen(),));
                    },
                    child:Container(
                      width: 80,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),

                      child:Center(
                        child:Text('Next',style:TextStyle(fontSize: 24,color: Colors.white) ,)  ,
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