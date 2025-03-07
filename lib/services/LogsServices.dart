//
//
// import 'dart:io';
//
// import 'package:logger/logger.dart';
// import 'package:path_provider/path_provider.dart';
//
// class LogUtil {
//   static final Logger _logger = Logger();
//
//   // Log to console
//   static void logToConsole(String message) {
//     _logger.i(message); // Info level log
//   }
//
//
//   // Log to file
//   static Future<void> logToFile(String logMessage) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final logFile = File('${directory.path}/api_logs.txt');
//
//     print(directory.path);
//
//     // If the file doesn't exist, create it
//     if (!await logFile.exists()) {
//       await logFile.create();
//     }
//
//     // Append the log message to the file
//     await logFile.writeAsString('$logMessage\n', mode: FileMode.append);
//   }
//
//   // Log to both console and file
//   static Future<void> log(String logMessage) async {
//     logToConsole(logMessage);
//     await logToFile(logMessage);
//   }
// }