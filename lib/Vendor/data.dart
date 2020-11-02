import 'dart:io';

import 'package:flutter/cupertino.dart';

class Data {
  int id;
  String name;
  int quantity;
  String category;
  File image;
  String price;
  Data(
      {this.name,
      this.quantity,
      this.category,
      this.image,
      this.price,
      this.id});
}
