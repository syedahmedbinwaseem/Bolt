import 'dart:ui';

import 'package:bolt/User/homeScreen.dart';
import 'package:bolt/User/localUser.dart';
import 'package:bolt/User/signupScreen.dart';
import 'package:bolt/welcomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey fkey = GlobalKey<FormState>();
  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  bool showPass = true;
  bool login;

  void toggle() {
    setState(() {
      showPass = !showPass;
    });
  }

  void logIn() async {
    try {
      await FirebaseFirestore.instance
          .doc("user/${emailCon.text}")
          .get()
          .then((doc) async {
        if (doc.exists) {
          try {
            // ignore: unused_local_variable
            UserCredential user = await mauth.signInWithEmailAndPassword(
                email: emailCon.text, password: passCon.text);
            setState(() {
              login = true;
            });
            if (user != null) {
              try {
                DocumentSnapshot snap = await FirebaseFirestore.instance
                    .collection("user")
                    .doc(emailCon.text)
                    .get();
                LocalUser.userData.username = snap['username'].toString();
                LocalUser.userData.email = snap['email'].toString();
                LocalUser.userData.gender = snap['gender'].toString();
                LocalUser.userData.address = snap['address'].toString();
                LocalUser.userData.phone = snap['phone'].toString();
                LocalUser.userData.city = snap['city'].toString();
              } catch (e) {
                print(e);
              }
            }
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              setState(() {
                login = true;
              });
              Fluttertoast.showToast(
                msg: "User not found for this email",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red[400],
                textColor: Colors.white,
                fontSize: 15,
              );
            } else if (e.code == 'wrong-password') {
              setState(() {
                login = true;
              });
              Fluttertoast.showToast(
                msg: "Wrong password",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red[400],
                textColor: Colors.white,
                fontSize: 15,
              );
            }
          } catch (e) {
            print("Error: " + e);
          }
        } else {
          setState(() {
            login = true;
          });

          Fluttertoast.showToast(
            msg: "User not found for this email",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red[400],
            textColor: Colors.white,
            fontSize: 15,
          );
        }
      });
    } catch (e) {
      setState(() {
        login = true;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (route) => false);

        return null;
      },
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()),
                        (route) => false);
                  }),
              elevation: 0,
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Form(
                  key: fkey,
                  child: Container(
                    color: Colors.white,
                    height: height,
                    width: width,
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.036),
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
                                      fontFamily: 'Segoe',
                                      fontSize: height * 0.025),
                                ),
                                Container(
                                  width: width * 0.91,
                                  height: 50,
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    style: TextStyle(fontFamily: 'Segoe'),
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
                                      fontFamily: 'Segoe',
                                      fontSize: height * 0.025),
                                ),
                                Container(
                                  width: width * 0.91,
                                  height: 50,
                                  child: TextFormField(
                                    style: TextStyle(fontFamily: 'Segoe'),
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
                                      setState(() {
                                        login = false;
                                      });
                                      logIn();
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
                                                0.85,
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
                                              recognizer:
                                                  new TapGestureRecognizer()
                                                    ..onTap = () {
                                                      print('asas');
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
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
          ),
          login == null
              ? Container()
              : login == false
                  ? Center(child: CircularProgressIndicator())
                  : Container()
        ],
      ),
    );
  }
}
