import 'package:bolt/User/signupScreen.dart';
import 'package:bolt/Vendor/vendorProduct.dart';
import 'package:bolt/welcomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VendorLogin extends StatefulWidget {
  @override
  _VendorLoginState createState() => _VendorLoginState();
}

class _VendorLoginState extends State<VendorLogin> {
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
          .doc("admin/${emailCon.text}")
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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => VendorProduct()),
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

    int emailValidate;
    bool emailValidatorvar;
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
              backgroundColor: Colors.grey[400],
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
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
                child: Form(
                  key: fkey,
                  child: Container(
                    color: Colors.grey[400],
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

int validateEmail(String value) {
  if (value.isEmpty) return 2;

  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regex = new RegExp(pattern);

  if (!regex.hasMatch(value.trim())) {
    return 1;
  }
  return 0;
}

bool validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
