import 'dart:io';

import 'package:bolt/Vendor/data.dart';
import 'package:bolt/Vendor/vendorDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class VendorProduct extends StatefulWidget {
  @override
  _VendorProductState createState() => _VendorProductState();
}

class _VendorProductState extends State<VendorProduct> {
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
  var category = ["Men", "Women", "Kids"];
  var currentItems = null;

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

  @override
  Widget build(BuildContext context) {
    print(currentItems);
    var width = MediaQuery.of(context).size.width;
    var h = AppBar().preferredSize.height;
    var padding = MediaQuery.of(context).padding;
    var height = MediaQuery.of(context).size.height - h - padding.top;
    print(allData.length);
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
            elevation: 0,
            backgroundColor: Colors.grey[400],
            leading: GestureDetector(
                onTap: () {
                  scaffoldKey.currentState.openDrawer();
                },
                child: ImageIcon(AssetImage('assets/icons/menubar.png'))),
          ),
          drawer: VendorDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: width * 0.046),
                  height: height * 0.08,
                  width: width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Products',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: height * 0.92,
                  width: width,
                  child: ListView.builder(
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        final item = allData[index].name;
                        return Dismissible(
                          key: Key(item),
                          background: editDismiss(),
                          secondaryBackground: deleteDismiss(),
                          // ignore: missing_return
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              final bool res = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(
                                        "Are you sure you want to delete ${itemsList[index]}?",
                                        style: TextStyle(fontFamily: 'Segoe'),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Segoe '),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Segoe',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              allData.removeAt(index);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              return res;
                            } else {
                              setState(() {
                                allData[index].name = 'Pant';
                              });
                            }
                          },
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(left: width * 0.046),
                              height: 80,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 30,
                                    backgroundImage:
                                        FileImage(allData[index].image),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '${allData[index].name}',
                                        style: TextStyle(fontFamily: 'Segoe'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '\$${allData[index].price}',
                                        style: TextStyle(fontFamily: 'Segoe'),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return Dialog(
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
                                        hint: Text('select category',
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
                                                alignment: Alignment.centerLeft,
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
                                              onTap: () {
                                                print(idCon.text +
                                                    nameCon.text +
                                                    quanCon.text +
                                                    priCon.text +
                                                    currentItems);
                                                setState(() {
                                                  allData.add(Data(
                                                      name: nameCon.text,
                                                      category: currentItems,
                                                      id: int.parse(idCon.text),
                                                      price: priCon.text,
                                                      image: _image,
                                                      quantity: int.parse(
                                                          quanCon.text)));
                                                });
                                                Navigator.pop(context);
                                                nameCon.clear();
                                                quanCon.clear();
                                                priCon.clear();
                                                catCon.clear();
                                                idCon.clear();
                                              },
                                              child: Text(
                                                'Add',
                                                style: TextStyle(
                                                    fontFamily: 'Segoe',
                                                    fontWeight: FontWeight.bold,
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
                      );
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
