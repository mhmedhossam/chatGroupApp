import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color(0xff28475E);
const kMessageCollection = "messages";
bool enablePass = true;
String formatDate(DateTime Date) {
  final format = DateFormat("jm");
  final formattedTime = format.format(Date);
  return formattedTime;
}
