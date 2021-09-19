import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesapp/homepage.dart';
import 'dart:ui';
import 'dart:math' as math;



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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




// class SampleAnimation extends StatefulWidget{

//   SampleAnimation();

//   @override
//   State<StatefulWidget> createState() {
//     return SampleAnimationState();
//   }
// }

// class SampleAnimationState extends State<SampleAnimation> with SingleTickerProviderStateMixin {

//   late AnimationController _controller;
//   late Animation _animation;
//   late Path _path;

//   @override
//   void initState() {
//     _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 10000));
//     super.initState();
//     _animation = Tween(begin: 0.4,end: 1.0).animate(_controller)
//       ..addListener((){
//         setState(() {
//         });
//       });
//     _controller.forward();
//     _path  = drawPath();
//   }



//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//           home: Scaffold(
//         body: Stack(
//           children: <Widget>[

            
//             Positioned(
//               top: calculate(_animation.value).dy,
//               left: calculate(_animation.value).dx,
            //   child: 
            //   Container(
            //     decoration: BoxDecoration(
            //       color: Colors.blueAccent,
            //       borderRadius: BorderRadius.circular(10)
            //     ),
            //     width: 10,
            //       height: 10,
            //   ),
            // ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Path drawPath(){
//     Size size = Size(300,650);
//     Path path = Path();
//   //  path.lineTo(size.width /2, 0);
//       path.cubicTo(size.width * 0.96, size.height * 0.36, size.width, size.height * 0.59, size.width, size.height);
//     return path;
//   }


//   Offset calculate(value) {
//     PathMetrics pathMetrics = _path.computeMetrics();
//     PathMetric pathMetric = pathMetrics.elementAt(0);
//     value = pathMetric.length * value;
//     Tangent? pos = pathMetric.getTangentForOffset(value);
//     return pos!.position;
//   }

// }










