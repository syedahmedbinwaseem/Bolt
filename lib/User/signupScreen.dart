import 'package:bolt/User/homeScreen.dart';
import 'package:bolt/User/loginScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey fkey = GlobalKey<FormState>();
  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  final nameCon = TextEditingController();
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
    print(emailValidate);
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
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
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
                            SizedBox(height: height * 0.0165),
                            Text(
                              'Signup',
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
                                  'Name',
                                  style: TextStyle(
                                      fontFamily: 'Segoe',
                                      fontSize: height * 0.025),
                                ),
                                Container(
                                  width: width * 0.91,
                                  height: height * 0.082,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: nameCon,
                                    decoration: InputDecoration(
                                        hintText: 'Mike Milligan',
                                        hintStyle: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: height * 0.02)),
                                  ),
                                ),
                                SizedBox(height: height * 0.05),
                                Text(
                                  'Email',
                                  style: TextStyle(
                                      fontFamily: 'Segoe',
                                      fontSize: height * 0.025),
                                ),
                                Container(
                                  width: width * 0.91,
                                  height: height * 0.082,
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
                                SizedBox(height: height * 0.05),
                                Text(
                                  'Password',
                                  style: TextStyle(
                                      fontFamily: 'Segoe',
                                      fontSize: height * 0.025),
                                ),
                                Container(
                                  width: width * 0.91,
                                  height: height * 0.082,
                                  child: TextFormField(
                                    // ignore: missing_return
                                    validator: (input) {
                                      emailValidatorvar =
                                          validateStructure(input);
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
                                SizedBox(height: height * 0.066),
                                Container(
                                  width: width - width * 0.08,
                                  child: GestureDetector(
                                    onTap: () {
                                      FormState fs = fkey.currentState;
                                      fs.validate();
                                      print(emailValidate);
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
                                                  HomeScreen()),
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF667EEA),
                                            Color(0xFF64B6FF)
                                          ]),
                                          color: Colors.yellow,
                                        ),
                                        height: height * 0.065,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Center(
                                          child: Text(
                                            'Sign Up',
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
                                  height: height * 0.03,
                                ),
                                Container(
                                  width: width - width * 0.08,
                                  height: height * 0.03,
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Already have an account? ',
                                              style: TextStyle(
                                                  fontSize: height * 0.02,
                                                  fontFamily: 'Segoe',
                                                  color: Colors.grey[700])),
                                          TextSpan(
                                              text: 'Log in',
                                              recognizer:
                                                  new TapGestureRecognizer()
                                                    ..onTap = () {
                                                      print('asas');
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoginScreen()));
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

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
