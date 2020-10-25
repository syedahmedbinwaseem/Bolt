import 'dart:ui';

import 'package:bolt/productScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: ImageIcon(AssetImage('assets/icons/menubar.png')),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ImageIcon(
              AssetImage('assets/icons/filter.png'),
              color: Colors.black,
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.003,
                ),
                _buildSearch(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                _buildRow('Categories'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      _buildCategory('Woman',
                          AssetImage('assets/images/woman.jpg'), Colors.blue),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      _buildCategory('Man', AssetImage('assets/images/man.jpg'),
                          Colors.red),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      _buildCategory(
                        'Kids',
                        AssetImage('assets/images/kids.jpg'),
                        Colors.lightGreen,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                _buildRow('Featured'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.265,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductScreen()));
                        },
                        child: _buildFeatured(
                          '\$ 55',
                          'Women T-Shirt',
                          AssetImage('assets/images/womant.jpg'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      _buildFeatured(
                        '\$ 35',
                        'Man T-Shirt',
                        AssetImage('assets/images/mant.jpg'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      _buildFeatured(
                        '\$ 50',
                        'Women T-Shirt',
                        AssetImage('assets/images/womant2.jpg'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.001,
                ),
                _buildRow('Best Sell'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.265,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      _buildFeatured(
                        '\$ 45',
                        'Women T-Shirt',
                        AssetImage('assets/images/womant3.jpg'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      _buildFeatured(
                        '\$ 50',
                        'Man T-Shirt',
                        AssetImage('assets/images/mant2.jpg'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      _buildFeatured(
                        '\$ 50',
                        'Women T-Shirt',
                        AssetImage('assets/images/womant2.jpg'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          selectionHeightStyle: BoxHeightStyle.strut,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 18),
            hintText: 'Search your Product',
            hintStyle:
                TextStyle(fontSize: 15, height: 0.3, fontFamily: "Segoe"),
            prefixIcon: Icon(Icons.search),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'Segoe'),
          ),
          Text(
            'See all',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Segoe'),
          )
        ],
      ),
    );
  }

  Widget _buildCategory(text, image, color) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: color.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Segoe',
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFeatured(price, text, image) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.26,
          width: MediaQuery.of(context).size.width * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.185,
              ),
              Text(
                price,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Segoe',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                text,
                style: TextStyle(fontSize: 15, fontFamily: 'Segoe'),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.18,
          width: MediaQuery.of(context).size.width * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
