import 'package:bolt/User/localUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isEdit = false;
  final nameCon = TextEditingController();
  final addCon = TextEditingController();
  final cityCon = TextEditingController();
  final genderCon = TextEditingController();
  final phoneCon = TextEditingController();

  void abc() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("user")
        .doc('syedahmedbinwaseem@gmail.com')
        .get();
    print(snap['username']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCon.text = LocalUser.userData.username;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var h = AppBar().preferredSize.height;
    var padding = MediaQuery.of(context).padding;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            isEdit == false
                ? IconButton(
                    padding: EdgeInsets.only(right: 15),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isEdit = !isEdit;
                      });
                    })
                : IconButton(
                    padding: EdgeInsets.only(right: 15),
                    icon: Icon(
                      Icons.done,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Do you want to save the changes?',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Segoe'),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Segoe'),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontFamily: 'Segoe',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () async {
                                    try {
                                      FirebaseFirestore.instance
                                          .collection('user')
                                          .doc('syedahmedbinwaseem@gmail.com')
                                          .update({
                                        'city': cityCon.text,
                                        'phone': phoneCon.text,
                                        'address': addCon.text,
                                      });
                                    } catch (e) {
                                      print(e);
                                    }
                                    setState(() {
                                      LocalUser.userData.city = cityCon.text;
                                      LocalUser.userData.phone = phoneCon.text;
                                      LocalUser.userData.address = addCon.text;
                                      isEdit = !isEdit;
                                    });

                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    })
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.07,
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: screenHeight * 0.055,
                      fontFamily: 'Segoe',
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        isEdit == false
                            ? Container(
                                height: screenHeight * 0.12,
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        LocalUser.userData.username == null
                                            ? 'Error getting username'
                                            : LocalUser.userData.username,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                height: screenHeight * 0.14,
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 48,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: TextField(
                                        controller: nameCon,
                                        cursorColor: Colors.black,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: 'enter username',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 13,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 18, horizontal: 7),
                                          fillColor: Colors.grey[300],
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Divider(
                          color: Colors.black,
                          height: 10,
                          indent: 15,
                          endIndent: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        isEdit == false
                            ? Container(
                                height: screenHeight * 0.12,
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Address Lane',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: LocalUser.userData.address == null
                                          ? Text(
                                              'No address available',
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            )
                                          : Text(
                                              LocalUser.userData.address,
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                height: screenHeight * 0.14,
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Address Lane',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 48,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: TextField(
                                        controller: addCon,
                                        cursorColor: Colors.black,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: 'enter lane',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 13,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 7),
                                          fillColor: Colors.grey[300],
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Divider(
                          color: Colors.black,
                          height: 10,
                          indent: 15,
                          endIndent: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        isEdit == false
                            ? Container(
                                height: screenHeight * 0.12,
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'City',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: LocalUser.userData.city == null
                                          ? Text(
                                              'No city available',
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            )
                                          : Text(LocalUser.userData.city,
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                height: screenHeight * 0.14,
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'City',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 48,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: TextField(
                                        controller: cityCon,
                                        cursorColor: Colors.black,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: 'enter city',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 13,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 7),
                                          fillColor: Colors.grey[300],
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Divider(
                          color: Colors.black,
                          height: 10,
                          indent: 15,
                          endIndent: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        isEdit == false
                            ? Container(
                                height: screenHeight * 0.12,
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Gender',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: LocalUser.userData.gender == null
                                          ? Text(
                                              'No gender available',
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            )
                                          : Text(
                                              LocalUser.userData.gender,
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                height: screenHeight * 0.14,
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Gender',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 48,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: TextField(
                                        controller: genderCon,
                                        cursorColor: Colors.black,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: 'enter gender',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 13,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 7),
                                          fillColor: Colors.grey[300],
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Divider(
                          color: Colors.black,
                          height: 10,
                          indent: 15,
                          endIndent: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        isEdit == false
                            ? Container(
                                height: screenHeight * 0.12,
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Email',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        LocalUser.userData.email,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                height: screenHeight * 0.14,
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Phone Number',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 48,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: TextField(
                                        controller: phoneCon,
                                        cursorColor: Colors.black,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: 'enter number',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 13,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 7),
                                          fillColor: Colors.grey[300],
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        isEdit == false
                            ? Divider(
                                color: Colors.black,
                                height: 10,
                                indent: 15,
                                endIndent: 15,
                              )
                            : Container(),
                        isEdit == false
                            ? SizedBox(
                                height: 10,
                              )
                            : SizedBox(
                                height: 10,
                              ),
                        isEdit == false
                            ? Container(
                                height: screenHeight * 0.12,
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Phone Number',
                                        style: TextStyle(
                                            fontFamily: 'Segoe', fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: LocalUser.userData.phone == null
                                          ? Text(
                                              'No number available',
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            )
                                          : Text(
                                              LocalUser.userData.phone,
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        // SizedBox(
                        //   height: 10,
                        // )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

        // body: Column(
        //   children: [

        //     Container(
        //       color: Colors.green,
        //       width: screenWidth,
        //       height: screenHeight - screenHeight * 0.068,
        //     ),

        // Container(
        //   height: screenHeight * 0.15,
        //   width: screenWidth,
        //   color: Colors.green,
        // ),
        // Divider(
        //   color: Colors.black,
        //   height: 10,
        //   indent: 15,
        //   endIndent: 15,
        //   thickness: 1,
        // ),
        // Container(
        //   height: screenHeight * 0.15,
        //   width: screenWidth,
        //   color: Colors.green,
        // ),
        // Divider(
        //   color: Colors.black,
        //   height: 10,
        //   indent: 15,
        //   endIndent: 15,
        //   thickness: 1,
        // ),
        // Container(
        //   height: screenHeight * 0.15,
        //   width: screenWidth,
        //   color: Colors.green,
        // ),
        // Divider(
        //   color: Colors.black,
        //   height: 10,
        //   indent: 15,
        //   endIndent: 15,
        //   thickness: 1,
        // ),
        // Container(
        //   height: screenHeight * 0.15,
        //   width: screenWidth,
        //   color: Colors.green,
        // ),
        // Divider(
        //   color: Colors.black,
        //   height: 10,
        //   indent: 15,
        //   endIndent: 15,
        //   thickness: 1,
        // ),
        // Container(
        //   height: screenHeight * 0.15,
        //   width: screenWidth,
        //   color: Colors.green,
        // ),
        // Divider(
        //   color: Colors.black,
        //   height: 10,
        //   indent: 15,
        //   endIndent: 15,
        //   thickness: 1,
        // ),
        // Container(
        //   height: screenHeight * 0.15,
        //   width: screenWidth,
        //   color: Colors.green,
        // ),
        // Divider(
        //   color: Colors.black,
        //   height: 10,
        //   indent: 15,
        //   endIndent: 15,
        //   thickness: 1,
        // ),
        //   ],
        // ),
      ),
    );
  }
}
