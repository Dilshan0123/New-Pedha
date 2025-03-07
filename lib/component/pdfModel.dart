//
//
// import 'dart:html';
//
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart'as pdf;
//
// class PdfDocument{
//   static Future<File> generate(String text)async{
//     final pdf = Document();
//
//     return saveDocument(name: 'my_examplae.pdf', pdf: pdf);
//   }
// }
//
// class pdfApi{
//   static Future<File>saveDocument({
//   required String name,
//     required Document pdf,
// })async{
//     final bytes = await pdf.save();
//
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/$name');
//
//     await file.writeAsbytes(bytes);
//     return file;
//   }
// }