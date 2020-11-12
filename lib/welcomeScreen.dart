import 'dart:math';

import 'package:bolt/User/loginScreen.dart';
import 'package:bolt/User/signupScreen.dart';
import 'package:bolt/Vendor/vendorLogin.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController animate;
  Animation animation;
  AnimationStatus animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    animate =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
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
      body: SafeArea(
        child: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(pi * animation.value),
          child: animation.value <= 0.5
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Welcome to ',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: 'Segoe',
                                      color: Colors.grey[700])),
                              TextSpan(
                                  text: 'Bolt',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: 'Segoe',
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Explore Us',
                          style: TextStyle(
                              fontFamily: 'Segoe',
                              fontSize: 20,
                              color: Colors.grey[700]),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.92,
                          // color: Colors.yellow,
                          child: Image.asset('assets/images/welcome.png'),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF667EEA),
                                              offset: Offset(0, 6),
                                              blurRadius: 3,
                                              spreadRadius: -4)
                                        ],
                                        borderRadius: BorderRadius.circular(6),
                                        gradient: LinearGradient(colors: [
                                          Color(0xFF667EEA),
                                          Color(0xFF64B6FF)
                                        ]),
                                        color: Colors.yellow,
                                      ),
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Center(
                                        child: Text(
                                          'Log in',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Segoe',
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 17),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        'Signup',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Segoe',
                                            color: Colors.grey[700]),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue[100],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (animationStatus ==
                                          AnimationStatus.dismissed) {
                                        animate.forward();
                                      } else {
                                        animate.reverse();
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        'Switch to vendor',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.045),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[400],
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Welcome to ',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontFamily: 'Segoe',
                                        color: Colors.grey[700])),
                                TextSpan(
                                    text: 'Bolt',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontFamily: 'Segoe',
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Explore Us',
                            style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: 20,
                                color: Colors.grey[700]),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.12),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.92,
                            // color: Colors.yellow,
                            child: Image.asset('assets/images/welcome.png'),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VendorLogin()));
                                    },
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF667EEA),
                                                offset: Offset(0, 6),
                                                blurRadius: 3,
                                                spreadRadius: -4)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF667EEA),
                                            Color(0xFF64B6FF)
                                          ]),
                                          color: Colors.yellow,
                                        ),
                                        height: 45,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        child: Center(
                                          child: Text(
                                            'Log in',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Segoe',
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 17),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.blue[100],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (animationStatus ==
                                            AnimationStatus.dismissed) {
                                          animate.forward();
                                        } else {
                                          animate.reverse();
                                        }
                                      },
                                      child: Center(
                                        child: Text(
                                          'Switch to user',
                                          style: TextStyle(
                                              fontFamily: 'Segoe',
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.045),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
