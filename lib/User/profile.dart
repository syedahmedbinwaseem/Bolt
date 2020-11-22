import 'package:bolt/User/localUser.dart';
import 'package:bolt/Utils/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isEdit = false;
  final nameCon = TextEditingController();
  final addCon = TextEditingController();
  final cityCon = TextEditingController();
  final genderCon = TextEditingController();
  final phoneCon = TextEditingController();
  final _mobileFormatter = PhoneNumberTextInputFormatter();
  var genders = ["Male", "Female"];
  var currentItems = null;

  @override
  void initState() {
    super.initState();
    nameCon.text = LocalUser.userData.username;
    LocalUser.userData.address == null
        ? addCon.text = ''
        : addCon.text = LocalUser.userData.address;
    LocalUser.userData.gender == null
        ? genderCon.text = ''
        : addCon.text = LocalUser.userData.gender;
    LocalUser.userData.phone == null
        ? phoneCon.text = ''
        : addCon.text = LocalUser.userData.phone;
    LocalUser.userData.city == null
        ? cityCon.text = ''
        : addCon.text = LocalUser.userData.city;

    // LocalUser.userData.gender == null
    //     ? currentItems = null
    //     : currentItems = LocalUser.userData.gender;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        drawer: DrawerScreen(),
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                scaffoldKey.currentState.openDrawer();
              },
              child: ImageIcon(AssetImage('assets/icons/menubar.png'))),
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
                                      color: Colors.black, fontFamily: 'Segoe'),
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
                                        .doc(LocalUser.userData.email)
                                        .update({
                                      'city': cityCon.text,
                                      'phone': phoneCon.text,
                                      'address': addCon.text,
                                      'gender': currentItems,
                                    });
                                    print('saved');
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
                        },
                      );
                    },
                  ),
            isEdit == false
                ? Container()
                : IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isEdit = !isEdit;
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
                      color: Colors.black,
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
                                        LocalUser.userData.username == ''
                                            ? 'Error getting username'
                                            : LocalUser.userData.username,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
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
                                        textInputAction: TextInputAction.next,
                                        controller: nameCon,
                                        cursorColor: Colors.black,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: 'enter username',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 13,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 7),
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
                                      child: LocalUser.userData.address == ''
                                          ? Text(
                                              'No address available',
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle: FontStyle.italic),
                                            )
                                          : SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                LocalUser.userData.address,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
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
                                        textInputAction: TextInputAction.next,
                                        controller: addCon,
                                        cursorColor: Colors.black,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: 'enter lane',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 13,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 7),
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
                                      child: LocalUser.userData.city == ''
                                          ? Text(
                                              'No city available',
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle: FontStyle.italic),
                                            )
                                          : Text(LocalUser.userData.city,
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
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
                                        textInputAction: TextInputAction.next,
                                        controller: cityCon,
                                        cursorColor: Colors.black,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: 'enter city',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 13,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 7),
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
                                      child: LocalUser.userData.gender == '' ||
                                              LocalUser.userData == null
                                          ? Text(
                                              'No gender available',
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle: FontStyle.italic),
                                            )
                                          : Text(
                                              LocalUser.userData.gender,
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
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
                                          EdgeInsets.only(left: 15, right: 10),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text('select gender',
                                              style: TextStyle(
                                                fontFamily: 'Segoe',
                                                fontSize: 13,
                                              )),
                                          value: currentItems,
                                          isExpanded: true,
                                          style: TextStyle(
                                              fontFamily: 'Segoe',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontSize: 16),
                                          items: genders
                                              .map((String dropDownStringItem) {
                                            return DropdownMenuItem<String>(
                                              value: dropDownStringItem,
                                              child: Text(dropDownStringItem),
                                            );
                                          }).toList(),
                                          onChanged: (String newValueSelected) {
                                            setState(() {
                                              LocalUser.userData.gender =
                                                  newValueSelected;
                                              this.currentItems =
                                                  newValueSelected;
                                            });
                                          },
                                        ),
                                      ),
                                      // child: TextField(
                                      //   controller: genderCon,
                                      //   cursorColor: Colors.black,
                                      //   style: TextStyle(
                                      //       fontFamily: 'Segoe',
                                      //       fontWeight: FontWeight.w600,
                                      //       fontSize: 16),
                                      //   decoration: InputDecoration(
                                      //     hintText: 'enter gender',
                                      //     hintStyle: TextStyle(
                                      //       fontFamily: 'Segoe',
                                      //       fontSize: 13,
                                      //     ),
                                      //     contentPadding: EdgeInsets.symmetric(
                                      //         vertical: 0, horizontal: 7),
                                      //     fillColor: Colors.grey[300],
                                      //     focusedBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: Colors.grey[300]),
                                      //       borderRadius:
                                      //           BorderRadius.circular(16),
                                      //     ),
                                      //     enabledBorder: UnderlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: Colors.grey[300]),
                                      //       borderRadius:
                                      //           BorderRadius.circular(16),
                                      //     ),
                                      //     filled: true,
                                      //   ),
                                      // ),
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
                                            fontWeight: FontWeight.w400),
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
                                        cursorColor: Colors.black,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          _mobileFormatter,
                                          LengthLimitingTextInputFormatter(12)
                                        ],
                                        keyboardType:
                                            TextInputType.numberWithOptions(),
                                        controller: phoneCon,
                                        // cursorColor: Colors.black,
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: 'enter number',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 13,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 7),
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
                                      child: LocalUser.userData.phone == ''
                                          ? Text(
                                              'No number available',
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle: FontStyle.italic),
                                            )
                                          : Text(
                                              LocalUser.userData.phone,
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
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
      ),
    );
  }
}

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 5) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 4) + '-');
    }
    // if (newTextLength >= 7) {
    //   newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
    //   if (newValue.selection.end >= 6) selectionIndex++;
    // }
    // if (newTextLength >= 11) {
    //   newText.write(newValue.text.substring(6, usedSubstringIndex = 10));
    //   if (newValue.selection.end >= 10) selectionIndex++;
    // }
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: newText.length),
    );
  }
}
