import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.west,
              color: Colors.grey[700],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ImageIcon(
                AssetImage(
                  'assets/images/search.png',
                ),
                size: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: width * 0.0416, right: width * 0.0416),
                height: height * 0.25,
                width: width,
                child: Image(
                  image: AssetImage('assets/images/turtle.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Container(
                padding: EdgeInsets.only(left: width * 0.0416),
                child: Text(
                  'Black turteneck top',
                  style:
                      TextStyle(fontFamily: "Segoe", fontSize: height * 0.033),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Container(
                padding: EdgeInsets.only(left: width * 0.0416),
                child: RichText(
                  textDirection: TextDirection.ltr,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '\$42   ',
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Segoe',
                              fontSize: height * 0.033)),
                      TextSpan(
                        text: '\$62',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: height * 0.024,
                            fontFamily: 'Segoe',
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
