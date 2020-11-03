import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int quantity = 0;
  void addQuantity() {
    ++quantity;
  }

  void removeQuantity() {
    if (quantity > 0) {
      --quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var h = AppBar().preferredSize.height;
    var padding = MediaQuery.of(context).padding;
    var screenHeight = MediaQuery.of(context).size.height - h - padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: screenHeight * 0.1,
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: screenHeight * 0.075,
                        fontFamily: 'Segoe',
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.89,
                  width: screenWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        _buildCartProduct(
                            AssetImage('assets/images/womant3.jpg'),
                            'Woman T-Shirt',
                            'LOTO.LTD',
                            '\$34.00'),
                        SizedBox(
                          height: screenHeight * 0.025,
                        ),
                        _buildCartProduct(
                            AssetImage('assets/images/womant2.jpg'),
                            'Female T-Short',
                            'Bata',
                            '\$40.00'),
                        SizedBox(
                          height: screenHeight * 0.025,
                        ),
                        _buildCartProduct(
                          AssetImage('assets/images/mant.jpg'),
                          'Shirt',
                          'Next',
                          '\$64.00',
                        ),
                        SizedBox(
                          height: screenHeight * 0.025,
                        ),
                        _buildCartProduct(
                            AssetImage('assets/images/womant.jpg'),
                            'Woman Shirt',
                            'plus point',
                            '\$33.00'),
                        SizedBox(
                          height: screenHeight * 0.025,
                        ),
                        _buildCartProduct(
                            AssetImage('assets/images/womant3.jpg'),
                            '',
                            '',
                            ''),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.85,
            left: screenWidth * 0.05,
            child: Container(
              height: screenHeight * 0.1,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff667EEA),
                    Color(0xff64B6FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Segoe',
                    fontSize: screenHeight * 0.045,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCartProduct(image, text1, text2, text3) {
    var screenWidth = MediaQuery.of(context).size.width;
    var h = AppBar().preferredSize.height;
    var padding = MediaQuery.of(context).padding;
    var screenHeight = MediaQuery.of(context).size.height - h - padding.top;
    return Container(
      height: screenHeight * 0.2,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            spreadRadius: 1,
            blurRadius: 2,
          )
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: screenHeight * 0.025,
            left: screenHeight * 0.025,
            child: Image(
              image: image,
              height: screenHeight * 0.15,
              width: screenWidth * 0.18,
            ),
          ),
          Positioned(
            top: screenHeight * 0.012,
            left: screenWidth * 0.3,
            child: Text(
              text1,
              style: TextStyle(
                fontSize: screenHeight * 0.032,
                fontWeight: FontWeight.w500,
                fontFamily: 'Segoe',
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.053,
            left: screenWidth * 0.3,
            child: Text(
              text2,
              style: TextStyle(
                fontSize: screenHeight * 0.025,
                color: Colors.grey[500],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.08,
            left: screenWidth * 0.3,
            child: Text(
              text3,
              style: TextStyle(
                fontSize: screenHeight * 0.029,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.135,
            left: screenWidth * 0.3,
            child: Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.4,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Icon(
                      Icons.remove,
                      size: screenHeight * 0.03,
                    ),
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(fontSize: screenHeight * 0.03),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Icon(
                      Icons.add,
                      size: screenHeight * 0.03,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.01,
            left: screenWidth * 0.8,
            child: Icon(
              Icons.close,
              size: screenHeight * 0.055,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
