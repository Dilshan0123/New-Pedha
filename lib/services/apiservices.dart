import 'dart:convert';
import 'dart:async';
import 'package:PedhaPay/component/Popup/popUp.dart';
import 'package:PedhaPay/main.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;

appController headerKeyController = Get.find();


class ApiServices {

  static var client = https.Client();

  static Future<dynamic> post(var body, dynamic endpoint) async {
    var uri = buildUrl(endpoint);

    debugPrint("uri $uri");
    debugPrint("body $body");

    if (headerKeyController.connectionStatus.value != 0) {
      Get.to(const internet_connection());
      // return PopUp.toastErrorMessage("No Internet");

      var response = await client
          .post(uri, body: body, headers: headerKeyController.headerKeyModel())
          .timeout(const Duration(seconds: 15));

      var statusCode = response.statusCode;
      debugPrint("statuscode $statusCode");

      if (statusCode == 200) {
        return _processResponse(response);
      } else {
        headerKeyController.isLoading.value = false;
        PopUp.toastErrorMessage("Error: ${response.reasonPhrase}");
        return null;
      }

    } else {
      try {
        var response = await client
            .post(uri, body: body, headers: headerKeyController.headerKeyModel())
            .timeout(const Duration(seconds: 15));

        var statusCode = response.statusCode;
        debugPrint("statuscode $statusCode");

        if (statusCode == 200) {
          return _processResponse(response);
        } else {
          headerKeyController.isLoading.value = false;
          PopUp.toastErrorMessage("Error: ${response.reasonPhrase}");
          return null;
        }
      } on TimeoutException catch (e) {
        debugPrint("Request timed out: $e");
        headerKeyController.isLoading.value = false;
        PopUp.toastErrorMessage("Request timed out. Please try again.");
        return null;
      } catch (e) {
        debugPrint("An error occurred: $e");
        PopUp.toastErrorMessage("An error occurred. Please try again.");
        return null;
      }
    }
  }

  static Future<dynamic> post_Recharge(var body, dynamic endpoint) async {

    var uri = builtRechargeUrl(endpoint);

    debugPrint("uri $uri");
    debugPrint("body $body");

    var response = await client.post(uri, body: body, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    });
    var statuscode =  response.statusCode;
    debugPrint("statuscode $statuscode");
    return _processResponse(response);

  }

  static Future<dynamic> post_AEPS(var body, dynamic endpoint) async {

    var uri = builtAEPSUrl(endpoint);

    debugPrint("uri $uri");
    debugPrint("body $body");

    var response = await client.post(uri, body: body, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    });
    var statuscode =  response.statusCode;
    debugPrint("statuscode $statuscode");
    return _processResponse(response);
  }

  static Future<dynamic> post_DMT(var body) async {

    var uri = builtDMTSUrl();

    debugPrint("uri $uri");
    debugPrint("body $body");

    var response = await client.post(uri, body: body, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    });
    var statuscode =  response.statusCode;
    debugPrint("statuscode $statuscode");
    return _processResponse(response);
  }

  static Future<dynamic> get(var body, dynamic endpoint) async {

    var uri = buildUrl(endpoint);

    debugPrint("uri $uri");
    debugPrint("body $body");


    var response = await client.get(uri, headers: headerKeyController.headerKeyModel()
    );
    var statuscode =  response.statusCode;
    debugPrint("statuscode $statuscode");
    return _processResponse(response);
  }


  static Uri buildUrl(String endpoint) {
    final apiPath = AppBaseUrl.baseUrl + endpoint;
    return Uri.parse(apiPath);
  }

  static Uri builtRechargeUrl(String endpoint){
    final rechargeApiPath  = RechargeBaseUrl.baseUrl +endpoint;

    return Uri.parse(rechargeApiPath);
  }
  static Uri builtAEPSUrl(String endpoint){
    final rechargeApiPath  = AEPS_BaseUrl.baseUrl +endpoint;

    return Uri.parse(rechargeApiPath);
  }

  static Uri builtDMTSUrl(){
    if(headerKeyController.DMTService == "DMT 2"){
      final rechargeApiPath  = DMT2_BaseUrl.baseUrl;

      return Uri.parse(rechargeApiPath);
    }else{
      final rechargeApiPath  = DMT_BaseUrl.baseUrl;

      return Uri.parse(rechargeApiPath);
    }

  }



  static dynamic _processResponse(https.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      default:
      headerKeyController.isLoading.value = false;
        return PopUp.alertMessage("Internal Server Error !!");
   }
  }
}



class AppBaseUrl{
  static var baseUrl = 'http://api.payimps.in/recApiFinal/service.aspx';
}


class AEPS_BaseUrl{
  static var baseUrl = 'https://api.pedhapay.com/';
}

class DMT_BaseUrl{
  static var baseUrl = 'https://dmt.instant.payimps.in/dmtPayV2.aspx';
}

class DMT2_BaseUrl{
  static var baseUrl = 'http://webapi.payimps.in/Services.aspx';
}

class RechargeBaseUrl{
  static var baseUrl = "http://api.payimps.in/recApiFinal/service.aspx";
}


class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url]) : super(message, 'Bad Request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url]) : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url]) : super(message, 'Api not responded in time', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url]) : super(message, 'UnAuthorized request', url);
}


class ConnectivityProvider with ChangeNotifier{
  late bool _isOnline;
  bool get isOnline => _isOnline;

  ConnectivityProvider(){
    Connectivity connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen((result) async {
      if(result == ConnectivityResult.none){
        _isOnline = false;
        notifyListeners();
      }else{
        _isOnline = true;
        notifyListeners();
      }
    });
  }
}

