import 'dart:io';

import 'package:bolt/Vendor/data.dart';
import 'package:bolt/Vendor/vendorDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VendorProduct extends StatefulWidget {
  @override
  _VendorProductState createState() => _VendorProductState();
}

class _VendorProductState extends State<VendorProduct>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final itemsList = List<String>.generate(20, (n) => "List item $n");
  List<Data> allData = List<Data>();
  File _image;
  final picker = ImagePicker();
  final nameCon = TextEditingController();
  final quanCon = TextEditingController();
  final catCon = TextEditingController();
  final priCon = TextEditingController();
  final idCon = TextEditingController();
  int menCount;
  int womenCount;
  int kidCount;
  TabController tabController;
  int tabindex;
  var category = ["Men", "Women", "Kids"];
  var currentItems = null;
  bool saved;
  bool reload = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void abc() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('product')
          .doc('admin1@gmail.com')
          .collection('products')
          .doc('category')
          .collection('men')
          .get();
      QuerySnapshot snap1 = await FirebaseFirestore.instance
          .collection('product')
          .doc('admin1@gmail.com')
          .collection('products')
          .doc('category')
          .collection('women')
          .get();
      QuerySnapshot snap2 = await FirebaseFirestore.instance
          .collection('product')
          .doc('admin1@gmail.com')
          .collection('products')
          .doc('category')
          .collection('kids')
          .get();

      setState(() {
        menCount = snap.docs.length;
        womenCount = snap1.docs.length;
        kidCount = snap2.docs.length;
      });

      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    abc();
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        setState(() {
          tabindex = tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // abc().then((value) {
    //   setState(() {
    //     menCount = value;
    //   });
    // });
    print(menCount);
    var width = MediaQuery.of(context).size.width;
    var h = AppBar().preferredSize.height;
    var padding = MediaQuery.of(context).padding;
    var height = MediaQuery.of(context).size.height - h - padding.top;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Are you sure you want to exit?',
                    style: TextStyle(color: Colors.black, fontFamily: 'Segoe'),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "Cancel",
                        style:
                            TextStyle(color: Colors.black, fontFamily: 'Segoe'),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Exit",
                        style:
                            TextStyle(color: Colors.black, fontFamily: 'Segoe'),
                      ),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                  ],
                );
              });
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.grey[400],
          appBar: AppBar(
            title: Text(
              'Products',
              style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Color.fromRGBO(102, 126, 234, 1),
              controller: tabController,
              tabs: [
                Tab(
                  child: Text(
                    'Men',
                    style: TextStyle(
                        fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Women',
                    style: TextStyle(
                        fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Kids',
                    style: TextStyle(
                        fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            elevation: 0,
            backgroundColor: Colors.grey[400],
            leading: GestureDetector(
                onTap: () {
                  scaffoldKey.currentState.openDrawer();
                },
                child: ImageIcon(AssetImage('assets/icons/menubar.png'))),
          ),
          drawer: VendorDrawer(),
          body: TabBarView(
            controller: tabController,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SmartRefresher(
                  controller: _refreshController,
                  physics: BouncingScrollPhysics(),
                  header: WaterDropHeader(
                    waterDropColor: Color.fromRGBO(102, 126, 234, 1),
                    complete: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.done,
                            color: Color.fromRGBO(102, 126, 234, 1),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Refresh Completed",
                            style: TextStyle(
                              fontFamily: 'Segoe',
                              color: Color.fromRGBO(102, 126, 234, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onRefresh: () {
                    abc();
                  },
                  child: ListView.builder(
                      itemCount: menCount,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 5, right: 5),
                            child: GestureDetector(
                              onLongPress: () {
                                print('long press');
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: womenCount,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 5, right: 5),
                          child: GestureDetector(
                            onLongPress: () {
                              print('long press');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: kidCount,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 5, right: 5),
                          child: GestureDetector(
                            onLongPress: () {
                              print('long press');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
              )
            ],
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Stack(
                      children: [
                        Dialog(
                          insetPadding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: height * 0.8,
                                width: width * 0.9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Add product',
                                      style: TextStyle(
                                          fontFamily: 'Segoe',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(height: 10),
                                    Theme(
                                      data: new ThemeData(
                                        primaryColor: Colors.grey[700],
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(fontFamily: 'Segoe'),
                                        controller: idCon,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: Colors.grey[700],
                                        decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Enter ID',
                                            hintStyle: TextStyle(
                                                fontFamily: 'Segoe',
                                                fontSize: 12)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Theme(
                                      data: new ThemeData(
                                        primaryColor: Colors.grey[700],
                                      ),
                                      child: TextField(
                                        style: TextStyle(fontFamily: 'Segoe'),
                                        controller: nameCon,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: Colors.grey[700],
                                        decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Enter Name',
                                            hintStyle: TextStyle(
                                                fontFamily: 'Segoe',
                                                fontSize: 12)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Theme(
                                      data: new ThemeData(
                                        primaryColor: Colors.grey[700],
                                      ),
                                      child: TextField(
                                        style: TextStyle(fontFamily: 'Segoe'),
                                        controller: quanCon,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.grey[700],
                                        decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Enter quantity',
                                            hintStyle: TextStyle(
                                                fontFamily: 'Segoe',
                                                fontSize: 12)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Theme(
                                      data: new ThemeData(
                                        primaryColor: Colors.grey[700],
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text('Select category',
                                              style: TextStyle(
                                                fontFamily: 'Segoe',
                                                fontSize: 13,
                                              )),
                                          style: TextStyle(
                                              fontFamily: 'Segoe',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontSize: 15),
                                          items: category
                                              .map((String dropDownStringItem) {
                                            return DropdownMenuItem<String>(
                                              value: dropDownStringItem,
                                              child: Text(dropDownStringItem),
                                            );
                                          }).toList(),
                                          onChanged: (String newValueSelected) {
                                            setState(() {
                                              this.currentItems =
                                                  newValueSelected;
                                            });
                                          },
                                          value: currentItems,
                                          isExpanded: true,
                                        ),
                                      ),
                                      // child: TextField(
                                      //   controller: catCon,
                                      //   textInputAction: TextInputAction.next,
                                      //   cursorColor: Colors.grey[700],
                                      //   decoration: InputDecoration(
                                      //       hintText: 'Enter Category',
                                      //       hintStyle: TextStyle(
                                      //           fontFamily: 'Segoe', fontSize: 12)),
                                      // ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Theme(
                                      data: new ThemeData(
                                        primaryColor: Colors.grey[700],
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(fontFamily: 'Segoe'),
                                        controller: priCon,
                                        cursorColor: Colors.grey[700],
                                        decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Enter price',
                                            hintStyle: TextStyle(
                                                fontFamily: 'Segoe',
                                                fontSize: 12)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        getImage();
                                      },
                                      child: Container(
                                        height: 40,
                                        width: width * 0.9,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: Colors.white70,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                              ),
                                            ]),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        'Select primary image',
                                                        style: TextStyle(
                                                            fontFamily: 'Segoe',
                                                            fontSize: 13),
                                                      ))),
                                            ),
                                            Container(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(Icons.image)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          padding: EdgeInsets.only(right: 10),
                                          height: 40,
                                          width: width * 0.9,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  nameCon.clear();
                                                  quanCon.clear();
                                                  priCon.clear();
                                                  catCon.clear();
                                                  idCon.clear();
                                                  setState(() {
                                                    currentItems = null;
                                                  });
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    saved = false;
                                                  });
                                                  if (idCon.text == '') {
                                                    Fluttertoast.showToast(
                                                      msg: "ID cannot be empty",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 3,
                                                      backgroundColor:
                                                          Colors.red[400],
                                                      textColor: Colors.white,
                                                      fontSize: 15,
                                                    );
                                                    setState(() {
                                                      saved = true;
                                                    });
                                                  } else if (nameCon.text ==
                                                      '') {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Name cannot be empty",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 3,
                                                      backgroundColor:
                                                          Colors.red[400],
                                                      textColor: Colors.white,
                                                      fontSize: 15,
                                                    );
                                                    setState(() {
                                                      saved = true;
                                                    });
                                                  } else if (quanCon.text ==
                                                      '') {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Quantity cannot be empty",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 3,
                                                      backgroundColor:
                                                          Colors.red[400],
                                                      textColor: Colors.white,
                                                      fontSize: 15,
                                                    );
                                                    setState(() {
                                                      saved = true;
                                                    });
                                                  } else if (currentItems ==
                                                      null) {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Please select a category",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 3,
                                                      backgroundColor:
                                                          Colors.red[400],
                                                      textColor: Colors.white,
                                                      fontSize: 15,
                                                    );
                                                    setState(() {
                                                      saved = true;
                                                    });
                                                  } else if (priCon.text ==
                                                      '') {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Price cannot be empty",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 3,
                                                      backgroundColor:
                                                          Colors.red[400],
                                                      textColor: Colors.white,
                                                      fontSize: 15,
                                                    );
                                                    setState(() {
                                                      saved = true;
                                                    });
                                                  } else {
                                                    print(
                                                        "Text:" + nameCon.text);
                                                    bool exit;

                                                    User user = FirebaseAuth
                                                        .instance.currentUser;
                                                    if (user != null) {
                                                      try {
                                                        QuerySnapshot snap =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'product')
                                                                .doc(user.email)
                                                                .collection(
                                                                    'products')
                                                                .doc('category')
                                                                .collection(
                                                                    currentItems
                                                                        .toString()
                                                                        .toLowerCase())
                                                                .get();
                                                        print(snap.docs.length);
                                                        int checkAlreadyExist =
                                                            0;
                                                        snap.docs
                                                            .forEach((doc) {
                                                          if (doc.id ==
                                                              idCon.text) {
                                                            checkAlreadyExist++;
                                                          } else {}
                                                        });
                                                        if (checkAlreadyExist ==
                                                            0) {
                                                          try {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'product')
                                                                .doc(
                                                                    'admin1@gmail.com')
                                                                .collection(
                                                                    'products')
                                                                .doc('category')
                                                                .collection(
                                                                    currentItems
                                                                        .toString()
                                                                        .toLowerCase())
                                                                .doc(idCon.text)
                                                                .set({
                                                              'name':
                                                                  nameCon.text,
                                                              'quantity':
                                                                  quanCon.text,
                                                              'price':
                                                                  priCon.text
                                                            });
                                                            setState(() {
                                                              saved = true;
                                                            });
                                                            Fluttertoast
                                                                .showToast(
                                                              msg:
                                                                  "Product added successfully",
                                                              toastLength: Toast
                                                                  .LENGTH_LONG,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  3,
                                                              backgroundColor:
                                                                  Colors.green,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                            );

                                                            exit = true;
                                                          } catch (e) {
                                                            print("Ex: " + e);
                                                            exit = false;
                                                          }
                                                        } else {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Product with this ID already exist",
                                                            toastLength: Toast
                                                                .LENGTH_LONG,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                3,
                                                            backgroundColor:
                                                                Colors.red[400],
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 15,
                                                          );
                                                          setState(() {
                                                            saved = true;
                                                          });
                                                          exit = false;
                                                        }
                                                      } catch (e) {
                                                        print(
                                                            "Exception: " + e);
                                                        exit = false;
                                                        setState(() {
                                                          saved = true;
                                                        });
                                                      }
                                                    }

                                                    // setState(() {
                                                    //   allData.add(Data(
                                                    //       name: nameCon.text,
                                                    //       category: currentItems,
                                                    //       id: int.parse(idCon.text),
                                                    //       price: priCon.text,
                                                    //       image: _image,
                                                    //       quantity: int.parse(
                                                    //           quanCon.text)));
                                                    // });
                                                    if (exit == false) {
                                                      return null;
                                                    } else {
                                                      Navigator.pop(context);
                                                    }
                                                    nameCon.clear();
                                                    quanCon.clear();
                                                    priCon.clear();
                                                    catCon.clear();
                                                    idCon.clear();
                                                  }
                                                },
                                                child: Text(
                                                  'Add',
                                                  style: TextStyle(
                                                      fontFamily: 'Segoe',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green),
                                                ),
                                              )
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
                        saved == null
                            ? Container()
                            : saved == false
                                ? Center(child: CircularProgressIndicator())
                                : Container()
                      ],
                    );
                  });
                },
              ).then((value) {
                nameCon.clear();
                quanCon.clear();
                priCon.clear();
                catCon.clear();
                idCon.clear();
                setState(() {
                  currentItems = null;
                });
              });
            },
            backgroundColor: Color.fromRGBO(102, 126, 234, 1),
            child: Icon(Icons.add),
            heroTag: Text('Add Product'),
          ),
        ),
      ),
    );
  }
}

Widget deleteDismiss() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              fontFamily: 'Segoe',
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}

Widget editDismiss() {
  return Container(
    color: Colors.green,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Edit",
            style: TextStyle(
              fontFamily: 'Segoe',
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}
