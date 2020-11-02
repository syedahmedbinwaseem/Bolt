import 'package:flutter/material.dart';

class VendorDrawer extends StatefulWidget {
  @override
  _VendorDrawerState createState() => _VendorDrawerState();
}

class _VendorDrawerState extends State<VendorDrawer> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      child: Container(
        height: height,
        width: width,
        color: Colors.grey[400],
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
                'Orders',
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
