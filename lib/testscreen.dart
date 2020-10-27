import 'dart:math';

import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with TickerProviderStateMixin {
  AnimationController animate;
  Animation animation;
  AnimationStatus animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate = AnimationController(
        vsync: this, duration: Duration(milliseconds: 10000));
    animation = Tween<double>(end: 1, begin: 0).animate(animate)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        animationStatus = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(pi * animation.value),
          child: GestureDetector(
            onTap: () {
              if (animationStatus == AnimationStatus.dismissed) {
                animate.forward();
              } else {
                animate.reverse();
              }
            },
            child: animation.value <= 0.5
                ? Container(
                    height: 300,
                    width: 300,
                    color: Colors.yellow,
                  )
                : Container(
                    height: 300,
                    width: 300,
                    color: Colors.green,
                  ),
          ),
        ),
      ),
    );
  }
}
