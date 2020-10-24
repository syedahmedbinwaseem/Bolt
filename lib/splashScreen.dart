import 'dart:async';

import 'package:bolt/welcomeScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), onClose);
  }

  void onClose() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF667EEA),
                  Color(0xFF64B6FF),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Color(0xFF667EEA),
                      //     spreadRadius: 1,
                      //     blurRadius: 1,
                      //     offset: Offset(2, 2),
                      //   )
                      // ],
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Color(0xFF667EEA),
                        Color(0xFF64B6FF),
                      ])),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.3,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Color(0xFF667EEA),
                    //     spreadRadius: 1,
                    //     blurRadius: 1,
                    //     offset: Offset(2, 2),
                    //   )
                    // ],
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF667EEA),
                        Color(0xFF64B6FF),
                      ],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.18,
                    backgroundColor: Colors.transparent,
                    child: Image(
                      image: AssetImage('assets/images/splash.png'),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.15),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              child:
                                  Image.asset('assets/images/lightning.png')),
                          Text(
                            'Bolt',
                            style: TextStyle(
                                fontFamily: 'Segoe Bold', fontSize: 30),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06)
                        ],
                      ))),
            ],
          ),
        ],
      ),
    );
  }
}
