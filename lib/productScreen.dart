import 'package:bolt/drawer.dart';
import 'package:bolt/testscreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool stap = false;
  bool mtap = false;
  bool ltap = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var color = Color.fromRGBO(102, 126, 234, 1);

    TextStyle style1 =
        TextStyle(fontFamily: 'Segoe', fontSize: 17, color: Colors.white);
    TextStyle defaultStyle = TextStyle(
        color: Colors.black, fontFamily: 'Segoe', fontSize: height * 0.020);
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
        drawer: DrawerScreen(),
        body: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: width * 0.0416,
                  ),
                  Container(
                    height: 200,
                    width: width - width * 0.06,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Swiper(
                        curve: Curves.ease,
                        itemBuilder: (BuildContext context, int index) {
                          return new Image.asset(
                            'assets/images/turtle3.jpg',
                            fit: BoxFit.cover,
                          );
                        },
                        itemCount: 3,
                        // pagination: new SwiperPagination(
                        //     alignment: Alignment.bottomLeft),
                        pagination: new SwiperPagination(
                            alignment: Alignment.bottomLeft),
                      ),
                    ),
                  )
                ],
              ),
              // Container(
              //   padding: EdgeInsets.only(
              //       left: width * 0.0416, right: height * 0.017),
              //   color: Colors.green,
              //   width: width
              //   height: 200,
              // child: CarouselSlider(
              //   options: CarouselOptions(
              //     enlargeCenterPage: true,
              //     enlargeStrategy: CenterPageEnlargeStrategy.scale,
              //     enableInfiniteScroll: false,
              //     height: height * 0.25,
              //   ),
              //   items: [
              //     Container(
              //         // padding: EdgeInsets.only(right: 10, left: 10),
              //         // height: height * 0.23,
              //         width: width,
              //         child: Image.asset(
              //           'assets/images/turtle.jpg',
              //           fit: BoxFit.cover,
              //         )),
              //     Container(
              //       // padding: EdgeInsets.all(10),
              //       // height: height * 0.23,
              //       width: width,
              //       child: Image.asset(
              //         'assets/images/turtle2.jpg',
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //     Container(
              //       // padding: EdgeInsets.all(10),
              //       // height: 200,
              //       width: width,
              //       child: Image.asset(
              //         'assets/images/turtle3.jpg',
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ],
              // ),
              // ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(left: width * 0.0416),
                child: Text(
                  'Turteneck top',
                  style:
                      TextStyle(fontFamily: "Segoe", fontSize: height * 0.033),
                ),
              ),
              SizedBox(
                height: height * 0.01,
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
                              color: Color.fromRGBO(102, 126, 234, 1),
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
              SizedBox(
                height: height * 0.01,
              ),
              Divider(
                height: 0,
                endIndent: 0,
                indent: 0,
              ),
              Container(
                padding: EdgeInsets.only(left: width * 0.0416),
                height: height * 0.06,
                width: width,
                child: Row(
                  children: [
                    Container(
                      width: width * 0.17,
                      height: (height * 0.06) - 14,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(102, 126, 234, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          '4.5',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Segoe',
                              fontSize: height * 0.02),
                        ),
                      ),
                    ),
                    SizedBox(width: height * 0.017),
                    Text(
                      'Very Good',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: height * 0.0237,
                          color: Colors.black),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.only(right: height * 0.017),
                          child: Text(
                            '49 reviews',
                            style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: height * 0.0185,
                                color: Color.fromRGBO(102, 126, 234, 1)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 0,
                endIndent: 0,
                indent: 0,
              ),
              Container(
                height: height * 0.2,
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.03,
                      padding: EdgeInsets.only(
                          left: width * 0.0416, top: height * 0.006),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: width,
                      height: (height * 0.2) - (height * 0.03),
                      padding: EdgeInsets.only(
                          left: width * 0.0416,
                          top: height * 0.004,
                          right: width * 0.01,
                          bottom: height * 0.006),
                      child: SingleChildScrollView(
                        child: ExpandableText(
                          'Lorem ipsum dolor sit amet, consecte Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer dictum facilisis arcu. Phasellus sodales varius mattis. Sed a diam a erat fermentum vulputate. Nullam pharetra, turpis mollis pulvinar gravida, ex sapien blandit eros, ullamcorper tempus lectus neque ut orci. Donec non tincidunt mauris, sed condimentum massa. Quisque et sollicituditur adipiscing elit. Integer dictum facilisis arcu. Phasellus sodales varius mattis. Sed a diam a erat fermentum vulputate. Nullam pharetra, turpis mollis pulvinar gravida, ex sapien blandit eros, ullamcorper tempus lectus neque ut orci. Donec non tincidunt mauris, sed condimentum  Lorem ipsum dolor sit amet, consecte Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer dictum facilisis arcu. Phasellus sodales varius mattis. Sed a diam a erat fermentum vulputate. Nullam pharetra, turpis mollis pulvinar gravida, ex sapien blandit eros, ullamcorper tempus lectus neque ut orci. Donec non tincidunt mauris, sed condimentum massa. Quisque et sollicituditur adipiscing elit. Integer dictum facilisis arcu. Phasellus sodales varius mattis. Sed a diam a erat fermentum vulputate. Nullam pharetra, turpis mollis pulvinar gravida, ex sapien blandit eros, ullamcorper tempus lectus neque ut orci. Donec non tincidunt mauris, sed condimentumassa. Quisque et sollicitudi ',
                          trimLines: 9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
                height: 0,
              ),
              Container(
                height: height * 0.06,
                child: Center(
                  child: Text(
                    'Select Size',
                    style: TextStyle(
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.048),
                  ),
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
                height: 0,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: height * 0.088,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              stap = true;
                              mtap = false;
                              ltap = false;
                            });
                          },
                          child: Container(
                            height: height * 0.059,
                            width: height * 0.059,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: stap == true
                                        ? Color.fromRGBO(102, 126, 234, 1)
                                        : Colors.transparent,
                                    offset: stap == true
                                        ? Offset(0, 6)
                                        : Offset(0, 0),
                                    blurRadius: stap == true ? 3 : 0,
                                    spreadRadius: stap == true ? -4 : 0)
                              ],
                              color: stap == true
                                  ? Color.fromRGBO(102, 126, 234, 1)
                                  : Colors.grey[300],
                            ),
                            child: Center(
                                child: Text(
                              'S',
                              style: defaultStyle,
                            )),
                          ),
                        ),
                        SizedBox(width: width * 0.036),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              mtap = true;
                              stap = false;
                              ltap = false;
                            });
                          },
                          child: Container(
                            height: height * 0.059,
                            width: height * 0.059,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: mtap == true
                                        ? Color.fromRGBO(102, 126, 234, 1)
                                        : Colors.transparent,
                                    offset: mtap == true
                                        ? Offset(0, 6)
                                        : Offset(0, 0),
                                    blurRadius: mtap == true ? 3 : 0,
                                    spreadRadius: mtap == true ? -4 : 0)
                              ],
                              color: mtap == true
                                  ? Color.fromRGBO(102, 126, 234, 1)
                                  : Colors.grey[300],
                            ),
                            child: Center(
                                child: Text(
                              'M',
                              style: defaultStyle,
                            )),
                          ),
                        ),
                        SizedBox(width: width * 0.036),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ltap = true;
                              stap = false;
                              mtap = false;
                            });
                          },
                          child: Container(
                            height: height * 0.059,
                            width: height * 0.059,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: ltap == true
                                        ? Color.fromRGBO(102, 126, 234, 1)
                                        : Colors.transparent,
                                    offset: ltap == true
                                        ? Offset(0, 6)
                                        : Offset(0, 0),
                                    blurRadius: ltap == true ? 3 : 0,
                                    spreadRadius: ltap == true ? -4 : 0)
                              ],
                              color: ltap == true
                                  ? Color.fromRGBO(102, 126, 234, 1)
                                  : Colors.grey[300],
                            ),
                            child:
                                Center(child: Text('L', style: defaultStyle)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: height * 0.08,
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Test()));
                            },
                            child: Container(
                              color: Colors.grey[400],
                              child: Center(
                                child: Text(
                                  'ADD TO CART',
                                  style: TextStyle(
                                      fontFamily: 'Segoe',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Color.fromRGBO(102, 126, 234, 1),
                            child: Center(
                              child: Text(
                                'BUY NOW',
                                style: TextStyle(
                                    fontFamily: 'Segoe',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key key,
    this.trimLines = 2,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final colorClickableText = Colors.blue;
    final widgetColor = Colors.black;
    TextSpan link = TextSpan(
        text: _readMore ? "  More" : "  Less",
        style: TextStyle(
          color: Color.fromRGBO(102, 126, 234, 1),
          fontFamily: 'Segoe',
          fontWeight: FontWeight.bold,
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text =
            TextSpan(text: widget.text, style: TextStyle(fontFamily: 'Segoe'));
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: TextStyle(
              color: widgetColor,
              fontFamily: 'Segoe',
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
              text: widget.text, style: TextStyle(fontFamily: 'Segoe'));
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
