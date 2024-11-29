
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_page/src/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingScreen extends StatefulWidget{

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  final pages = [];

  final controller = LiquidController();

  int currentpage =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
              pages: [
                Container(color: Colors.pinkAccent.shade700,
                width: double.infinity,
                child:
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(image: AssetImage("assets/images/ob2.png")),
                      SizedBox(height: 50,),
                      Text("1) Fully Secured App",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),),
                      SizedBox(height: 10,),
                      Text("This is a fully secured application.",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                      ,SizedBox(height: 20,)
                      ,Text("1/3",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                    ],
                  )
                ),
                Container(color: Colors.yellow.shade800,
                  width: double.infinity,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/images/ob3.png")),
                    SizedBox(height: 50,),
                    Text("2) Fast Working ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),),
                    SizedBox(height: 10,),
                    Text("This is a fully secured application.",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                    ,SizedBox(height: 20,)
                    ,Text("2/3",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                  ],
                ),
                ),
                Container(color: Colors.green.shade900,
                  width: double.infinity,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/images/ob4.png")),
                    SizedBox(height: 50,),
                    Text("3) ShieldBase",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),),
                    SizedBox(height: 10,),
                    Text("A fully shielded database.",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                    ,SizedBox(height: 20,)
                    ,Text("3/3",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                  ],
                ),),
              ],
            liquidController: controller,
            slideIconWidget: Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
            onPageChangeCallback: onPageChangeCallBack,
          ),
          Positioned(
              bottom: 60,
              child: OutlinedButton(onPressed: (){
                int nextpage = controller.currentPage + 1;
                controller.animateToPage(page: nextpage);
              },
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.black),
                  shape:CircleBorder(),
                  padding: EdgeInsets.all(20)),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle
                    ),
                    child: Icon(Icons.arrow_forward),
                  ))),
          Positioned(
              bottom:25,
              child: AnimatedSmoothIndicator(activeIndex: controller.currentPage,
                  effect: WormEffect(
                    activeDotColor: Colors.orange,
                    dotHeight: 5.0
                  ) ,count: 3,
              )),
          Positioned(
              top: 30,
              right: 20,
              child: TextButton(onPressed:(){
                controller.jumpToPage(page: 2);
              },child: Text("Skip")))
        ],
      ),
    );
  }

  void onPageChangeCallBack(int activePageIndex) {
    setState(() {

    });
  }
}