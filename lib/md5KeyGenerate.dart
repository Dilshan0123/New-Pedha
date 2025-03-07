import 'dart:convert';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

var loginKeyController = Get.put(appController());

String generateMD5Key(String input) {
  final bytes = utf8.encode(input);
  final md5Hash = md5.convert(bytes);
  return md5Hash.toString();
}

String txnids(String usid, String pass) {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String mytxn = formattedDate+usid+pass+formattedDate;
  final md5Key = generateMD5Key(mytxn);
  loginKeyController.encryptedKey = md5Key;
  return mytxn;
}

String txnTPins(String pin) {
  // String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String mytxn = pin;
  final md5Key = generateMD5Key(mytxn);
  loginKeyController.txnPins = md5Key;
  return mytxn;
}

String encodeToBase64(String data) {
  List<int> bytes = utf8.encode(data);
  return base64.encode(bytes);
}
