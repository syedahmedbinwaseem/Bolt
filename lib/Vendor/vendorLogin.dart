import 'package:bolt/User/homeScreen.dart';
import 'package:bolt/User/signupScreen.dart';
import 'package:bolt/Vendor/vendorProduct.dart';
import 'package:bolt/Vendor/vendorSignup.dart';
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

  void toggle() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int count = 0;

    int emailValidate;
    bool emailValidatorvar;
    return WillPopScope(
      onWillPop: () {
        if (FocusScope.of(context).isFirstFocus == false) {
          Navigator.pop(context);
        } else {
          FocusScope.of(context).unfocus();
        }

        count++;
        return null;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.grey[400],
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
            child: Form(
              key: fkey,
              child: Container(
                color: Colors.grey[400],
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
                                  fontFamily: 'Segoe',
                                  fontSize: height * 0.025),
                            ),
                            Container(
                              width: width * 0.91,
                              height: 50,
                              child: TextFormField(
                                validator: (input) {
                                  emailValidate = validateEmail(input);
                                  return null;
                                },
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
                                // ignore: missing_return
                                validator: (input) {
                                  emailValidatorvar = validateStructure(input);
                                },
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
                                  FormState fs = fkey.currentState;
                                  fs.validate();
                                  if (emailValidate == 1) {
                                    Fluttertoast.showToast(
                                      msg: "Invalid Email",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 15,
                                    );
                                  } else if (emailValidate == 2) {
                                    Fluttertoast.showToast(
                                      msg: "Email is Empty",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 15,
                                    );
                                  } else {}

                                  if (emailValidatorvar == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VendorProduct()),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Invalid Password",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 15,
                                    );
                                  }
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
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              print('asas');
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VendorSignup()));
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
