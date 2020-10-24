import 'package:bolt/homeScreen.dart';
import 'package:bolt/signupScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  bool showPass = true;

  void toggle() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(FocusScope.of(context).children);

    final focus = FocusNode();
    final focus1 = FocusNode();
    print(FocusScope.of(context).hasFocus);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int count = 0;
    return WillPopScope(
      onWillPop: () {
        if (FocusScope.of(context).isFirstFocus == false) {
          Navigator.pop(context);
        } else {
          FocusScope.of(context).unfocus();
        }

        count++;
        print(count);
        return null;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.west,
                color: Colors.grey[700],
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          elevation: 0,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color: Colors.white,
              height: height,
              width: width,
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.036),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: height * 0.05,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                                fontFamily: 'Segoe', fontSize: height * 0.025),
                          ),
                          Container(
                            width: width * 0.91,
                            height: 50,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailCon,
                              decoration: InputDecoration(
                                  hintText: 'someone@xyz.com',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Segoe',
                                      fontSize: height * 0.02)),
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            'Password',
                            style: TextStyle(
                                fontFamily: 'Segoe', fontSize: height * 0.025),
                          ),
                          Container(
                            width: width * 0.91,
                            height: 50,
                            child: TextFormField(
                              obscureText: showPass,
                              controller: passCon,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  hoverColor: Colors.pink,
                                  focusColor: Colors.grey[700],
                                  fillColor: Colors.grey[700],
                                  suffixIcon: GestureDetector(
                                      onTap: toggle,
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        size: 20,
                                        color: Colors.grey,
                                      )),
                                  hintText: '********',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Segoe',
                                      fontSize: height * 0.02)),
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            width: width - width * 0.08,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
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
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: width - width * 0.08,
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Don\'t have an account? ',
                                        style: TextStyle(
                                            fontSize: height * 0.02,
                                            fontFamily: 'Segoe',
                                            color: Colors.grey[700])),
                                    TextSpan(
                                        text: 'Sign Up',
                                        recognizer: new TapGestureRecognizer()
                                          ..onTap = () {
                                            print('asas');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUp()));
                                          },
                                        style: TextStyle(
                                            fontSize: height * 0.02,
                                            fontFamily: 'Segoe',
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
