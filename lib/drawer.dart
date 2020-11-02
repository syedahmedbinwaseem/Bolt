import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home',
                style: TextStyle(fontFamily: 'Segoe', fontSize: 24),
              ),
              SizedBox(height: height * 0.04),
              Text(
                'Profile',
                style: TextStyle(fontFamily: 'Segoe', fontSize: 24),
              ),
              SizedBox(height: height * 0.04),
              Text(
                'My Cart',
                style: TextStyle(fontFamily: 'Segoe', fontSize: 24),
              ),
              SizedBox(height: height * 0.04),
              Text(
                'Favourite',
                style: TextStyle(fontFamily: 'Segoe', fontSize: 24),
              ),
              SizedBox(height: height * 0.04),
              Text(
                'My Orders',
                style: TextStyle(fontFamily: 'Segoe', fontSize: 24),
              ),
              SizedBox(height: height * 0.04),
              Text(
                'Logout',
                style: TextStyle(fontFamily: 'Segoe', fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
