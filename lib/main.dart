import 'dart:async';
//import 'package:colorsoul/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'appColors.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Colorsoul',
      home: splash(),
    );
  }
}

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState()
  {
    super.initState();
    Timer(
        Duration(milliseconds: 1500),
            () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()))
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          SingleChildScrollView(child: Image.asset('assets/images/Flesh2.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height)),
          Center(
            child: Image.asset('assets/images/Colorsoul_final-022(Traced).png',width: width - 180,)
          )
        ],
      )
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int currentPage = 0;
//   PageController _controller;
//
//   @override
//   void initState(){
//     _controller = PageController(initialPage: 0);
//     super.initState();
//   }
//
//   @override
//   void dispose()
//   {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   List<Map<String,String>> SplashData = [
//     {
//       "text": "Track Your Work And Get \n Results.",
//       "image": 'assets/images/Group668.png'
//     },
//     {
//       "text": "Stay Organized With \n Team.",
//       "image": 'assets/images/Group669.png'
//     },
//     {
//       "text": "Manage Your Daily \n Todo.",
//       "image": 'assets/images/Group670.png'
//     }
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body:  Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//          image: DecorationImage(
//           image: AssetImage("assets/images/Rectangle17.png"),
//           fit: BoxFit.fill,
//         )
//       ),
//       child: NotificationListener<OverscrollIndicatorNotification>(
//           onNotification: (OverscrollIndicatorNotification overscroll) {
//             overscroll.disallowGlow();
//             return;
//           },
//           child: SingleChildScrollView(
//           padding: EdgeInsets.only(left: 10,right: 10),
//             child: Column(
//               children: [
//                 SizedBox(height: height*0.03),
//                 Container(
//                     alignment: Alignment.topRight,
//                     child: TextButton(
//                       child: Text(
//                         "<< Skip >>",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontFamily: "Roboto-Regular"
//                         ),
//                       ),
//                       onPressed: (){
//                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
//                       },
//                     )
//                 ),
//                 SizedBox(height: height*0.03),
//                 Container(
//                   height: height*0.6,
//                   child: PageView.builder(
//                       controller: _controller,
//                       onPageChanged: (value) {
//                         setState(() {
//                           currentPage = value;
//                         });
//                       },
//                       itemCount: SplashData.length,
//                       itemBuilder: (context,index) => SplashContent(
//                       image: SplashData[index]["image"],
//                       text: SplashData[index]["text"]
//                     )
//                   ),
//                 ),
//                 SizedBox(height: height*0.05),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                       SplashData.length,
//                           (index) => buildDot(index: index)
//                   ),
//                 ),
//                 SizedBox(height: height*0.1),
//                 Container(
//                   height: 60,
//                   width: width-80,
//                   decoration: BoxDecoration(
//                         gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Colors.black,Color(0xFF3C3939), Colors.black,Colors.black,Colors.black]),
//                         borderRadius: round.copyWith()
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if(currentPage == SplashData.length -1){
//                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
//                         }
//                         _controller.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);
//                       },
//                       style: ElevatedButton.styleFrom(
//                           elevation: 14,
//                           primary: Colors.transparent,
//                           shape: StadiumBorder(),
//                       ),
//                       child: Text(currentPage == SplashData.length  - 1 ? 'Continue' : 'Next',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: "Roboto-Regular"
//                           ),
//                       ),
//                     ),
//                   )
//               ],
//             )
//         ),
//       ),
//      )
//     );
//   }
//
//   AnimatedContainer buildDot({int index}) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 200),
//       margin: EdgeInsets.only(right: 10),
//       height: 10,
//       width: 10,
//       decoration: BoxDecoration(
//         gradient: currentPage == index ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Colors.white,Colors.black,Colors.black]) : LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Colors.white,Colors.grey]),
//         borderRadius: BorderRadius.circular(6)
//       ),
//     );
//   }
// }
//
// class SplashContent extends StatelessWidget {
//   SplashContent({Key key, this.text, this.image}) : super(key: key);
//
//   final String text,image;
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Column(
//         children: [
//           SizedBox(height: height*0.1),
//           Image.asset(image,width: width,height: height*0.34,),
//           SizedBox(height: height*0.08),
//           Text(
//             text,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//                 fontFamily: "Roboto-Regular"
//             ),
//           ),
//         ]
//     );
//   }
// }