import 'package:flutter/material.dart';

class WAWalkThroughModel {
  String? title;
  String? description;
  String? image;

  WAWalkThroughModel({this.title, this.description, this.image});
}

class WARecentPayeesModel {
  String? image;
  String? name;
  String? number;

  WARecentPayeesModel({this.image, this.name, this.number});
}

class WACardModel {
  String? image;
  String? balance;
  String? cardNumber;
  String? date;
  Color? color;

  WACardModel({this.image, this.balance, this.cardNumber, this.date, this.color});
}

class WAOperationsModel {
  String? image;
  Color? color;
  String? title;
  Widget? widget;
  BackButton? button;

  WAOperationsModel({this.image, this.color, this.title, this.widget, this.button});
}

class WAOpertionListModel {
  String? image;
  Color? color;
  String? title;
  Widget? widget;

  WAOpertionListModel({this.image, this.color, this.title, this.widget});
}

class WATransactionModel {
  String? image;
  Color? color;
  String? title;
  String? name;
  String? time;
  String? balance;

  WATransactionModel({this.image, this.color, this.title, this.name, this.time, this.balance});
}
//
// class WABillPayModel {
//   String? image;
//   String? title;
//   Color? color;
//
//   WABillPayModel({this.image, this.title, this.color});
// }
