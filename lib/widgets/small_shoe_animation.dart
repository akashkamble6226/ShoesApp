import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:shoesapp/models/single_shoe_class.dart';

 class SmallShoeAnimation extends StatefulWidget {
  const SmallShoeAnimation({
    Key? key,
    required this.smallShoeItsVisible,
    required this.shoe,
  }) : super(key: key);

  final bool smallShoeItsVisible;
  final Shoe shoe;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

 
}

class SmallShoeAnimationState extends State<SmallShoeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Path _path;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 10000));
    super.initState();
    _animation = Tween(begin: 0.4, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    _path = drawPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              top: calculate(_animation.value).dy,
              left: calculate(_animation.value).dx,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)
                ),
                width: 10,
                  height: 10,
              ),
            ),
          ],
        ),
      
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Path drawPath() {
    Size size = Size(300, 650);
    Path path = Path();
    //  path.lineTo(size.width /2, 0);
    path.cubicTo(size.width * 0.96, size.height * 0.36, size.width,
        size.height * 0.59, size.width, size.height);
    return path;
  }

  Offset calculate(value) {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos!.position;
  }
}
