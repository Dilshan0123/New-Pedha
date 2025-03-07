

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

class demo4 extends StatefulWidget {
  const demo4({super.key});

  @override
  State<demo4> createState() => _demo4State();
}

class _demo4State extends State<demo4> {

  String calculateMD5(String input) {
    var bytes = utf8.encode(input); // Encode the input string as bytes
    var md5Hash = md5.convert(bytes); // Calculate the MD5 hash
    return md5Hash.toString(); // Convert the hash to a string
  }

  // void main() {
  //   var usid = "hjgedyu";
  //   String mytxn = usid + DateTime.now().toLocal().toString() ;
  //
  //   String md5Hash = calculateMD5(mytxn);
  //   print("MD5 Hash: $md5Hash");
  // }

  String generateRandomKey(int length) {
    final random = Random.secure();
    const values = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final List<int> codes = List<int>.generate(length, (i) => values.codeUnitAt(random.nextInt(values.length)));
    return String.fromCharCodes(codes);
  }
  void main() {
    final key = generateRandomKey(32); // Change 32 to the desired length
    print(key);
  }

  // String txnids(String usid) {
  //   String mytxn = usid + DateTime.now().toLocal().toString();
  //   return mytxn;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            child: const Text("hfjg"),
            onPressed: (){
              main();
            },
          ),
        ),
      ),
    );
  }
}
