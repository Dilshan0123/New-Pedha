import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:PedhaPay/model/Pedha%20Pay%20Model/Bank%20List/DMTBankListModel.dart' as dmt;
import 'package:PedhaPay/model/Pedha%20Pay%20Model/History_Model/serviceHistoryModel.dart';
import 'package:PedhaPay/model/Pedha%20Pay%20Model/P_loginDataModel.dart';
import 'package:PedhaPay/model/Pedha%20Pay%20Model/Recharge/PlanModel.dart';
import 'package:PedhaPay/model/Pedha%20Pay%20Model/Recharge/ReOperatorModel.dart';
import 'package:PedhaPay/model/Pedha%20Pay%20Model/UserBalenceModel.dart';
import 'package:PedhaPay/model/aeps%20Model/aepsSettlementModel.dart';
import 'package:PedhaPay/component/Popup/popUp.dart';
import 'package:PedhaPay/model/LoginDataModel/loginDataModel.dart';
import 'package:PedhaPay/model/LoginDataModel/userBallenceDataModel.dart';
import 'package:PedhaPay/model/bbpsDataModel/bbpsfetchDataModel.dart';
import 'package:PedhaPay/model/importBeneModel.dart';
import 'package:PedhaPay/model/txnDataModel/txnDataModel.dart';
import 'package:PedhaPay/screen/BBPS/BBPSSuccessPage.dart';
import 'package:PedhaPay/screen/Recharge/DTHSuccessPage.dart';
import 'package:PedhaPay/screen/SuccessPage.dart';
import 'package:PedhaPay/screen/WADashboardScreen.dart';
import 'package:PedhaPay/screen/WALoginScreen.dart';
import 'package:PedhaPay/screen/WAVerificationScreen.dart';
import 'package:PedhaPay/services/apiservices.dart';
import 'package:PedhaPay/utils/WAWidgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';
import '../model/BeneficiaryListDataModel.dart';
import '../model/Pedha Pay Model/AEPS/AEPS_BE_Model.dart' as be;
import '../model/Pedha Pay Model/AEPS/AEPS_MS_Model.dart' as ms;
import '../model/Pedha Pay Model/Bank List/AEPSBankListModel.dart';
import '../model/Pedha Pay Model/Bill Payments/BillPaymetsDataModel.dart';
import '../model/Pedha Pay Model/Bill Payments/billFetchModel.dart' as bill;
import '../model/Pedha Pay Model/DMT/DMTBeneModel.dart' as beneDMT;
import '../model/Pedha Pay Model/History_Model/loadRequest.dart';
import '../model/Pedha Pay Model/LoadRequestBankListModel.dart';
import '../model/bbpsDataModel/offline_BBPSModel.dart';
import '../services/appCheckVersion.dart';
import '../utils/WAColors.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class appController extends GetxController {
  // 537358936421

  var platform = const MethodChannel('pedhapay/aeps');

  String AePSType = "";

  var connectionStatus = 0.obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult>connectivitySubscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLoginDetails();
    checkGps();
    // _getCurrentLocation();
    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  playStoreUrl() {
    if (DiviceSelected == "mantra") {
      return launchUrlStart(url: "https://play.google.com/store/apps/details?id=com.mantra.rdservice");
    }
    else if (DiviceSelected == "morpho") {
      return launchUrlStart(url: "https://play.google.com/store/apps/details?id=com.scl.rdservice");
    }
    else if (DiviceSelected == "morphol1") {
      return launchUrlStart(url: "https://play.google.com/store/apps/details?id=com.idemia.l1rdservice");
    }
    else if (DiviceSelected == "Startek") {
      return "https://play.google.com/store/apps/details?id=com.acpl.registersdk";
    }
    else if (DiviceSelected == "StartekL1") {
      return "https://play.google.com/store/apps/details?id=com.acpl.registersdk_l1";
    }
    else if (DiviceSelected == "Secugen") {
      return "https://play.google.com/store/apps/details?id=com.secugen.rdservice";
    } else if (DiviceSelected == "Next Biometrics") {
      return "https://play.google.com/store/apps/details?id=com.nextbiometrics.rdservice";
    } else if (DiviceSelected == "Precision") {
      return "https://play.google.com/store/apps/details?id=com.precision.pb510.rdservice";
    } else if (DiviceSelected == "Evolute") {
      return "https://play.google.com/store/apps/details?id=com.evolute.rdservice&hl=en_US";
    } else if (DiviceSelected == "mantral1") {
      return launchUrlStart(url: 'https://play.google.com/store/apps/details?id=com.mantra.mfs110.rdservice&hl=en&gl=US');
    }else if (DiviceSelected == "Aratek") {
      return "https://play.google.com/store/apps/details?id=co.aratek.asix_gms.rdservice";
    }
    else {
      return "https://play.google.com/store/apps/details?id=co.aratek.asix_gms.rdservice";
    }
  }

  // initConnectivity() async {
  //   ConnectivityResult result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //     print(result);
  //     return _updateConnectionStatus(result);
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  // }

  updateConnectionStatus(ConnectivityResult result) {
    print(result);

    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        break;

      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        break;

      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;

      default:
        Get.snackbar("Network Error", "Failed to get Network connection");
        break;
    }
  }

  // Check App Version And Name ...................

  String version = "";
  String buildNumber = "";
  String packageName = "";
  String appName = "";
  String buildSignature = "";

  var loginIdController = TextEditingController();
  var passwordController = TextEditingController();
  var remitterController = TextEditingController();
  var dmtAmountController = TextEditingController();
  var beneAccount = TextEditingController();
  TextEditingController beneIfscCode = TextEditingController();
  TextEditingController beneName = TextEditingController();
  TextEditingController benMobile = TextEditingController();
  TextEditingController remitterNameController = TextEditingController();
  TextEditingController tPinPaymentCOntroller = TextEditingController();
  var search = TextEditingController();

  // BBPS Controller
  var dateOfBirthController = TextEditingController();
  var emailController = TextEditingController();
  var custmerNameController = TextEditingController();
  var bbpsAmountController = TextEditingController();

  // profile details Controller
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();
  var confirmPassController = TextEditingController();

  var FRemarksController = TextEditingController();

  var oldTPinController = TextEditingController();
  var newTPinController = TextEditingController();
  var confirmTPinController = TextEditingController();
  var remarkD2d = TextEditingController();


  var bankHolderNameController = TextEditingController();
  var bankBranchNameController = TextEditingController();

  var mobileNumberController = TextEditingController();
  var mobileOperatorController = TextEditingController();
  var mobileAmountController = TextEditingController();
  var fMobileNumberController = TextEditingController();
  var bankController = TextEditingController();

  var fieldNameController = TextEditingController();
  var fieldNumberController = TextEditingController();

  var dateinput = TextEditingController();
  var toDateInput = TextEditingController();

  TextEditingController pinController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  // var pinController = OtpFieldController();
  var dmtPinController = OtpFieldController();

  var FTxnIdController = TextEditingController();
  var FAmountController = TextEditingController();
  var FTxnDateController = TextEditingController();

  TextEditingController selectBankController = TextEditingController();
  TextEditingController adharNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController textEditController = TextEditingController();

  TextEditingController mPinController = TextEditingController();


  var userlistData = <Data>[].obs;
  var userAcBackUpList = <Data>[].obs;
  var rechargePlan = <Data>[].obs;

  var viewDmtPaymentList = <Data>[].obs;





  // Recharge List ..........................
  List<RechargeOperatorDataModel> dthProviderList = <RechargeOperatorDataModel>[].obs;

  var getPlanList = getPlanDataModel().obs;
  var getPlanListData = <Records>[].obs;
  var getPlanListBackup = <Records>[].obs;

  // Bank List ................................
  var fingPayBankList = AEPSBankListDataModel().obs;
  var getBankList = Payload().obs;
  var getBankListData = <IinList>[].obs;

  var LoadRequestbanklist = <loadRequestBankListModel>[].obs;

  var dmtBankListModel = dmt.DMTBankListModel().obs;
  var dmtBankList = <dmt.Data>[].obs;

// DMT and Payout...........................................
  var benListDataModel = PU_benListDataModel().obs;
  var beneList = <Beneficiary>[].obs;
  var beneListBack = <Beneficiary>[].obs;

  var dmtBeneModel = beneDMT.DMTBeneDataModel().obs;
  var dmtBeneData = beneDMT.Data().obs;
  var getDMTBene = <beneDMT.Beneficiaries>[].obs;
  var selectedBeneList = <beneDMT.Beneficiaries>[].obs;



// BBPS List
  var getCategoryList = <subCategoryDataModel>[].obs;
  var insuranceList = <subCategoryDataModel>[].obs;
  var getSubCategoryList = <subCategoryDataModel>[].obs;
  var selectedSubCategoryList = <subCategoryDataModel>[].obs;

  var billFetchModel = bill.billFetchDataModel().obs;
  var billFechList = <bill.Data>[].obs;

  var gatSubCatList = <Data>[].obs;

  var bilFetchList = billfetchDataModel().obs;
  var bilfetchListData = <FetchData>[].obs;

  var off_BillFetchList = offBBPSModel().obs;
  var off_BillFetchListData = <Rdata>[].obs;

  var MS_Model = ms.MS_DataModel().obs;
  var MS_DataList = ms.Data().obs;
  var MS_List = <ms.MiniStatementStructureModel>[].obs;

  var aepsBEModel = be.AEPS_BE_Model().obs;
  var aepsBEResponseData = be.Data().obs;
  var aepsCWResponseData = be.Data().obs;


  TextEditingController adharController = TextEditingController();

  //  Report List

  var serviceTxnList = <servicesTxnDataModel>[].obs;
  var serviceTxnFilterList = <servicesTxnDataModel>[].obs;
  var serviceTxnFilterListBackup = <servicesTxnDataModel>[].obs;
  var serviceTxnListData = <servicesTxnDataModel>[].obs;

  var loadRequestList = <viewloadModel>[].obs;
  var loadRequestBackUp = <viewloadModel>[].obs;

  var fetchSettlementList = <settlementDataModel>[].obs;
  var fetchSettlementListBackUp = <settlementDataModel>[].obs;

  var txnList = txnDataModel().obs;
  var txnListData = <txnData>[].obs;
  var BackUplist = <txnData>[].obs;
  var userList = <UserData>[].obs;
  var userBackUpList = <UserData>[].obs;

  // var profileListData =

  var P_loginDataList = P_loginDataModel().obs;
  var P_VerifyDataList = P_loginDataModel().obs;
  var getUserBalanceList = getUserBalanceModel().obs;

  var loginDetailsList = loginDataModel().obs;
  var userDataList = Userdata().obs;
  var userProfileData = Userdata().obs;
  var userBalleceList = UserBallenceDataModel().obs;
  var userBalenceDataList = Balance().obs;
  var walletList = walletBallenceModel().obs;
  var walletListData = <WalletData>[].obs;

  String response = "";
  String finel_pin = "";
  String remmitterOtpPin = "";
  String aadharOtpPin = "";
  String tpin = "";
  String bankName = "";
  String bankIfsc = "";
  String bankId = "";
  String benId = "";
  String dmtPaymentOption = "IMPS";
  String aepsTxnMode = "";
  String reNumber = "";
  String BeneFiName = "";
  String Benelimit = "";
  String operator = "";
  String bbpsRId = "";
  String bbpsRefId = "";
  String providerId = "";
  String encryptedKey = '';
  String txnPins = "";
  String headerKey = "";
  String userIdKey = "";

  String reSenderMobile = "";
  String dmtAmount = "";
  String benName = "";
  String beneAccountNumber = "";
  String dmtCharge = "";
  String dmtTxnId = "";
  String dmtTxnDate = "";
  String beneBankName = "";
  String beneIfsc = "";
  int sum = 0;

  String DMTService = "";


  // BBPS Variable..............
  String fieldName = "";
  String secondField = "";
  String secondFieldName = "";
  String secondFieldRegex = "";
  String viewBill = "";

  String providerAlias = "";
  String FieldRegex = "";
  String serviceId = "";
  String dueAmount = "";
  String billerNumber = "";
  String providerName = "";
  String FalseMessage = "";
  String billStatus = "";
  String providerImage = "";
  String dateRegex = "";
  String bbpsAmount = "";
  String RegNumber = "";

  // AePS Variable ...............
  String verificationToken = "";
  String outletId = "";
  String TxnTypedata = "";
  String TxType = "";
  String TxId = "CW";
  String AadharNumber = "";
  String TxnAmount = "0";
  String fundMode = "";
  String TxnDate = "";
  String DiviceSelected = "";
  String DeviceRequest = "";

  // Recharge Varible.....
  String MobileNumber = "";
  String ReAmount = "";
  String txnMode = "";
  String historyMethod = "";
  String LagerName = "";
  String IinId = "";
  String TxnId = "";

  // date Variable
  String StartDate = "";
  String EndDate = "";

  // Theam Settings
  String titleName = "";
  String titleLogo = "";
  String titleColor = "0xFF6C56F9";

  String selectedOption = '1';
  RxString selectedMode = 'IMPS'.obs;
  RxString bbpsService = "".obs;
  String Service = "";

  // Status ........
  String paymentStatus = "";
  String paymentMessage = "";

  // FUND REQUEST


  // active text field ...........
  var ImagePath = "";

  var isEnableNumber = true.obs;
  var isEnableAadhaar = true.obs;
  var isEnableName = true.obs;



  var isVisible = false.obs;
  var isVisible_sentOtpbtn = false.obs;
  var isVisibleAdhar = false.obs;
  var isVisibleName = false.obs;
  var isVisibleOtp = false.obs;
  var isVisibleOtpLogin = false.obs;
  var isVisibleOtpVerify = false.obs;
  var isVisible_KYC = false.obs;
  var isVisible_btn = false.obs;

  var isVisibleBeneDetails = false.obs;
  var isVisibleParam = false.obs;
  var isVisibleOffParam = false.obs;
  var isVisiblePaymentBtn = false.obs;
  var isVisibleBBPSPaymentBtn = false.obs;
  var isVisibleFetchBtn = false.obs;
  var isVisibleFNumber = false.obs;
  var isKycVisible = true.obs;
  var isVisibleAmount = true.obs;
  var isVisibleFalseMessage = false.obs;
  var imgVisible = false.obs;
  bool isVisibleCreateDmtSender = false;
  var isVisiblePayment = false.obs;
  var isVisibleSlip = true.obs;
  var isVisibleTxnAePSReq = false.obs;
  var isVisiblePersonalDetails = false.obs;
  var isVisibleAccountDetails = false.obs;
  var isVisibleBankFundTransfer = false.obs;
  var isVisiblePlanBtn = false.obs;
  var isVisibleRechargeMsg = false.obs;

  var isLoading = false.obs;
  var isLoginLoading = false.obs;

  bool obscureText = true;

  bool isChecked = false;

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  // Validation

  Color mycolor = Colors.red;
  String pickedColor = "";
  String colorCode = "0xFF45066A";
  String colorName = "";


  String md5UserId = "";


  var walletBackUpList = <WalletData>[].obs;
  var searchBackupList = <Beneficiary>[].obs;

  String generateRandomKey(int length) {
    final random = Random.secure();
    const values = '0123456789';
    final List<int> codes = List<int>.generate(
        length, (i) => values.codeUnitAt(random.nextInt(values.length)));
    return String.fromCharCodes(codes);
  }

  String generateMd5() {
    md5UserId = md5.convert(utf8.encode(P_loginDataList.value.pkid!)).toString();
    return md5UserId;
  }

  void requestIdGenerate() {
    final Rid = generateRandomKey(23); // Change 32 to the desired length
    final RfId = generateRandomKey(23);
    bbpsRId = Rid;
    bbpsRefId = RfId;
  }
  appLogo() {
    if (titleLogo.isNotEmpty) {
      return Image.network(titleLogo);
    } else {
      return Image.asset("assets/appLogo.png",width: MediaQuery.of(Get.context!).size.width * 0.3,);
    }
  }



  PaymentStatusColor(status, index) {
    if (txnListData[index].status == 'S') {
      return Container(
        child: const Text(
          "Success",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      );
    } else if (txnListData[index].status == 'P') {
      return Container(
        child: const Text(
          "Pending",
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
      );
    } else if (txnListData[index].status == 'A') {
      return Container(
        child: const Text(
          "Aproved",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Container(
        child: const Text(
          "Failed",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ).paddingOnly(right: 10);
    }
  }

  // Search Filter

  void searchFilter(String enteredKeyword) {
    var dummyList = <txnData>[];

    if (enteredKeyword.isEmpty) {
      txnListData.value = BackUplist;
    } else {
      dummyList = BackUplist.value
          .where((element) =>
              (element.txnId != null &&
                  element.txnId!.toLowerCase().contains(enteredKeyword)) ||
              (element.amount != null &&
                  element.amount!.toLowerCase().contains(enteredKeyword)))
          .toList();
      txnListData.value = dummyList;
    }
  }

  void searchServicesFilter(String enteredKeyword) {
    var dummyList = <servicesTxnDataModel>[];

    if (enteredKeyword.isEmpty) {
      serviceTxnFilterList.value = serviceTxnFilterListBackup;
    } else {
      dummyList = serviceTxnFilterListBackup.value
          .where((element) =>
              (element.transactionID != null &&
                  element.transactionID!.toLowerCase().contains(enteredKeyword)) ||
              (element.amount != null &&
                  element.amount!.toLowerCase().contains(enteredKeyword)) ||
                  (element.tid != null &&
                      element.tid!.toLowerCase().contains(enteredKeyword)))
          .toList();
      serviceTxnFilterList.value = dummyList;
    }
  }

  void walletSearchFilter(String enteredKeyword) {
    var dummyList = <servicesTxnDataModel>[];

    if (enteredKeyword.isEmpty) {
      serviceTxnList.value = serviceTxnFilterListBackup;
    } else {
      dummyList = serviceTxnFilterListBackup.value
          .where((element) =>
          (element.transactionID != null && element.transactionID!.toLowerCase().contains(enteredKeyword)) ||
          (element.amount != null && element.amount!.toLowerCase().contains(enteredKeyword)) ||
          (element.service != null && element.service!.toLowerCase().contains(enteredKeyword))).toList();
      serviceTxnList.value = dummyList;
    }
  }

  void PlanSearchFilter(String enteredKeyword) {
    var dummyList = <Records>[];

    if (enteredKeyword.isEmpty) {
      getPlanListData.value = getPlanListBackup.value;
    } else {
      dummyList = getPlanListBackup.value
          .where(
              (element) =>  (element.rs != null && element.rs!.toLowerCase().contains(enteredKeyword)))
          .toList();
      getPlanListData.value = dummyList;
    }
  }

  void userSearchFilter(String enteredKeyword) {
    var dummyList = <UserData>[].obs;

    if (enteredKeyword.isEmpty) {
      userList.value = userBackUpList;
    } else {
      dummyList.value = userBackUpList
          .where((element) =>
              element.uCompany!.toLowerCase().contains(enteredKeyword) ||
              element.uFirstName!.toLowerCase().contains(enteredKeyword))
          .toList();
      // dummyList = list.where((element) => element.date!.toLowerCase().contains(enteredKeyword)).toList();
      userList.value = dummyList.value;
    }
  }

  void beneSearchFilter(String enteredKeyword) {
    var dummyList = <Beneficiary>[].obs;

    if (enteredKeyword.isEmpty) {
      beneList = searchBackupList;
    } else {
      dummyList.value = searchBackupList.value
          .where((element) => element.name!.toLowerCase().contains(enteredKeyword))
          .toList();
      // dummyList = list.where((element) => element.date!.toLowerCase().contains(enteredKeyword)).toList();
      beneList = dummyList;
    }
  }

  void runFilter(String enteredKeyword) {
    var dummyList = <txnData>[];
    if (enteredKeyword.isEmpty) {
      txnListData.value = BackUplist;
    } else {
      // 13-06-2023
      // 13-06-2023 , 07:57:39 AM
      dummyList = BackUplist.where((element) {
        // DateTime tranDate = DateTime.parse(element.date!);
        String fToDate = DateFormat("dd-MM-yyyy ").format(toDate);
        String fFromDate = DateFormat("dd-MM-yyyy").format(fromDate);
        DateTime apiDate =
            DateFormat("yyyy-MM-dd , hh:mm:ss a").parse(element.date!);
        if (apiDate.isBefore(fromDate) ||
            apiDate.isAfter(toDate) ||
            element.date!.contains(fToDate) ||
            element.date!.contains(fFromDate)) {
          return true;
        } else {
          return false;
        }
      }).toList();
      dummyList = txnListData
          .where(
              (element) => element.date!.toLowerCase().contains(enteredKeyword))
          .toList();
      txnListData.value = dummyList;
    }
  }


  TxnHistory() {
    if (serviceTxnFilterList.value.isNotEmpty) {
      return ListView.builder(
          itemCount: serviceTxnFilterList.value.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: const Text(
                          "Txn Id :",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          serviceTxnFilterList[index].tid!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          // overflow: TextOverflow.ellipsis,
                        ).paddingOnly(left: 10),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: const Text(
                          "Date :",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          serviceTxnFilterList[index].date!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          // overflow: TextOverflow.ellipsis,
                        ).paddingOnly(left: 10),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: const Text(
                          "Service :",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          serviceTxnFilterList[index].service!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          // overflow: TextOverflow.ellipsis,
                        ).paddingOnly(left: 10),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: const Text(
                          "Status :",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          serviceTxnFilterList[index].status ==
                              "Success"
                              ? 'Success'
                              : serviceTxnFilterList[index]
                              .status ==
                              "P"
                              ? 'Pending'
                              : 'Failed',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.bold,
                            color: serviceTxnFilterList[index]
                                .status ==
                                "Success"
                                ? Colors.green
                                : serviceTxnFilterList.value[index]
                                .status ==
                                "Pending"
                                ? Colors.orange
                                : Colors.red,
                          ),
                        ).paddingOnly(left: 10),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      SizedBox(
                          width:
                          MediaQuery.of(context)
                              .size
                              .width *
                              0.2,
                          child: const Text(
                            "Amount :",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                FontWeight
                                    .bold),
                          )),
                      Expanded(
                          child: Text(
                            "₹ ${serviceTxnFilterList[index]
                                    .amount!}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight:
                                FontWeight.bold),
                          ).paddingOnly(left: 10)),
                    ],
                  ),
                  10.height,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color.WASecondryColor, // Set button color to green
                      ),
                      onPressed: () {
                        serviceTxnListData.value.clear();
                        serviceTxnListData.value.add(serviceTxnFilterList.value[index]);
                        showModalBottomSheet(
                          context: Get.context!,
                          // isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (BuildContext context) {
                            return showDetailsListBottomSheet(context);
                          },
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.visibility,color: Colors.white,),
                          SizedBox(width: 10), // Add space between icon and text
                          Text("View More",style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  )
                ],
              ).paddingAll(10),
            );
          }).paddingAll(10);
    } else {
      return const Center(
          child: Text(
        "No Data Found !!",
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
    }
  }

  Widget viewMoreTxnDataBottomSheet(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("data"),
        ],
      )
    );
  }

  walletTxn() {
    if (serviceTxnList.isNotEmpty) {
      return ListView.builder(
        itemCount: serviceTxnList.value.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              txnMode = "";
              serviceTxnListData.value.clear();
              txnMode = serviceTxnList.value[index].service!;
              serviceTxnListData.value.add(serviceTxnList.value[index]);
              showModalBottomSheet(
                context: Get.context!,
                // isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (BuildContext context) {
                  return showDetailsListBottomSheet(context);
                },
              );
            },
            child: Column(
              children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: color.WASecondryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: double.infinity,
                    child: Text(
                      serviceTxnList[index].service!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                Card(
                  elevation: 4, // Adds shadow for depth
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey.shade200,
                            radius: 18,
                            child: Text(
                              (index + 1).toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          title: Text(
                            'Txn ID: ${serviceTxnList[index].tid}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            serviceTxnList[index].date!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "₹ ${serviceTxnList[index].amount!}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: serviceTxnList[index].status == "Success"
                                      ? Colors.green.shade100
                                      : serviceTxnList[index].status == "Pending"
                                      ? Colors.orange.shade100
                                      : Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      serviceTxnList[index].status == "Success"
                                          ? Icons.check_circle
                                          : serviceTxnList[index].status == "Pending"
                                          ? Icons.access_time
                                          : Icons.cancel,
                                      size: 16,
                                      color: serviceTxnList[index].status == "Success"
                                          ? Colors.green
                                          : serviceTxnList[index].status == "Pending"
                                          ? Colors.orange
                                          : Colors.red,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      serviceTxnList[index].status == "Success"
                                          ? 'Success'
                                          : serviceTxnList[index].status == "Pending"
                                          ? 'Pending'
                                          : 'Failed',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: serviceTxnList[index].status == "Success"
                                            ? Colors.green
                                            : serviceTxnList[index].status == "Pending"
                                            ? Colors.orange
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      );
    } else {
      return const Center(
        child: Text(
          "No Data Found !!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }
  }

  userKyc(index) {
    if (userList.value[index].kycStatus == "Y") {
      return const Icon(
        Icons.verified,
        color: Colors.green,
      ).paddingOnly(right: 20);
    } else {
      return const Icon(
        Icons.pending,
        color: Colors.red,
      ).paddingOnly(right: 20);
    }
  }

  fundListStatus(index) {
    if (txnListData[index].status! == "P") {
      return Column(
        children: [
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width * 0.2,
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color(0xFFDE7575) // Background color
                  ),
              onPressed: () {
                TxnId = txnListData[index].id!;
                Get.dialog(AlertDialog(
                  title: const Center(
                      child: Text(
                          'Are you sure you want to reject request')),
                  actions: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.green, // Background color
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text("No")),
                        10.width,
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.red, // Background color
                            ),
                            onPressed: () {
                            },
                            child: const Text("Yes")),
                      ],
                    ).paddingOnly(left: 20)
                  ],
                ));
              },
              child: const Text(
                'Reject',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          5.height,
          SizedBox(
            height: 30,
            width: MediaQuery.of(Get.context!).size.width * 0.2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color.fromRGBO(60, 179, 113, 1), // Background color
              ),
              onPressed: () {
                TxnId = txnListData[index].id!;
                Get.dialog(AlertDialog(
                  title: const Center(
                      child: Text(
                          'Are you sure you want to approve request')),
                  actions: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.green, // Background color
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text("No")),
                        10.width,
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.red, // Background color
                            ),
                            onPressed: () {

                            },
                            child: const Text("Yes")),
                      ],
                    ).paddingOnly(left: 20)
                  ],
                ));
              },
              child: const Text(
                'Approve',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ).paddingOnly(top: 5, bottom: 5);
    } else if (txnListData[index].status! == "A") {
      return SizedBox(
          height: 60,
          child: Column(
            children: [
              const Icon(
                Icons.verified,
                color: Colors.green,
              ).paddingOnly(top: 10),
              const Text(
                "Approved",
                style: TextStyle(color: Colors.green),
              ).paddingOnly(right: 10),
            ],
          ));
    } else if (txnListData[index].status! == "R")
      return SizedBox(
          height: 60,
          child: Column(
            children: [
              const Icon(
                Icons.do_disturb_alt,
                color: Colors.red,
              ).paddingOnly(top: 10),
              const Text(
                "Rejected",
                style: TextStyle(color: Colors.red),
              ).paddingOnly(right: 10),
            ],
          ));
  }

  UserStatus(index) {
    if (userList.value[index].uStatus! == "A") {
      return const Text(
        "Active",
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    } else if (userList.value[index].uStatus! == "D") {
      return const Text(
        "Deactive",
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    } else if (userList.value[index].uStatus! == "B") {
      return const Text(
        "Block",
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    }
  }


  List<String> validUrls = [];


  userProfileImage() {
    print(userProfileData.value.uPhoto!);
    if (userProfileData.value.uPhoto!.isNotEmpty) {
      return Image.network(
        validUrls.toString(),
        height: MediaQuery.of(Get.context!).size.height * 0.14,
        width: MediaQuery.of(Get.context!).size.width * 0.3,
      );
    } else {
      return Image.asset("assets/webshineLogo.png").paddingAll(10);
    }
  }

  String currentDate = "";
  String currentTime = "";

  dateAccess() {
    var now = DateTime.now();
    var formatteedDate = DateFormat('yyyy-MM-dd');
    String formattedTime = "${now.hour}:${now.minute}:${now.second}";
    print("Formatted Time: $formattedTime");
    currentDate = formatteedDate.format(now); // 2016-01-25
    currentTime = formattedTime.toString();
    dateEnd = currentDate;
  }

  Map<String, String> headerKeyModel() {
    Map<String, String> headerMap = {"source": "APP", "token": headerKey};
    if (loginDetailsList.value.status == "S") {
      headerKey = userDataList.value.token!;
      userIdKey = userDataList.value.uId!;
      headerMap = {"source": "APP", "userId": userIdKey, "token": headerKey};
      print(headerMap);
      return headerMap;
    } else {
      headerKey = encryptedKey;
      headerMap = {"source": "APP", "token": headerKey};
      print(headerMap);
      return headerMap;
    }
  }

  String bbpsSecondField = "";
  String bbpsfirstField = "";

  Map<String, String> bbpsPaymentKeyModel() {
    Map<String, String> headerMap = {};
    if(bbpsService == "Offline"){
      headerMap = {
        "service": serviceId,
        "firstFieldName": fieldNameController.text,
        "customerName": off_BillFetchListData[0].customerName!,
        "operatorId": providerId,
        "amount": "200",
        "billDate": off_BillFetchListData.value[0].billdate!,
        "dueDate": off_BillFetchListData.value[0].duedate!,
      };
      print(headerMap);
      return headerMap;
    }else {
      if (serviceId == "Prepaid") {
        headerMap = {
          "service": "prepaid",
          "circleId": 'circleId',
          "firstFieldName": 'MobileNumber',
          "amount": 'MobileNumber',
          "operatorId": 'MobileNumber',
        };
        print(headerMap);
        return headerMap;
      } else {
        headerMap = {
          "service": serviceId,
          "firstFieldName": fieldNameController.text,
          "customerName": bilfetchListData[0].userName!,
          "dueDate": bilfetchListData.value[0].dueDate!,
          "operatorId": providerId,
          "amount": dueAmount,
          "BillerNo": bilfetchListData.value[0].cellNumber!,
          "providerName": providerName,
          "billDate": bilfetchListData.value[0].billdate!,
          "ad1": bbpsSecondField,
          "circleId": '',
          "ad2": '',
          "ad3": '',
          "ad4  ": '',
        };
        print(headerMap);
        return headerMap;
      }
    }
  }

  Map<String, String> bbpsKeyModel() {
    Map<String, String> headerMap = {};
    if(bbpsService == "Offline"){
     if(serviceId == "Insu"){
       headerMap = {
         'category': serviceId,
         'operatorId': providerId,
         'mobile': MobileNumber,
         'firstFieldName': fieldNameController.text,
       };
       return headerMap;
     }else{
       headerMap = {
         'category': serviceId,
         'operatorId': providerId,
         'firstFieldName': fieldNameController.text,
       };
       return headerMap;
     }
    }else{
      if (serviceId == "Insurance") {
        headerMap = {
          'operatorId': providerId,
          'firstFieldName': fieldNameController.text,
          'email': emailController.text,
          'category': "Insurance"
        };
        print(headerMap);
        return headerMap;
      } else if (serviceId == "19") {
        headerMap = {
          'operatorId': providerId,
          'mobile': MobileNumber,
          'amount': bbpsAmount,
          'service': serviceId,
          'BillerNo': RegNumber,
          "radiobutton": "0",
          "customerName": billerNumber,
          "dueDate": currentDate,
          'txnpin': txnPins
        };
        return headerMap;
      } else {
        headerMap = {
          'category': "Electricity",
          'operatorId': providerId,
          'firstFieldName': fieldNameController.text,
        };
        print(headerMap);
        return headerMap;
      }
    }
  }

  final loginKey = GlobalKey<FormState>();
  final otpKey = GlobalKey<FormState>();

  final List<String> sliderList = [
    'assets/RechargeBannar.png',
    'assets/dthBannar.png',
    'assets/LicBannar1.png',
    'assets/CreditCardBannar1.png',
  ];

  Slider() {
    if (sliderList.isNotEmpty) {
      return CarouselSlider.builder(
        options: CarouselOptions(
          height: 100,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ),
        itemCount: sliderList.length,
        itemBuilder: (context, index, id) {
          return Card(
            color: const Color.fromRGBO(242, 242, 242, 1),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12), // Set border radius for the image
              child: Image.asset(
                sliderList[index],
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
          ).paddingAll(5);

        },
      );
    } else {
      return Container();
    }
  }

  Widget otpChecklistBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Login by OTP",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          // Checklist Items
          Form(
            key: loginKey,
            child: AppTextField(
              enabled: false,
              onChanged: (value){
                loginKey.currentState!.validate();
              },
              maxLength: 10,
              validator: Validation.validationRequired,
              decoration: waInputDecoration(
                hint: 'Enter your login id here',
                prefixIcon: Icons.account_box,
              ),
              textFieldType: TextFieldType.PHONE,
              keyboardType: TextInputType.number,
              controller: loginIdController,
            ),
          ),
          const SizedBox(height: 20),
          const Text("Enter Otp"),
          const SizedBox(height: 5,),
          Container(
            child: Form(
              key: otpKey,
              child: AppTextField(
                onChanged: (value){
                  otpKey.currentState!.validate();
                  if(value.length == 6){

                  }
                },
                maxLength: 6,
                validator: Validation.validationRequired,
                decoration: waInputDecoration(
                  hint: 'Enter otp',
                  prefixIcon: Icons.password,
                ),
                textFieldType: TextFieldType.PHONE,
                keyboardType: TextInputType.number,
                controller: otpController,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Continue Button
          ElevatedButton(
            onPressed: () {
              verifyLoginOtpApi();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Center(
              child: Text("Continue to login",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget showDetailsListBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if(txnMode.toLowerCase() == "UPI".toLowerCase())...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  txnMode,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Txn Id :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].tid!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Date :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].date!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),

            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Service :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].service!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),

            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Account :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].mobile!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Txn Type :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].transactionType!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Status :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].status ==
                        "Success"
                        ? 'Success'
                        : serviceTxnListData[0]
                        .status ==
                        "P"
                        ? 'Pending'
                        : 'Failed',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                      color: serviceTxnListData[0]
                          .status ==
                          "Success"
                          ? Colors.green
                          : serviceTxnListData.value[0]
                          .status ==
                          "P"
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                SizedBox(
                    width:
                    MediaQuery.of(context)
                        .size
                        .width *
                        0.2,
                    child: const Text(
                      "Amount :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight
                              .bold),
                    )),
                Expanded(
                    child: Text(
                      "₹ ${serviceTxnListData[0]
                              .amount!}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.bold),
                    ).paddingOnly(left: 10)),
              ],
            ),
            10.height,

            // AEPS Ledger ...............................
          ] else if(txnMode.toLowerCase() == "AEPS".toLowerCase())...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  txnMode,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Txn Id :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].tid!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Date :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].date!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Service :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].service!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Mobile :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].mobile!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Aadhaar :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].transactionID!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Status :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].status ==
                        "Success"
                        ? 'Success'
                        : serviceTxnListData[0]
                        .status ==
                        "Pending"
                        ? 'Pending'
                        : 'Failed',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                      color: serviceTxnListData[0]
                          .status ==
                          "Success"
                          ? Colors.green
                          : serviceTxnListData.value[0]
                          .status ==
                          "Pending"
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                SizedBox(
                    width:
                    MediaQuery.of(context)
                        .size
                        .width *
                        0.2,
                    child: const Text(
                      "Amount :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight
                              .bold),
                    )),
                Expanded(
                    child: Text(
                      "₹ ${serviceTxnListData[0]
                              .amount!}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.bold),
                    ).paddingOnly(left: 10)),
              ],
            ),
            10.height,
            // Mobile Ledger ........................
          ]else if(txnMode.toLowerCase() == "Mobile".toLowerCase())...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  txnMode,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Txn Id :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].tid!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Date :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].date!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Service :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].service!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Mobile :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].mobile!.split("\r\n").first,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Provide :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].provider!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Status :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].status ==
                        "Success"
                        ? 'Success'
                        : serviceTxnListData[0]
                        .status ==
                        "Pending"
                        ? 'Pending'
                        : 'Failed',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                      color: serviceTxnListData[0]
                          .status ==
                          "Success"
                          ? Colors.green
                          : serviceTxnListData.value[0]
                          .status ==
                          "Pending"
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                SizedBox(
                    width:
                    MediaQuery.of(context)
                        .size
                        .width *
                        0.2,
                    child: const Text(
                      "Amount :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight
                              .bold),
                    )),
                Expanded(
                    child: Text(
                      "₹ ${serviceTxnListData[0]
                              .amount!}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.bold),
                    ).paddingOnly(left: 10)),
              ],
            ),
            10.height,
            ElevatedButton(
              onPressed: () {},
              child: Text("Generate Invoice PDF"),
            )
            // DMT Ledger ....................................
          ]else if(txnMode.toLowerCase() == "DMT".toLowerCase()) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  txnMode,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Txn Id :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].tid!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Date :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].date!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Service :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].service!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Mobile :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].remitter!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Bank :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].provider!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Status :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].status ==
                        "Success"
                        ? 'Success'
                        : serviceTxnListData[0]
                        .status ==
                        "Pending"
                        ? 'Pending'
                        : 'Failed',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                      color: serviceTxnListData[0]
                          .status ==
                          "Success"
                          ? Colors.green
                          : serviceTxnListData.value[0]
                          .status ==
                          "Pending"
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                SizedBox(
                    width:
                    MediaQuery.of(context)
                        .size
                        .width *
                        0.2,
                    child: const Text(
                      "Amount :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight
                              .bold),
                    )),
                Expanded(
                    child: Text(
                      "₹ ${serviceTxnListData[0]
                              .amount!}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.bold),
                    ).paddingOnly(left: 10)),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Name :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].beneName!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            20.height,
            // BBPS Ledger ...................
          ]else if(serviceTxnListData[0].tid!.startsWith('BBP')|| serviceTxnListData[0].tid!.startsWith("MK"))...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  txnMode,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Txn Id :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].tid!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Date :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].date!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Service :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].service!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Service No. :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].mobile!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Status :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].status ==
                        "Success"
                        ? 'Success'
                        : serviceTxnListData[0]
                        .status ==
                        "Pending"
                        ? 'Pending'
                        : 'Failed',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                      color: serviceTxnListData[0]
                          .status ==
                          "Success"
                          ? Colors.green
                          : serviceTxnListData.value[0]
                          .status ==
                          "Pending"
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                SizedBox(
                    width:
                    MediaQuery.of(context)
                        .size
                        .width *
                        0.2,
                    child: const Text(
                      "Amount :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight
                              .bold),
                    )),
                Expanded(
                    child: Text(
                      "₹ ${serviceTxnListData[0]
                              .amount!}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.bold),
                    ).paddingOnly(left: 10)),
              ],
            ),
            10.height,
          ] else if(txnMode.toLowerCase() == "LIC".toLowerCase())...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  txnMode,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Txn Id :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].tid!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Date :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].date!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Service :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].service!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Mobile :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].mobile!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Aadhaar :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].transactionID!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Status :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].status ==
                        "Success"
                        ? 'Success'
                        : serviceTxnListData[0]
                        .status ==
                        "Pending"
                        ? 'Pending'
                        : 'Failed',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                      color: serviceTxnListData[0]
                          .status ==
                          "Success"
                          ? Colors.green
                          : serviceTxnListData.value[0]
                          .status ==
                          "Pending"
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                SizedBox(
                    width:
                    MediaQuery.of(context)
                        .size
                        .width *
                        0.2,
                    child: const Text(
                      "Amount :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight
                              .bold),
                    )),
                Expanded(
                    child: Text(
                      "₹ ${serviceTxnListData[0]
                              .amount!}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.bold),
                    ).paddingOnly(left: 10)),
              ],
            ),
            10.height,
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  serviceTxnListData[0].service!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Txn Id :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].tid!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Date :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].date!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Service :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].service!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Mobile :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].mobile!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Status :",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    serviceTxnListData[0].status ==
                        "Success"
                        ? 'Success'
                        : serviceTxnListData[0]
                        .status ==
                        "Pending"
                        ? 'Pending'
                        : 'Failed',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                      color: serviceTxnListData[0]
                          .status ==
                          "Success"
                          ? Colors.green
                          : serviceTxnListData.value[0]
                          .status ==
                          "Pending"
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ).paddingOnly(left: 10),
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                SizedBox(
                    width:
                    MediaQuery.of(context)
                        .size
                        .width *
                        0.2,
                    child: const Text(
                      "Amount :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight
                              .bold),
                    )),
                Expanded(
                    child: Text(
                      "₹ ${serviceTxnListData[0]
                          .amount!}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.bold),
                    ).paddingOnly(left: 10)),
              ],
            ),
            10.height,
          ]
        ],
      ).paddingAll(10)
    );
  }

  Widget buildChecklistItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  bbpsBillAmount() {
    if (dueAmount.isNotEmpty) {
      return Text(dueAmount);
    } else {
      return "0";
    }
  }


  String loginId = "";
  String appStatus = "";
  String appVideo = "";
  String appVersion = "";

  // Api Integration ...........................

  // check Version Api....
  void checkVersion() async {

    final _checker = AppVersionChecker();
    _checker.checkUpdate().then((value) {
      print(value.canUpdate); //return true if update is available
      print(value.currentVersion); //return current app version
      print(value.newVersion); //return the new app version
      print(value.appURL); //return the app url
      print(value.errorMessage);
      if (value.currentVersion.endsWith(value.newVersion.toString())) {
      } else {
        AlertDialog alert = AlertDialog(
          title: Text("Update App ?"),
          content: Text(
              "A new version  is available !\nWould you like to update it ?"),
          actions: [
            TextButton(
              child: Text(
                "Update",
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                _launchURL(value.appURL.toString());
              },
            )
          ],
        );
        showDialog(
          context: Get.context!,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return WillPopScope(onWillPop: () async => false, child: alert);
          },
        );
      }
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Login and More Api .............

  String password = "";
  String uAdhar = "";
  String uPan = "";

  void refreshUI() {
    update(); // This forces a UI rebuild
  }

  //{method: validatepin, loginid: APR10016, password: 12345678, otp: 3079}

  void loginApi() async {
    isLoading.value = true;
    Map requestData = {
      "method": "applogin",
      // "mobile": "9582726597",
      // "password": passwordController.text,
      "mobile": loginIdController.text,
      "password": passwordController.text,
      "pid": "1",
    };

    var serverResponse = await ApiServices.post((requestData),"");

    var data = json.decode(serverResponse);
    //{"status":true,"statuscode":"200","message":"Successful","Id":"17","Pkid":"17","ReferId":"APR10007","Mobile":"9582726597","Email":"anilgautam2193@gmail.com","ShopName":"ANNI COMMUNICATION","IsUserActive":"1","walletBalance":930.44,"AepsBalance":0.80,"UserType":"(Retailer) \r\n APR10007","DistributorID":"1243","DistributorName":"Distributor","Company":"ANIL KUMAR","IsPassChange":"1","Ticker":"Deam Team Partner , testing is currently in progress. As soon as it\u0027s completed, I will update you. Please wait a little longer. I apologize for the inconvenience and will provide you with an update soon","IsDmtActive":"0","DmtMessage":"Thank you for choosing Domestic Money Remittance (DMR) Services.","IsAepsActive":"0","AepsMessage":"Thank you for choosing Adhaar Enable Payment System (AEPS) Services.","UpiId":"N","Image1":"4c013d8b4f027a75ad2fa52c128db1ba","Image2":"65cdf335f6f225b3bcac68f1027c8e63","IsTpinRequired":"1","IsBenepopupRequired":"1","UserTypeId":"2","kycStatus":"A"}

    isLoading.value = false;
    password = passwordController.text;

    debugPrint("server response $serverResponse");
    if (data["status"] == true) {
      // P_loginDataList.value = P_loginDataModel.fromJson(data);
      //
      // PopUp.toastMessage(data['message'].toString());

      if(isChecked == true){
        sendLoginOtpApi();
      }else{
        var loginDetails2 = P_loginDataModel.fromJson(data);
        saveLoginDetails(loginDetails2);
        Hive.box("id").put("is_login", true);
        Hive.box("id").put("loginKey", loginIdController.text);
        Hive.box("id").put("passKey", passwordController.text);
        print(Hive.box('id').get("loginKey"));
        Get.to(const WAVerificationScreen(), transition: Transition.rightToLeft);
        loginIdController.clear();
        passwordController.clear();
      }
    } else {
      print(data['message'].toString());
      PopUp.toastMessage(data['message'].toString());
    }
  }


  Future<void> saveLoginDetails(P_loginDataModel loginData) async {
    var box = Hive.box('id');
    await box.put('login_data', loginData.toJsonString());
    getLoginDetails();
  }

  Future<P_loginDataModel?> getLoginDetails() async {
    var box = Hive.box('id');
    var jsonString = box.get('login_data');

    // loginDetailsList.value = jsonString.toString();
    if (jsonString != null) {
      P_loginDataList.value = P_loginDataModel.fromJsonString(jsonString);
      print(P_loginDataList.value.referId!);
      // return loginDetailsList.value;
    }
    print(jsonString);
    return null;
  }


  void verifyMPinApi() async {
    isLoading.value = true;

    Map requestData = {
      "method": 'validatepin',
      "loginid": P_loginDataList.value.referId!,
      "password": Hive.box('id').get("passKey"),
      "otp": finel_pin,
    };

    var serverResponse = await ApiServices.post((requestData), '');

    var data = json.decode(serverResponse);
    isLoading.value = false;

    debugPrint("server response $serverResponse");
    if (data["status"] == true) {
      P_VerifyDataList.value = P_loginDataModel.fromJson(data);
      Get.to(const WADashboardScreen());
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String encoded = stringToBase64.encode(P_VerifyDataList.value.adhaarNumber!);      // dXNlcm5hbWU6cGFzc3dvcmQ=
      uAdhar = stringToBase64.decode(P_VerifyDataList.value.adhaarNumber!);
      uPan = stringToBase64.decode(P_VerifyDataList.value.panNumber!);
    } else {
      print(data['message'].toString());
      PopUp.toastMessage(data['message'].toString());
    }
  }

  void resendOtpApi(String endpoint) async {
    isLoading.value = true;
    Map requestData = {
      "mobile": loginId,
    };

    var serverResponse = await ApiServices.post((requestData), endpoint);

    var data = json.decode(serverResponse);

    isLoading.value = false;

    debugPrint("server response $serverResponse");
    if (data["status"] == "S") {
      PopUp.toastMessage(data['message'].toString());
    } else {
      PopUp.toastMessage(data['message'].toString());
    }
  }

  void forgotPasswordApi() async {
    isLoading.value = true;
    Map requestData = {
      'method': 'forgot',
      'UserID': fMobileNumberController.text,
      'Tpin': tPinPaymentCOntroller.text,
      'Type': 'P',
    };

    var serverResponse = await ApiServices.post((requestData), "");

    var data = json.decode(serverResponse);

    isLoading.value = false;

    debugPrint("server response $serverResponse");
    if (data["Id"] == "Y") {
      Get.to(WALoginScreen());
      PopUp.toastMessage(data['Result'].toString());
    } else {
      PopUp.toastMessage(data['Result'].toString());
    }
  }

  void sendLoginOtpApi() async {
    isLoading.value = true;
    Map requestData = {
      "method": 'appsendotp',
      "loginid": loginIdController.text,
    };

    var serverResponse = await ApiServices.post((requestData), "");
//{\"status\":true,\"statuscode\":\"200\",\"message\":\"OTP successfully sent on registered mobile\"}
    var data = json.decode(serverResponse);
    isLoading.value = false;

    // debugPrint("server response $serverResponse");
    if (data["status"] == true) {
      showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: otpChecklistBottomSheet(context));
        },
      );
    } else {
      PopUp.toastMessage(data['message'].toString());
    }
  }

  void verifyLoginOtpApi() async {
    isLoading.value = true;

    Map requestData = {
      "method": 'appverifyotp',
      "loginid": loginIdController.text,
      "otp": otpController.text,
    };

    var serverResponse = await ApiServices.post((requestData), '');
//{"status":true,"statuscode":"200","message":"OTP Successfully Verified","Id":"1008","ReferId":"APR10692","Mobile":"9891759893","PanNumber":"aHlxc3E4ODl1ZQ==","AdhaarNumber":"NzM4OTEyNjkxMjY0","IsAepsEkycDone":"0","Latitude":"28.681","Longitude":"77.247","isFngTwoFactActive":"0"}
    var data = json.decode(serverResponse);
    isLoading.value = false;

    // debugPrint("server response $serverResponse");
    if (data["status"] == true) {
      loginIdController.clear();
      otpController.clear();
      P_VerifyDataList.value = P_loginDataModel.fromJson(data);
      Get.to(const WADashboardScreen());
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String encoded = stringToBase64.encode(P_VerifyDataList.value.adhaarNumber!);      // dXNlcm5hbWU6cGFzc3dvcmQ=
      uAdhar = stringToBase64.decode(P_VerifyDataList.value.adhaarNumber!);
      uPan = stringToBase64.decode(P_VerifyDataList.value.panNumber!);
    } else {
      print(data['message'].toString());
      PopUp.toastMessage(data['message'].toString());
      // Get.to(WABeneficiaryList(), arguments: {'serverResponse': serverResponse});
    }
  }

  void getProfile() async {
    isLoading.value = true;
    Map requestData = {
      "method": "getprofile",
      "userid": P_loginDataList.value.referId,
    };

    var serverResponse = await ApiServices.post((requestData),"");

    var data = json.decode(serverResponse);

    // await LogUtil.log('Server Response: $serverResponse');

    isLoading.value = false;

    // loginId = loginIdController.text;
    password = passwordController.text;

    debugPrint("server response $serverResponse");

    // loginIdController.clear();
    // passwordController.clear();
    if (data["status"] == true) {
      P_loginDataList.value = P_loginDataModel.fromJson(data);

      PopUp.toastMessage(data['message'].toString());

      if(isChecked == true){
        sendLoginOtpApi();
      }else{
        Get.to(const WAVerificationScreen());
      }

    } else {
      print(data['message'].toString());
      PopUp.toastMessage(data['message'].toString());
    }
  }

  void getUserBalance() async {
    isLoading.value = true;
    Map requestData = {
      'method': 'getbalance',
      "userid": P_loginDataList.value.referId,
    };

    var serverResponse = await ApiServices.post((requestData),"");

    var data = json.decode(serverResponse);

    isLoading.value = false;

    debugPrint("server response $serverResponse");

    getUserBalanceList.value = getUserBalanceModel.fromJson(data);

    print(getUserBalanceList.value.walletBalance);
  }

  String dateStart = "2023-11-13";
  String dateEnd = "2023-12-14";

  void getuserTxnApi(String endpoint) async {
    isLoading.value = true;
    Map requestData = {
      'start': '0',
      'limit': '50',
      'startDate': dateStart,
      'endDate': dateEnd,
    };

    var serverResponse = await ApiServices.post((requestData), endpoint);

    var data = json.decode(serverResponse);

    isLoading.value = false;

    debugPrint("server response $serverResponse");
    if (data["status"] == "S") {
      walletList.value = walletBallenceModel.fromJson(data);
      walletListData.value = walletList.value.walletdata!;
      walletBackUpList.value = walletList.value.walletdata!;

      // Get.to(WalletTxn());

      PopUp.toastMessage(data['message'].toString());
    } else {
      PopUp.toastMessage(data['message'].toString());
    }
  }

  int totalBene = 0;

// DMT Service Integration .......................................
//
//   String verifyBeneName = "";
//   String referenceKey = "";
//   String otpReferenceKey = "";
//   String aadhaarBase64encryption = "";
//   String adharNumber= "";
//
//   void checkRemitter() async {
//     isLoading.value = true;
//
//     Map requestData = {
//       "dmt": 'getRemitterinfo',
//       "mobile": remitterController.text,
//       "USERID": P_loginDataList.value.referId!,
//     };
//
//     var serverResponse = await ApiServices.post_DMT((requestData));
//
//     var data = jsonDecode(serverResponse);
//
//     reNumber = remitterController.text;
//
//     isLoading.value = false;
//
//     debugPrint("server response $serverResponse");
//     if (data["statuscode"] == "TXN") {
//       BeneFiName = data['Name'].toString();
//       Benelimit = data['Limit'].toString();
//
//       // Get.to(WABeneficiaryList());
//       getDMTBeneListApi();
//       remitterController.clear();
//     } else {
//       isVisibleAdhar.value = true;
//       isVisible_sentOtpbtn.value = true;
//       isEnableNumber.value = false;
//       referenceKey = data['data']['referenceKey'].toString();
//       print(data['status'].toString());
//     }
//   }
//
//   void getDMTBeneListApi() async {
//     isLoading.value = true;
//
//     Map requestData = {
//       "dmt": 'getRemitterinfo',
//       "mobile": reNumber,
//       "USERID": P_loginDataList.value.referId,
//     };
//
//     var serverResponse = await ApiServices.post_DMT((requestData));
// //'{"statuscode":"TXN","actcode":null,"status":"Success","data":{"mobileNumber":"6307565384","firstName":"Dilshan","lastName":"Gautam","city":"","pincode":"201301","limitPerTransaction":5000,"limitTotal":"25000.00","limitConsumed":"0.00","limitAvailable":"25000.00","limitDetails":{"maximumDailyLimit":"25000.00","consumedDailyLimit":"0.00","availableDailyLimit":"25000.00","maximumMonthlyLimit":"25000.00","consumedMonthlyLimit":"0.00","availableMonthlyLimit":"25000.00"},"beneficiaries":[{"id":"130b3e8469926740779fdfc6cd2b2ccc","name":"MR DILSHAN GAUTAM","account":"37899886807","ifsc":"SBIN0000001","bank":"STATE BANK OF INDIA","beneficiaryMobileNumber":"8826921042","verificationDt":"2024-08-07 11:45:20"}],"isTxnOtpRequired":true,"isTxnBioAuthRequired":false,"validity":"2024-11-28 14:48:23","referenceKey":"N2zuxYQwLkWoh6IAexFffbHW5Nkv6wg9eneCGgqUEV1Y7skowmxWsQMc6R0PxuLs"},"timestamp":"2024-11-28 14:33:23","ipay_uuid":"h0009d988912-722e-40e4-b74b-ec18e623fb22-habjq8gMJSA8","orderid":null,"environment":"LIVE","internalCode":null}'
//     var data = json.decode(serverResponse);
//
//     isLoading.value = false;
//
//     // debugPrint("server response $serverResponse");
//     if (data["statuscode"] == "TXN") {
//       dmtBeneModel.value = beneDMT.DMTBeneDataModel.fromJson(data);
//       dmtBeneData.value = dmtBeneModel.value.data!;
//       getDMTBene.value = dmtBeneData.value.beneficiaries!;
//       BeneFiName = dmtBeneData.value.firstName! + " " + dmtBeneData.value.lastName!;
//       Benelimit = dmtBeneData.value.limitAvailable!;
//       referenceKey = data['data']['referenceKey'].toString();
//       Get.to(WABeneficiaryList());
//       remitterController.clear();
//     } else if (data["Status"] == "N") {
//       referenceKey = data['data']['referenceKey'].toString();
//       Get.to(WABeneficiaryList(),);
//     } else {
//      PopUp.toastErrorMessage(data['status']);
//       isVisible.value = true;
//     }
//   }
//
//   void createDMTSenderAPi() async {
//     isLoading.value = true;
//
//     Map requestData = {
//       'dmt': 'RemitterRegister',
//       'MobileNumber': reNumber,
//       'encryptedAadhaar': adharNumber,
//       'referenceKey': referenceKey,
//       'loginID': 'APR10007'
//     };
//
//     var serverResponse = await ApiServices.post_DMT((requestData));
//
//
// //{"statuscode":"OTP","actcode":null,"status":"OTP Successfully sent","data":{"validity":"2024-11-25 12:28:49","referenceKey":"Ho0gvSAIuIYM85BefuVgXcMEYdEhzqYasnEPimra/Bm0tmBV4CFDPBBKR2HUo5Dz.v2.356344db126c8fda-edad-454a-b2b3-dc91add23733"},"timestamp":"2024-11-25 11:28:54","ipay_uuid":"h0009d923e24-71bf-4562-b4a9-200259ab35fd-GsDiOxHpsJu6","orderid":null,"environment":"LIVE","internalCode":null}
//     var data = json.decode(serverResponse);
//
//     isLoading.value = false;
//
//     // debugPrint("server response $serverResponse");
//     if (data["statuscode"] == "OTP") {
//       otpReferenceKey = data['data']['referenceKey'].toString();
//       PopUp.toastMessage(data['status'].toString());
//
//       isVisible_sentOtpbtn.value = false;
//       isEnableAadhaar.value = false;
//       isVisibleOtp.value = true;
//       isVisibleOtpVerify.value = true;
//     } else {
//       PopUp.alertMessage(data['status'].toString());
//       adharController.clear();
//     }
//   }
//
//   void verifyDMTSenderApi() async {
//     if (remmitterOtpPin.length < 6) {
//     } else {
//       Map requestData = {
//         "dmt": 'RemitterOTPverify',
//         "MobileNumber": reNumber,
//         "otpref": otpReferenceKey,
//         "otp": remmitterOtpPin,
//         "loginID": P_loginDataList.value.referId
//       };
//
//       var serverResponse = await ApiServices.post_DMT(requestData);
// //{"statuscode":"KYC","actcode":null,"status":"Mobile validated successfully please proceed for kyc","data":{"validity":"2024-11-25 11:42:12","referenceKey":"ZGyDJjfdElDxnIslhTbGI0jOnH+flJj9KlHYLx6QE+c45GOcKUxkMvG5gCIf87uJ.v2.f63c4e87MjQzMjYxMjQzMTMyMjQ1MTU4NjgyZTZmNzc2OTRhMzA3NTc4NjU3YTYzN2E0ZjU4MzQ2NjVhNTA2NTM1NjU0MTM0Nzk2YTdhNjEzNDZjNTE2OTZmMmU2NjM3MzE0ODRkNTg3NzM0NzAzNjQ2NGI3YTU4MmY2YzRi"},"timestamp":"2024-11-25 11:37:17","ipay_uuid":"h0009d924123-685b-4ba8-826b-be3bfd6cbe5f-YKgYYVE4TuGp","orderid":null,"environment":"LIVE","internalCode":null}
//       var data = json.decode(serverResponse);
//       pinController.clear();
//
//       if (data["statuscode"] == "KYC") {
//         otpReferenceKey = "";
//         isVisibleOtp.value = false;
//         isVisibleOtpVerify.value = false;
//         isVisible_KYC.value = true;
//         otpReferenceKey = data['data']['referenceKey'].toString();
//         pinController.clear();
//         PopUp.toastMessage(data['status'].toString());
//         // Get.to(WABeneficiaryList());
//       } else {
//         PopUp.toastMessage(data['status'].toString());
//       }
//     }
//   }
//
//   void remitterKYCDMTSenderAPi() async {
//     isLoading.value = true;
//
//     Map requestData = {
//       "dmt": 'RemitterKYC',
//       "MobileNumber": reNumber,
//       "UserIP": P_loginDataList.value.referId,
//       "lat": latDynamic,
//       "long": longDynamic,
//       "referenceKey": otpReferenceKey,
//       "biometricData": base64FingerXml,
//     };
//
//     var serverResponse = await ApiServices.post_DMT(requestData);
// //{"statuscode":"ERR","actcode":null,"status":"Sorry Aadhaar number and biometric scan did not match. Please try again. Please clean device surface. Inform customer to clean hands or try different finger. Please try again.Error CodeGetUserAadhaa","data":null,"timestamp":"2024-12-05 10:52:04","ipay_uuid":"h0009da64ecb-a7be-4aae-8842-a9a2d9e178f3-7cJUIffltplk","orderid":null,"environment":"LIVE","internalCode":null}
//     //{"statuscode":"TXN","actcode":null,"status":"Transaction Successful","data":{"poolReferenceId":"1241209134749EKKUS","pool":{"account":"9891759893","openingBal":"414655.44","mode":"DR","amount":"10.00","closingBal":"414645.44"}},"timestamp":"2024-12-09 13:47:49","ipay_uuid":"h0009dae9996-a008-4a65-bbe9-429182899829-LMScnayi1PWc","orderid":"1241209134749EKKUS","environment":"LIVE","internalCode":null}
//     var data = json.decode(serverResponse);
//
//     isLoading.value = false;
//
//     // debugPrint("server response $serverResponse");
//     if (data["statuscode"] == "TXN") {
//       otpReferenceKey = data['data']['referenceKey'].toString();
//       PopUp.toastMessage(data['status'].toString());
//       Get.back();
//       getDMTBeneListApi();
//       isVisible.value = false;
//       remitterController.clear();
//       adharController.clear();
//       isEnableNumber.value = true;
//       isEnableAadhaar.value= true;
//       isEnableName.value = true;
//       isVisibleOtp.value = false;
//       isVisibleOtpVerify.value = false;
//       isVisibleName.value = false;
//       isVisible_sentOtpbtn.value = false;
//       isVisibleAdhar.value= false;
//       isVisible_KYC.value = false;
//     } else {
//       PopUp.alertMessage(data['status'].toString());
//     }
//   }
//
//   var benefiId = "";
//
//   void addDmtBeneficiaryApi() async {
//     isLoading.value = true;
//
//     Map requestData = {
//       'dmt': 'BeneficiaryRegi',
//       'remitterNumber': reNumber,
//       'beneName': verifyBeneName,
//       'ifscCode': bankIfsc,
//       'accountNumber': beneAccount.text,
//       'bankId': bankId,
//       'loginID': P_loginDataList.value.referId,
//     };
//
//     var serverResponse = await ApiServices.post_DMT((requestData));
// //{"statuscode":"OTP","actcode":null,"status":"OTP Successfully sent","data":{"beneficiaryId":"12a12d972aba35ec41226057a50c6123","validity":"2024-12-09 16:11:26","referenceKey":"hd2OcvBYrEiBxBSjT9oa/AeQX4EoF+U4y7j+Tb8r8r4SczGhWXvnYmvu4Nt5ZGSu"},"timestamp":"2024-12-09 15:56:26","ipay_uuid":"h0009daec799-8e75-42bc-9dea-8d9dac586943-Hhj54Igl9a0i","orderid":null,"environment":"LIVE","internalCode":null}
//     var data = json.decode(serverResponse);
//
//     isLoading.value = false;
//
//     debugPrint("server response $serverResponse");
//
//     beneAccount.clear();
//     beneIfscCode.clear();
//     benMobile.clear();
//     beneName.clear();
//
//     if (data["statuscode"] == "OTP") {
//       benefiId = data['data']['beneficiaryId'].toString();
//       otpReferenceKey = data['data']['referenceKey'].toString();
//       TextEditingController otpPController = TextEditingController();
//       Get.defaultDialog(
//         title: "Confirm Action",
//         backgroundColor: Colors.white,
//         titleStyle: TextStyle(color: Colors.red),
//         content: Column(
//           children: [
//             Text(
//               "Enter OTP to confirm:",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             PinCodeTextField(
//               appContext: Get.context!,
//               length: 6, // Number of OTP digits
//               obscureText: false,
//               keyboardType: TextInputType.number,
//               animationType: AnimationType.fade,
//               pinTheme: PinTheme(
//                 shape: PinCodeFieldShape.box,
//                 borderRadius: BorderRadius.circular(5),
//                 fieldHeight: 50,
//                 fieldWidth: 40,
//                 activeFillColor: Colors.white,
//                 activeColor: Colors.grey,
//                   inactiveColor: Colors.grey,
//                 inactiveFillColor: Colors.white,
//               ),
//               animationDuration: Duration(milliseconds: 300),
//               enableActiveFill: true,
//               controller: otpPController,
//               onChanged: (value) {
//                 print("Current OTP: $value");
//               },
//               onCompleted: (value){
//                 finel_pin = value;
//               },
//             ),
//           ],
//         ),
//         textConfirm: "OK",
//         textCancel: "Cancel",
//         buttonColor: Colors.grey,
//         cancelTextColor: Colors.black,
//         confirmTextColor: Colors.white,
//         onConfirm: () {
//           if (finel_pin.isNotEmpty) {
//             verifyDmtAccountApi();
//             print("OTP Entered: $finel_pin");
//           } else {
//             Get.snackbar("Error", "Please enter the OTP");
//           }
//         },
//         onCancel: () {
//           Get.back(); // Close the dialog when canceled
//         },
//       );
//     } else {
//       verifyBeneName = "";
//       print(data['message'].toString());
//       PopUp.alertMessage(data['message'].toString());
//     }
//   }
//
//   void verifyDmtAccountApi() async {
//     isLoading.value = true;
//
//     Map requestData = {
//       'dmt': 'BeneficiaryRegiVerify',
//       'MobileNumber': reNumber,
//       'Otp': finel_pin,
//       'BeneficiaryId': benefiId,
//       'referenceKey': otpReferenceKey,
//       'users': P_loginDataList.value.referId,
//     };
//
//     var serverResponse = await ApiServices.post_DMT((requestData));
// //{"statuscode":"TXN","actcode":null,"status":"Transaction Successful","data":{"beneficiaryId":"12a12d972aba35ec41226057a50c6123"},"timestamp":"2024-12-09 15:53:42","ipay_uuid":"h0009daec6a0-78e0-4816-94e3-c829fa1a1e73-XZPgVP0Dia2f","orderid":null,"environment":"LIVE","internalCode":null}
//     var data = json.decode(serverResponse);
//
//     isLoading.value = false;
//
//     // debugPrint("server response $serverResponse");
//     if (data["statuscode"] == "TXN") {
//       Get.back();
//       getDMTBeneListApi();
//
//     } else {
//       PopUp.toastMessage(data['message'].toString());
//     }
//   }
//
//   void verifyDmtBeneficiaryAccountApi(String endpoint) async {
//     isLoading.value = true;
//
//     Map requestData = {
//       'beneId': benId,
//     };
//
//     var serverResponse = await ApiServices.post((requestData), endpoint);
//
//     var data = json.decode(serverResponse);
//
//     isLoading.value = false;
//
//     debugPrint("server response $serverResponse");
//     if (data["status"] == "S") {
//       print(data['message'].toString());
//       PopUp.toastMessage(data['message'].toString());
//       getDMTBeneListApi();
//     } else {
//       print(data['message'].toString());
//       PopUp.alertMessage(data['message'].toString());
//     }
//   }
//
//   void deleteDmtBeneficiaryAccountApi(String endpoint) async {
//     isLoading.value = true;
//
//     Map requestData = {'beneId': benId, 'senderMobile': reSenderMobile};
//
//     var serverResponse = await ApiServices.post((requestData), endpoint);
//
//     var data = json.decode(serverResponse);
//
//     isLoading.value = false;
//
//     debugPrint("server response $serverResponse");
//     if (data["status"] == "S") {
//       print(data['message'].toString());
//       PopUp.toastMessage(data['message'].toString());
//       getDMTBeneListApi();
//     } else {
//       print(data['message'].toString());
//       PopUp.toastErrorMessage(data['message'].toString());
//     }
//   }
//

  paymentStatusShow() {
    if (paymentStatus == "S") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/success.gif",
            height: MediaQuery.of(Get.context!).size.height * 0.18,
          ),
          Expanded(
            child: Text(
              paymentMessage,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else if (paymentStatus == "F") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/failed.gif",
            height: 100,
          ),
          Text(
            paymentMessage,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      ).paddingAll(10);
    } else if (paymentStatus == "P") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.access_time,
            size: 100,
            color: Colors.amber,
          ),
          Text(
            paymentMessage,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.orange),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }


  // PayOut Dmt API integration ............


  void getDMTBankListApi() async {
    isLoading.value = true;

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    var request = http.Request('GET', Uri.parse('http://dmt.instant.payimps.in/dmt_payes.aspx'));

    request.bodyFields = {
      'dmt': 'Banklist',
      'mobile': reNumber,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String serverResponse = await response.stream.bytesToString();
    var data = json.decode(serverResponse);

    isLoading.value = false;

    if(data['statuscode'] == "TXN"){
      dmtBankListModel.value = dmt.DMTBankListModel.fromJson(data);
      dmtBankList.value = dmtBankListModel.value.data!;
    }else {
      PopUp.toastMessage(data['responseMessage'].toString());
    }
  }

//   void  getDMTBankVerifyApi() async {
//     isLoading.value = true;
//
//     var headers = {
//       'Content-Type': 'application/x-www-form-urlencoded'
//     };
//
//     var request = http.Request('GET', Uri.parse('http://dmt.instant.payimps.in/dmt_payes.aspx'));
//
//     request.bodyFields = {
//       'dmt': 'VerifyDetails',
//       'account': beneAccount.text,
//       'ifsc': bankIfsc,
//       'remitterNumber': reNumber,
//       'bankid': bankId!,
//       'userid': P_loginDataList.value.referId!,
//     };
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     String serverResponse = await response.stream.bytesToString();
//     var data = json.decode(serverResponse);
// //{"message":"Success!  Beneficiary account details found.SUCCESS","response_type_id":61,"response_status_id":-1,"status":0,"data":{"account":"37899886807","bank":"109005","recipient_name":"Mr. Dilshan  Gautam","is_name_editable":null,"tid":"APR1000744145067519112","amount":0,"fee":0,"is_ifsc_required":null,"ifsc":null,"aadhar":null}}
//     isLoading.value = false;
//
//     if(data['message'].contains("Success")){
//       beneName.text = data['data']['recipient_name'].toString();
//       verifyBeneName = data['data']['recipient_name'].toString();
//       acVerifyStatus = "0";
//     }else {
//       PopUp.toastMessage(data['message'].toString());
//     }
//   }



  //  Recharge Api Integration .......................................................

  rechargePlanData() {
    if (planStatus == "S") {
      return ListView.builder(
        itemCount: getPlanListData.value.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10,
            child: ListTile(
                onTap: () {
                  Get.back(result: getPlanListData.value[index]);
                  // ReAmount = getPlanListData.value[index].rs!.toString();
                  // Get.to(paymentPage());
                },
                title: Text(
                  "₹ ${getPlanListData.value[index].rs ?? 'N/A'}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),

                subtitle: Text(
                  'Validity: ${getPlanListData.value[index].desc!.toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.black),
                ),
                trailing: const Icon(Icons.arrow_forward_ios))
                .paddingAll(10),
          );
        },
      );
    } else {
      return Container(
        child: const Center(
            child: Text(
              "No Data Found !!",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      );
    }
  }

  rechargeDsc() {
    if (paymentStatus == "S") {
      return const Text(
        'Your recharge completed successfully ',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ).paddingAll(10);
    } else if (paymentStatus == "P") {
      return const Text(
        'In case money is debited, It will be settled in 24 hr.',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ).paddingAll(10);
    } else {
      return const Text(
        'In case money is debited, It will be settled in 24 hr.',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ).paddingAll(10);
    }
  }

  // Recharge Api integration ..................

  void getRechargeOperatorApi(String endpoint) async {
    Map requestData = {
      "method": "getproviderspm",
      "type": "1",
      "loginid": P_loginDataList.value.referId!,
    };

    var serverResponse = await ApiServices.post_Recharge(requestData, endpoint);

    var data = json.decode(serverResponse);

    isLoading.value = false;
    print(data);

    dthProviderList.clear();
    List<dynamic> providerList = data;
    for (var providerData in providerList) {
      dthProviderList.add(RechargeOperatorDataModel.fromJson(providerData));
    }

    print(dthProviderList[0].providerName);

  }

  void getDTHOperatorApi() async {
    Map requestData = {
      "method": "getprovider",
      "type": "3",
      "loginid": P_loginDataList.value.referId!,
    };

    var serverResponse = await ApiServices.post_Recharge(requestData,"");

    var data = json.decode(serverResponse);

    isLoading.value = false;

    List<dynamic> providerList = data;
    dthProviderList.clear();
    for (var providerData in providerList) {
      dthProviderList.add(RechargeOperatorDataModel.fromJson(providerData));
    }

    print(dthProviderList[0].providerName);

    debugPrint("server response $serverResponse");
    if (data["status"] == "P") {
    } else {
      print(data['message'].toString());
    }
  }
  void rechargeViewPlan() async {
    isLoading.value = true;
    Map requestData = {
      'method':"getPlanNew",
      'mobile': MobileNumber,
      'type':MobileNumber,
      'Operater': operator,
    };

    var serverResponse = await ApiServices.post_Recharge(requestData, '');

    var data = json.decode(serverResponse);

    isLoading.value = false;

    planStatus = data['status'].toString();

    if (data['records'].toString().isNotEmpty) {
      planStatus = "S";
      getPlanList.value = getPlanDataModel.fromJson(data);
      getPlanListData.value = getPlanList.value.records!;
      getPlanListBackup.value = getPlanList.value.records!;
      PopUp.toastMessage(data['message'].toString());
    } else {
      // Get.to(MobileRecharge());
      PopUp.alertMessage(data['message'].toString());
      PopUp.toastMessage(data['message'].toString());
    }
  }

  void getDTHPlan() async {
    isLoading.value = true;

    Map requestData = {
      'method':"getdthPlan",
      'mobile': MobileNumber,
      'type':MobileNumber,
      'Operater': operator,
    };

    var serverResponse = await ApiServices.post_Recharge(requestData, '');

    var data = json.decode(serverResponse);

    isLoading.value = false;

    planStatus = data['status'].toString();

    if (data['records'].toString().isNotEmpty) {
      planStatus = "S";
      getPlanList.value = getPlanDataModel.fromJson(data);
      getPlanListData.value = getPlanList.value.records!;
      getPlanListBackup.value = getPlanList.value.records!;
      PopUp.toastMessage(data['message'].toString());
    } else {
      // Get.to(MobileRecharge());
      PopUp.alertMessage(data['message'].toString());
      PopUp.toastMessage(data['message'].toString());
    }
  }
  void mobileRechargeApi(String endpoint) async {
    isLoading.value = true;
    Map requestData = {
      'method': 'recharge',
      'loginid': P_loginDataList.value.referId!,
      'mobile': MobileNumber,
      'provider': operator,
      'ttype': "TPP",
      'Service': "MOBILE",
      'amount': ReAmount,
    };

    var serverResponse = await ApiServices.post_Recharge(requestData, endpoint);
    // var serverResponse = "";
    var data = json.decode(serverResponse);
    // {\"Id\":\"P\",\"Result\":\"Transaction Successfull - RCH1000708110440396165,\\"REQUESTTXNID\\":\\"RCH1000708110440396165\\"\"}

    isLoading.value = false;
    mobileNumberController.clear();
    mobileAmountController.clear();
    mobileOperatorController.clear();
    if (data['Id'] == "P" || data['Id'] == "S") {
      paymentStatus = "S";
      List<String> parts = data['Result'].toString().split(":");
      List<String> parts1 = parts[0].split("-");
      paymentMessage = parts1[0];
      txnId = parts[1];
      Get.to(const RechargeSuccessPage());
      PopUp.toastMessage(data['Result'].toString());
    } else {
      paymentStatus = "F";
      List<String> parts = data['Result'].toString().split(":");
      List<String> parts1 = parts[0].split("-");
      paymentMessage = parts1[0];
      Get.to(const RechargeSuccessPage());
      PopUp.toastErrorMessage(data['Result'].toString());
    }

  }


  String dthmode  = "";
  String service = "";
  String txnDate = "";
  String txnId = "";
  String planStatus = "";



  // BBPS Api Integration Start Here ...................

  // offline bbps ...................

  void getOffCategoryListApi() async {
    isLoading.value = true;
    var request = http.Request('GET', Uri.parse('http://api.payimps.in/recApiFinal/apiget.aspx?method=getbbpsproviders&t=0'));

    http.StreamedResponse response = await request.send();

    String serverResponse = await response.stream.bytesToString();

    if(serverResponse.isNotEmpty || serverResponse != ""){
      var data = json.decode(serverResponse);

      isLoading.value = false;

      List<dynamic> providerList = data;
      getCategoryList.value.clear();
      for (var providerData in providerList) {
        getCategoryList.value.add(subCategoryDataModel.fromJson(providerData));
      }

    }else{
      isLoading.value = false;
      PopUp.toastErrorMessage("Internal server error !!");
    }
    print(getCategoryList[0].providerName);
  }

  void getOffSubCatApi() async {
    isLoading.value = true;

    var request = http.Request('GET', Uri.parse('https://api.v1.pedhapay.com/recApiFinal/bbpsget.aspx?method=getbbpsproviders&t=$serviceId'));

    http.StreamedResponse response = await request.send();

    String serverResponse = await response.stream.bytesToString();

    if(serverResponse.isNotEmpty || serverResponse != ""){
      var data = json.decode(serverResponse);

      isLoading.value = false;

      List<dynamic> providerList = data;
      getSubCategoryList.value.clear();
      for (var providerData in providerList) {
        getSubCategoryList.value.add(subCategoryDataModel.fromJson(providerData));
      }
      print(getSubCategoryList[0].providerName);
    }else{
      isLoading.value = false;
      PopUp.toastErrorMessage("Internal server error !!");
    }

  }

  void offBillFetchApi() async {
    isLoading.value = true;

    var request = http.Request('GET', Uri.parse('https://api.v1.pedhapay.com/recApiFinal/bbpsget.aspx?method=fetchbillapp&AccountId=$bbpsfirstField&id=${selectedSubCategoryList.value[0].providerId}&mobile=$bbpsSecondField'));

    http.StreamedResponse response = await request.send();

    String serverResponse = await response.stream.bytesToString();
    // {"success":false,"data":null,"message":{"code":"703","text":"We are facing issue with the biller, regret for inconvenience. Kindly try after sometime."}}
    // {"success":true,"data":[{"billAmount":"25093.0","billnetamount":"25093.0","billdate":"09 Dec 2024","dueDate":"2024-12-16","acceptPayment":true,"acceptPartPay":true,"cellNumber":"8831455000","userName":"TIHUL"}],"message":null}
    var data = json.decode(serverResponse);

    billerNumber = fieldNameController.text;
    isLoading.value = false;

    if (data['success'] == "true" || data['success'] == true) {

      isVisiblePaymentBtn.value = true;
      billFetchModel.value = bill.billFetchDataModel.fromJson(data);
      billFechList.value = billFetchModel.value.data!;

      amountController.text = billFechList.value[0].billAmount!;

      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.all(10), // Apply 5 pixels padding here
            content: Container(
              child: Obx(() {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Close Icon
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.close,
                            color: Theme.of(context).colorScheme.primary,
                            size: 24,
                          ),
                        ),
                      ),

                      // Header
                      Center(
                        child: Text(
                          "Bill Details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Provider Name
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            selectedSubCategoryList.value[0].providerName ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Bill Information
                      ...[
                        _buildRow(context, "Name", billFechList.value[0].userName),
                        _buildRow(context, "Account No.", billFechList.value[0].cellNumber),
                        _buildRow(context, "Bill Date", billFechList.value[0].billdate),
                        _buildRow(context, "Due Date", billFechList.value[0].dueDate),
                        _buildRow(context, "Amount", "₹ ${billFechList.value[0].billAmount}", partablePay: billFechList.value[0].acceptPartPay!,controller: amountController),
                      ],
                      const SizedBox(height: 30),

                      // Payment Button
                      AppButton(
                        color: Theme.of(context).colorScheme.primary,
                        textColor: Colors.white,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: MediaQuery.of(context).size.width,
                        onTap: isLoading.value ? null : () {
                          dateAccess();
                          if(amountController.text.isNotEmpty){
                            if(bbpsService.value == "online"){
                              bbpsApiType = "2";
                              offBillPaymentApi();
                            }else{
                              bbpsApiType = "1";
                              offBillPaymentApi();
                            }

                          }else{
                            Get.snackbar(
                              "Validation Error",
                              "Please enter amount",
                              snackPosition: SnackPosition.TOP,
                            );
                          }

                        },
                        child: isLoading.value
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                            : const Text(
                          'Payment',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ).paddingSymmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                    ],
                  ),
                );
              }),
            ),
          );
        },
      );
    } else {
      fieldNameController.clear();
      fieldNumberController.clear();
      isVisibleFalseMessage.value = true;
      billStatus = data["success"].toString();
      FalseMessage = data['message']['text'].toString();
      PopUp.alertMessage(data['message']['text'].toString());
    }
  }

  String bbpsApiType = "";

  void offBillPaymentApi() async {
    // isLoading.value = true;

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    var request = http.Request('POST', Uri.parse('https://api.v1.pedhapay.com/recApiFinal/service.aspx'));

    request.bodyFields = {
      'method': 'rechargeBBPSPedha',
      'loginid': P_loginDataList.value.referId!,
      'accid': bbpsfirstField,
      'provider': selectedSubCategoryList.value[0].providerId!.toString(),
      'ttype': 'TPP',
      'Service': selectedSubCategoryList.value[0].providerName!,
      'amount': amountController.text,
      'apitype': bbpsApiType,
      'mobile': bbpsSecondField.isNotEmpty? bbpsSecondField:P_loginDataList.value.mobile!,
      'token': "Y",
      'duedate': billFechList.value[0].dueDate!,
    };

    print(request.bodyFields);

    bbpsAmount = amountController.text;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String serverResponse = await response.stream.bytesToString();
//{\"Id\":\"N\",\"Result\":\"Amount for offline bill must be greater than 200 INR - Failed\"}
    var data = json.decode(serverResponse);
    // {\"Id\":\"P\",\"Result\":\"Transaction Pending - BBP100070401105222874,NA\"}
    isLoading.value = false;
    // {\"Id\":\"Y\",\"Result\":\"Transaction Successfull - BBP1000706010447247673,MK015006BAAJJXYWL000\"}
    if (data['Id'] == "Y") {
      paymentStatus = "S";
      List<String> resultParts = data['Result'].split('-');
      paymentMessage = resultParts[0].trim(); // "Transaction Pending"
      txnId = resultParts[1].split(',')[0].trim();
      Get.to(const BBPSSuccessPage(),transition: Transition.leftToRight);
      amountController.clear();
    } else if(data['Id'] == "P"){
      paymentStatus = "P";
      List<String> resultParts = data['Result'].split('-');
      paymentMessage = resultParts[0].trim(); // "Transaction Pending"
      txnId = resultParts[1].split(',')[0].trim();
      Get.to(const BBPSSuccessPage(),transition: Transition.leftToRight);
      amountController.clear();
    } else {
      // fieldNameController.clear();
      // fieldNumberController.clear();
      isVisibleFalseMessage.value = true;
      FalseMessage = data['Result'].toString();
      PopUp.alertMessage(data['Result'].toString());
    }
  }


  Widget _buildRow(BuildContext context, String label, String? value, {bool partablePay = false, TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: partablePay
                ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,  // 50% of screen width
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Enter value",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                ),
              ),
            )
                : Text(
              value ?? 'N/A',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          )

        ],
      ),
    );
  }


  aepsTxnType() {
    if(service == "DMT"){
      return pw.Table(
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text('Sr.No.',
                    style: const pw.TextStyle(
                      // font: ttf,
                    )),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text('Txn Id ',
                    style: const pw.TextStyle(
                      // font: ttf,
                    )),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text('Bank RNN',
                    style: const pw.TextStyle(
                      // font: ttf,
                    )),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text('Status',
                    style: const pw.TextStyle(
                      // font: ttf,
                    )),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text('Amount',
                    style: const pw.TextStyle(
                      // font: ttf,
                    )),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text('1.',
                    style: const pw.TextStyle(
                      // font: ttf,
                    )),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(dmtTxnId,
                    style: const pw.TextStyle(
                      // font: ttf,
                    )),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text("bankRRN!",
                    style: const pw.TextStyle(
                      // font: ttf,
                    )),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(paymentStatus == "S"? "Success":"Failed",
                    style: const pw.TextStyle(
                      // font: ttf,
                    )),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                    dmtAmount,
                    style: const pw.TextStyle(
                      // font: ttf,
                    )),
              ),
            ],
          ),
        ],
      );
    }else{
      if (TxId == "CW") {
        return pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Sr.No.',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Txn Id ',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Bank RNN',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Status',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Amount',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('1.',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(aepsCWResponseData.value.fpTransactionId!,
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(aepsCWResponseData.value.bankRRN!,
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(aepsCWResponseData.value.transactionStatus!,
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                      aepsCWResponseData.value.transactionAmount!.toString(),
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
              ],
            ),
          ],
        );
      } else if (TxId == "MS") {
        return pw.Center(
          child: pw.Column(
            children: [
              pw.Text('Mini Statement',
                  style:
                  pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Table header row
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Date',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Type',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Narration',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Amount',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  // Data rows
                  for (var value in MS_List
                      .value) // Assuming txnDetail.miniStatementTxn is a list of objects
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(value.date.toString()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(value.txnType.toString()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(value.narration.toString()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(value.amount.toString()),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        );
      } else if (TxId == "BBPS") {
        return pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Sr.No.',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Txn Id ',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Bank RNN',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Status',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Amount',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('1.',
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(dmtTxnId,
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(bilfetchListData.value[0].cellNumber!,
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(paymentMessage,
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(bilfetchListData.value[0].billAmount!.toString(),
                      style: const pw.TextStyle(
                        // font: ttf,
                      )),
                ),
              ],
            ),
          ],
        );
      }
    }
  }

  pdfSlip() {
    if (service == "BBPS") {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Invoice',
            style: pw.TextStyle(
              // font: ttf,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text('Transaction ID : $dmtTxnId',
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.Text('Date: ${bilfetchListData.value[0].billdate!}',
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.SizedBox(height: 20),
          pw.Text('Bill From:',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              )),
          pw.Text(userProfileData.value.uMemberId!,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.Text(
              userProfileData.value.uFirstName! +
                  userProfileData.value.uLastName!,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.Text(userProfileData.value.uMobile!,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.Text(userProfileData.value.uEmail!,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.SizedBox(height: 20),
          pw.Text('Bill To:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text(bankName,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.Text(bilfetchListData.value[0].cellNumber!,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.Text('Recipient Address',
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.SizedBox(height: 20),
          aepsTxnType(),
          pw.SizedBox(height: 20),
          pw.Text(
              'Total Amount: ${bilfetchListData.value[0].billAmount!}',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              )),
          pw.SizedBox(height: MediaQuery.of(Get.context!).size.height * 0.2),
        ],
      );
    } else if(service == "DMT"){
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Invoice',
            style: pw.TextStyle(
              // font: ttf,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text('Transaction ID : $dmtTxnId',
              style: const pw.TextStyle(
                // font: ttf,
              )),
          pw.Text('Date: $currentDate',
              style: const pw.TextStyle(
                // font: ttf,
              )),
          pw.SizedBox(height: 20),
          pw.Text('Bill From:',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              )),
          pw.Text(userProfileData.value.uMemberId!,
              style: const pw.TextStyle(
                // font: ttf,
              )),
          pw.Text(
              userProfileData.value.uFirstName! +
                  userProfileData.value.uLastName!,
              style: const pw.TextStyle(
                // font: ttf,
              )),
          pw.Text(userProfileData.value.uMobile!,
              style: const pw.TextStyle(
                // font: ttf,
              )),
          pw.Text(userProfileData.value.uEmail!,
              style: const pw.TextStyle(
                // font: ttf,
              )),
          pw.SizedBox(height: 20),
          pw.Text('Bill To:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text(benName,
              style: const pw.TextStyle(
                // font: ttf,
              )),
          pw.Text(beneBankName,
              style: const pw.TextStyle(
                // font: ttf,
              )),
          pw.Text(beneAccountNumber,
              style: const pw.TextStyle(
                // font: ttf,
              )),
          pw.Text(beneIfsc,
              style: const pw.TextStyle(
                // font: ttf,
              )),
          pw.Text('Recipient Address',
              style: const pw.TextStyle(
                // font: ttf,
              )),
          pw.SizedBox(height: 20),
          aepsTxnType(),
          pw.SizedBox(height: 20),
          pw.Text('Total Amount: $dmtAmount',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              )),
          pw.SizedBox(height: MediaQuery.of(Get.context!).size.height * 0.2),
        ],
      );
    }
    else {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Invoice',
            style: pw.TextStyle(
              // font: ttf,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
          pw.SizedBox(height: 10),
          // pw.Text(
          //     'Transaction ID : ' + aepsCWResponseData.value.merchantTransactionId, style: const pw.TextStyle(
          //         // font: ttf,
          //         )),
          pw.Text('Date: ${aepsCWResponseData.value.requestTransactionTime!}',
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.SizedBox(height: 20),
          pw.Text('Bill From:',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              )),
          pw.Text(userProfileData.value.uMemberId!,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.Text(
              userProfileData.value.uFirstName! +
                  userProfileData.value.uLastName!,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.Text(userProfileData.value.uMobile!,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.Text(userProfileData.value.uEmail!,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.SizedBox(height: 20),
          pw.Text('Bill To:',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              )),
          pw.Text(bankName,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.Text(aepsCWResponseData.value.bankRRN!,
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.Text('Recipient Address',
              style: const pw.TextStyle(
                  // font: ttf,
                  )),
          pw.SizedBox(height: 20),
          aepsTxnType(),
          pw.SizedBox(height: 20),
          pw.Text(
              'Total Amount: ${aepsCWResponseData.value.transactionAmount!}',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              )),
          pw.SizedBox(height: MediaQuery.of(Get.context!).size.height * 0.2),
          // pw.InkWell(
          //   onTap: () {
          //     // Handle tap event
          //     print('Container tapped');
          //     // Implement the desired action here
          //   },
          //   child: pw.Center(
          //     child: pw.Container(
          //       decoration: pw.BoxDecoration(
          //         color: PdfColors.grey,
          //         borderRadius: pw.BorderRadius.circular(10),
          //       ),
          //       padding: pw.EdgeInsets.all(20),
          //       child: pw.Text('Share', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf)),
          //     ),
          //   ),
          // ),
        ],
      );
    }
  }

  // Future<File> generateInvoice() async {
  //   final fontData = await rootBundle
  //       .load("assets/fonts/OpenSans-VariableFont_wdth,wght.ttf");
  //   // final ttf = pw.Font.ttf(fontData);
  //
  //   //
  //   // final image = pw.MemoryImage(
  //   //   (await rootBundle.load('assets/appLogo.png')).buffer.asUint8List(),
  //   // );
  //
  //   final pdf = pw.Document();
  //
  //   // Add a page to the PDF
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pdfSlip();
  //       },
  //     ),
  //   );
  //
  //   // Save the PDF to a file
  //   final output = await getTemporaryDirectory();
  //   final file = File("${output.path}/invoice.pdf");
  //   await file.writeAsBytes(await pdf.save());
  //
  //   // Share the file
  //   // await Share.shareFiles([file.path], text: 'Here is your generated invoice!');
  //
  //   return file;
  // }


  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  late StreamSubscription<Position> positionStream;

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  String latDynamic = "";
  String longDynamic = "";

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latDynamic = position.latitude.toString();
    longDynamic = position.longitude.toString();
    print(latDynamic);
    print(longDynamic);


    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude);
      print(position.latitude);
    });
  }

  // ALl Leger and Profile Api Integration ..............................

  void changePassApi(String endpoint) async {
    isLoading.value = true;
    Map requestData = {
      'oPassword': oldPassController.text,
      'uPassword': newPassController.text,
      'cpassword': confirmPassController.text
    };

    var serverResponse = await ApiServices.post((requestData), endpoint);

    var data = json.decode(serverResponse);

    isLoading.value = false;

    debugPrint("server response $serverResponse");
    if (data["status"] == "S") {
      oldPassController.clear();
      newPassController.clear();
      confirmPassController.clear();
      PopUp.toastMessage(data['message'].toString());
    } else {
      PopUp.toastMessage(data['message'].toString());
    }
  }

  void changeTPinApi(String endpoint) async {
    isLoading.value = true;
    Map requestData = {
      'method': 'cpass',
      'UserID': P_loginDataList.value.referId,
      'newtpin': newTPinController.text,
      'confrimtpin': confirmTPinController.text,
      'Tpin': oldTPinController.text,
      'ttype': 'TA',
    };

    var serverResponse = await ApiServices.post((requestData), endpoint);

    var data = json.decode(serverResponse);

    isLoading.value = false;

    debugPrint("server response $serverResponse");
    if (data["Id"] == "Y") {
      oldTPinController.clear();
      newTPinController.clear();
      confirmTPinController.clear();
      PopUp.toastMessage(data['Result'].toString());
    } else {
      oldTPinController.clear();
      newTPinController.clear();
      confirmTPinController.clear();
      PopUp.toastErrorMessage(data['Result'].toString());
    }
  }

  void serviceHistory(String endpoint) async {
    isLoading.value = true;
    Map requestData = {
      'method': historyMethod,
      'loginid': P_loginDataList.value.referId,
      'fromdate': "2022-01-01",
      'todate': currentDate,
      'mobile': ""
    };

    var serverResponse = await ApiServices.post(requestData, endpoint);

    var data = json.decode(serverResponse);

    debugPrint("server response $serverResponse");
    isLoading.value = false;

    List<dynamic> providerList = data;
    serviceTxnList.value.clear();
    serviceTxnFilterList.value.clear(); // Clear existing data
    // txnListBackUp.value.clear();
    for (var providerData in providerList) {
      serviceTxnList.value.add(servicesTxnDataModel.fromJson(providerData));
      // txnListBackUp.value.add(lagerDataModel.fromJson(providerData));
    }
    if(txnMode == "UPI"){
      serviceTxnFilterList.value = serviceTxnList.value.where((transaction) => transaction.service == 'UPI').toList();
      serviceTxnFilterListBackup.value = serviceTxnList.value.where((transaction) => transaction.service == 'UPI').toList();
    }else if(txnMode == "CC"){
      serviceTxnFilterList.value = serviceTxnList.value.where((transaction) => transaction.service == 'CC').toList();
      serviceTxnFilterListBackup.value = serviceTxnList.value.where((transaction) => transaction.service == 'CC').toList();
    } else if(txnMode == "AEPS"){
      serviceTxnFilterList.value = serviceTxnList.value;
      serviceTxnFilterListBackup.value = serviceTxnList.value;
    }else if(txnMode == "DMT"){
      serviceTxnFilterList.value = serviceTxnList.value
          .where((transaction) => transaction.service == 'DMT')
          .toList();
      serviceTxnFilterListBackup.value = serviceTxnList.value
          .where((transaction) => transaction.service == 'DMT')
          .toList();
    }else if(txnMode == 'BBPS'){
      serviceTxnFilterList.value = serviceTxnList.value
          .where((transaction) => transaction.transactionID!.startsWith("BBP")||transaction.transactionID!.startsWith("MK"))
          .toList();
      serviceTxnFilterListBackup.value = serviceTxnList.value
          .where((transaction) => transaction.transactionID!.startsWith("BBP")||transaction.transactionID!.startsWith("MK"))
          .toList();
    }else if(txnMode == "LIC"){
      serviceTxnFilterList.value = serviceTxnList.value
          .where((transaction) => transaction.service == 'LIC')
          .toList();
      serviceTxnFilterListBackup.value = serviceTxnList.value
          .where((transaction) => transaction.service == 'LIC')
          .toList();
    }else if(txnMode == "Mobile"){
      serviceTxnFilterList.value = serviceTxnList.value.where((transaction) => transaction.service == 'MOBILE').toList();
      serviceTxnFilterListBackup.value = serviceTxnList.value.where((transaction) => transaction.service == 'MOBILE').toList();
    }
  }

  void servicesHistoryDateApi(String endpoint) async {
   isLoading.value = true;

    Map requestData = {
      'method': historyMethod,
      'loginid': P_loginDataList.value.referId,
      'fromdate': dateinput.text,
      'todate': toDateInput.text,
      'mobile': ""
    };


    var serverResponse = await ApiServices.post(requestData, endpoint);

    var data = json.decode(serverResponse);

    debugPrint("server response $serverResponse");
    isLoading.value = false;

    List<dynamic> providerList = data;
    serviceTxnList.value.clear();
    serviceTxnFilterList.value.clear(); // Clear existing data
    // txnListBackUp.value.clear();
    for (var providerData in providerList) {
      serviceTxnList.value.add(servicesTxnDataModel.fromJson(providerData));
      // txnListBackUp.value.add(lagerDataModel.fromJson(providerData));
    }
   if(txnMode == "UPI"){
     serviceTxnFilterList.value = serviceTxnList.value.where((transaction) => transaction.service == 'UPI').toList();
     serviceTxnFilterListBackup.value = serviceTxnList.value.where((transaction) => transaction.service == 'UPI').toList();
   }else if(txnMode == "AEPS"){
     serviceTxnFilterList.value = serviceTxnList.value;
     serviceTxnFilterListBackup.value = serviceTxnList.value;
   }else if(txnMode == "DMT"){
     serviceTxnFilterList.value = serviceTxnList.value
         .where((transaction) => transaction.service == 'DMT')
         .toList();
     serviceTxnFilterListBackup.value = serviceTxnList.value
         .where((transaction) => transaction.service == 'DMT')
         .toList();
   }else if(txnMode == 'BBPS'){
     serviceTxnFilterList.value = serviceTxnList.value
         .where((transaction) => transaction.transactionID!.startsWith("BBP")||transaction.transactionID!.startsWith("MK"))
         .toList();
     serviceTxnFilterListBackup.value = serviceTxnList.value
         .where((transaction) => transaction.transactionID!.startsWith("BBP")||transaction.transactionID!.startsWith("MK"))
         .toList();
   }else if(txnMode == "LIC"){
     serviceTxnFilterList.value = serviceTxnList.value
         .where((transaction) => transaction.service == 'LIC')
         .toList();
     serviceTxnFilterListBackup.value = serviceTxnList.value
         .where((transaction) => transaction.service == 'LIC')
         .toList();
   }else if(txnMode == "Mobile"){
     serviceTxnFilterList.value = serviceTxnList.value.where((transaction) => transaction.service == 'MOBILE').toList();
     serviceTxnFilterListBackup.value = serviceTxnList.value.where((transaction) => transaction.service == 'MOBILE').toList();
   }
  }

  void mainLadgerApi(String endpoint) async {
   isLoading.value = true;

    Map requestData = {
      'method': 'payestransaction_new',
      'loginid': P_loginDataList.value.referId,
      'fromdate': "2022-01-01",
      'todate': toDateInput.text,
      'mobile': ""
    };


    var serverResponse = await ApiServices.post(requestData, endpoint);

    var data = json.decode(serverResponse);

    debugPrint("server response $serverResponse");
    isLoading.value = false;

    List<dynamic> providerList = data;
    serviceTxnList.value.clear();
   serviceTxnFilterListBackup.value.clear();
   for (var providerData in providerList) {
     var txn = servicesTxnDataModel.fromJson(providerData);

     // Only add if service is NOT DMT, AEPS, or PGDMT
     if (txn.service != "DMT" && txn.service != "AEPS" && txn.service != "PGDMT" && txn.service != "UPI") {
       serviceTxnList.value.add(txn);
       serviceTxnFilterListBackup.value.add(txn);
     }
   }
  }

  void mainLadgerDateWiseApi(String endpoint) async {
   isLoading.value = true;

    Map requestData = {
      'method': 'payestransaction_new',
      'loginid': P_loginDataList.value.referId,
      'fromdate': dateinput.text,
      'todate': toDateInput.text,
      'mobile': ""
    };


    var serverResponse = await ApiServices.post(requestData, endpoint);

    if(serverResponse == ""){
      isLoading.value = false;
      PopUp.toastErrorMessage("Data Not Found / Internal Server Error ");
    }else{
      var data = json.decode(serverResponse);

      debugPrint("server response $serverResponse");
      isLoading.value = false;

      List<dynamic> providerList = data;
      serviceTxnList.value.clear();
      // txnListBackUp.value.clear();
      for (var providerData in providerList) {
        serviceTxnList.value.add(servicesTxnDataModel.fromJson(providerData));
        serviceTxnFilterListBackup.value.add(servicesTxnDataModel.fromJson(providerData));
        // txnListBackUp.value.add(lagerDataModel.fromJson(providerData));
      }
    }

  }

  void HistoryApi(String endpoint) async {
    Map requestData = {
      'method': txnMode,
      'start': '0',
      'limit': '50',
      'startDate': dateinput.text,
      'endDate': toDateInput.text,
    };

    var serverResponse = await ApiServices.post(requestData, endpoint);

    var data = json.decode(serverResponse);

    debugPrint("server response $serverResponse");

    if (data['status'] == "S") {
      txnList.value = txnDataModel.fromJson(data);
      txnListData.value = txnList.value.data!;
      BackUplist.value = txnList.value.data!;
    } else {
      PopUp.toastMessage(data['message'].toString());
    }
  }

  void addUserAccountApi(String endpoint) async {
    isLoading.value = true;
    Map requestData = {
      'aType': fundMode,
      'bankName': bankName,
      'ifscCode': beneIfscCode.text,
      'accountNumber': beneAccount.text,
      'accountHolderName': bankHolderNameController.text,
      'branchName': bankBranchNameController.text,
    };

    var serverResponse = await ApiServices.post(requestData, endpoint);

    var data = json.decode(serverResponse);

    isLoading.value = false;

    debugPrint("server response $serverResponse");
    if (data['status'] == "S") {
      PopUp.toastMessage(data['message'].toString());
      bankName = "";
      beneIfscCode.clear();
      beneAccount.clear();
      bankBranchNameController.clear();
      bankHolderNameController.clear();
    } else {
      PopUp.toastMessage(data['message'].toString());
    }
  }


  String AePSBallance = "";

  imgShow() {
    if (ImagePath.isNotEmpty) {
      File? imageFile = File(ImagePath);
      if (imageFile.existsSync()) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 3),
            ),
            height: MediaQuery.of(Get.context!).size.height * 0.2,
            width: MediaQuery.of(Get.context!).size.width * 0.3,
            child: Image.file(File(imageFile.path)),
          ),
        );
      } else {
        return Container(
          child: const Center(
            child: Text('Image file does not exist'),
          ),
        );
      }
    } else {
      return Container(

      );
    }
  }

  String base64Imageurl = "";

  void loadRequestBankListApi() async {
    isLoading.value = true;
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse('http://api.payimps.in/recApiFinal/service.aspx'));
    request.bodyFields = {
      'method': 'getloadbank',
      'userid': P_loginDataList.value.referId!,
    };
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String serverResponse = await response.stream.bytesToString();

    if(serverResponse == ""){
      PopUp.toastMessage("Server error !!");
      isLoading.value = false;
    }else {
      var data = json.decode(serverResponse);

      debugPrint("server response $serverResponse");
      isLoading.value = false;

      List<dynamic> providerList = data;
      LoadRequestbanklist.value.clear(); // Clear existing data
      for (var providerData in providerList) {
        LoadRequestbanklist.value.add(loadRequestBankListModel.fromJson(providerData));
      }
    }
  }

  void fundRequestApi() async {
    isLoading.value = true;


    Map requestData = {
      'method': 'createload',
      'userid': P_loginDataList.value.referId!,
      'amount': FAmountController.text,
      'images': base64Imageurl,  // Assuming you are not using images in the request body
      'bankreference': FTxnIdController.text,
      'bankname': bankName,
      'description': FRemarksController.text,
      'mode': fundMode,
    };

    var serverResponse = await ApiServices.post(requestData, "");
// {\"Id\":\"Y\",\"Result\":\"Load request successfully created with reference Id : REF-APR100074585251022\"}
    var data = json.decode(serverResponse);

    isLoading.value = false;

    if (data['Id'] == "Y") {
      fundMode = "";
      bankName = "";
      FAmountController.clear();
      FTxnIdController.clear();
      FTxnDateController.clear();
      FRemarksController.clear();
      dateinput.clear();
      base64Imageurl = "";
      isVisibleSlip.value = false;
      PopUp.toastMessage(data['Result'].toString());
      imgVisible.value = false;
      Get.back();
    } else {
      PopUp.toastMessage(data['Result'].toString());
      PopUp.alertMessage(data['Result'].toString());
    }
  }

  Widget buildDetailRow(String label, String value, {TextStyle? labelStyle, TextStyle? valueStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width *0.22,
            child: Text(
              label,
              style: labelStyle ?? const TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width *0.47,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: valueStyle,
            ),
          ),
        ],
      ),
    );
  }

  viewLoadList(){
    if(loadRequestList.isNotEmpty){
      return ListView.builder(
          itemCount: loadRequestList.length,
          itemBuilder: (context, index){
            double amount = loadRequestList[index].amount.toDouble();
            return Card(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    onTap: (){
                      final transaction = loadRequestList.value[index];
                      print(loadRequestList.value[index]);

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // Ensures it can expand properly for large content
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Adapts height to content
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'View Fund Request',
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.close, color: Colors.red),
                                        onPressed: () {
                                          // Action for removing or closing the modal
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  buildDetailRow('TopUp Id', transaction.tid!, valueStyle: const TextStyle(fontSize: 13)),
                                  const Divider(),
                                  buildDetailRow('Bank Name', transaction.bankName!, valueStyle: const TextStyle(fontSize: 13)),
                                  const Divider(),
                                  buildDetailRow('Receipts Date', transaction.requestDate!.split("|").first, valueStyle: const TextStyle(fontSize: 13)),
                                  const Divider(),
                                  buildDetailRow('Request Date', transaction.requestDate!.split("|").last, valueStyle: const TextStyle(fontSize: 13)),
                                  const Divider(),
                                  buildDetailRow('Txn Amount', '₹${amount.toStringAsFixed(2)}', valueStyle: const TextStyle(fontSize: 13)),
                                  const Divider(),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Transaction Slip"),
                                            content: Image.network(transaction.slip?? "N/A"),
                                            actions: [
                                              TextButton(
                                                child: const Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: buildDetailRow(
                                      'Slip',
                                      "View",
                                      valueStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amberAccent),
                                    ),
                                  ),
                                  const Divider(),
                                  buildDetailRow(
                                    'Txn Status',
                                    transaction.status!,
                                    valueStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: transaction.status == "Success"
                                          ? Colors.green
                                          : transaction.status == "P"
                                          ? Colors.orange
                                          : Colors.red,
                                    ),
                                  ),
                                  const Divider(),
                                  buildDetailRow('UTR No.', transaction.utrNo!),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 15,
                      child: Text((index + 1).toString(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),                  ),
                    subtitle: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('${loadRequestList[index].tid}',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),)),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(loadRequestList[index].requestDate!.split("|").last,style: const TextStyle(fontSize: 13,),)),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('₹${amount.toStringAsFixed(2)}',style: const TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(
                          loadRequestList[index].status!.length >= 9
                              ? "${loadRequestList[index].status!.substring(0, 8)}..."
                              : loadRequestList[index].status!,style: TextStyle(
                            color: loadRequestList[index].status == "Success"? Colors.green:
                            loadRequestList[index].status == "Pending"?Colors.orange:
                            loadRequestList[index].status == "Approved"? Colors.green
                                :Colors.red,fontWeight: FontWeight.bold
                        ),)
                        // Text(list[index].status!,style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ).paddingOnly(top: 5),
                ],
              ),
            );
            // return ListTile(
            //   title: Text(bbpsController.txnListData[index].txnId!.toString()),
            //   trailing: Text(bbpsController.txnListData[index].status!.toString()),
            // );
          }
      );
    }else{
      return const Center(child: Text("No Data Found !!", style: TextStyle(fontWeight: FontWeight.bold),));
    }
  }

  void viewLoadRequestApi() async {
    isLoading.value = true;

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse('http://api.payimps.in/recApiFinal/service.aspx'));
    request.bodyFields = {
      'method':'viewload',
      'userid':md5UserId,
    };
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String serverResponse = await response.stream.bytesToString();

    var data = json.decode(serverResponse);

    isLoading.value = false;

    if(data.isNotEmpty){
      List<dynamic> providerList = data;
      loadRequestList.value.clear();
      loadRequestBackUp.value.clear();
      for (var providerData in providerList) {
        loadRequestList.value.add(viewloadModel.fromJson(providerData));
        print(loadRequestList.value[0]);
        loadRequestBackUp.value.add(viewloadModel.fromJson(providerData));
      }
    }else{
      PopUp.toastMessage("Load Request not loaded !!");
    }
  }

  void creditCardDetails() async {

    // isLoading.value = true;
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    var request = http.Request('POST', Uri.parse('https://webapi.payimps.in/PaymentCC.aspx'));
    request.bodyFields = {
      'Pedha': 'PedhaPayCC',
      'UserId': P_loginDataList.value.referId!,
      'txnAmount':dmtAmount,
      'Cardno':beneAccountNumber,
      'Tpin':tpin,
      'HolderName':BeneFiName,
      'Token':P_loginDataList.value.referId!,
      'Type':'APP',
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String serverResponse = await response.stream.bytesToString();

    var data = jsonDecode(serverResponse);

    isLoading.value = false;

    // debugPrint("server response $serverResponse");
    if (data["status"] == true) {
      dmtTxnId = data['tid'].toString();
      paymentStatus = "success";
      paymentMessage = 'Your Payment Completed Successfully !!';
      Get.to(const DMTSuccessPage());
    }else if(data['message'] == "Invalid T-Pin"){
      tPinPaymentCOntroller.clear();
      PopUp.toastErrorMessage(data['message'].toString());

    } else {
      // Get.back();
      print(data['message'].toString());
      print(PopUp.toastErrorMessage(data['message'].toString()));
      amountController.clear();
      tPinPaymentCOntroller.clear();
      beneIfscCode.clear();
      // beneName.clear();
    }
    tpin  = "";
    tPinPaymentCOntroller.clear();
    amountController.clear();
    custmerNameController.clear();
    fieldNumberController.clear();
  }

  void licBillFetchDetails() async {

    // isLoading.value = true;
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    var request = http.Request('POST', Uri.parse('https://webapi.payimps.in/Services.aspx'));
    request.bodyFields = {
      'Pedha': 'FecthLIC',
      'LicNumber': fieldNumberController.text,
      'OpCode': 'LICI',
      'email': custmerNameController.text,
      'dob': dateOfBirthController.text,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String serverResponse = await response.stream.bytesToString();

    var data = jsonDecode(serverResponse);

    isLoading.value = false;

    debugPrint("server response $serverResponse");

    if (data["status"] == 0) {

      showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Obx(() {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.dangerous,
                                  color: Colors.blue,
                                  size: 30,
                                )),
                          ),
                          const Text(
                            "Bill Deatils",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          10.height,
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 55,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: Image.network(
                                  "https://media.licdn.com/dms/image/v2/C4E03AQEO3IMnNL-UcA/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1602479130345?e=2147483647&v=beta&t=KU95O6J6ejINOa_Lr8nY3kGpgpuhCeXwn20FeYPbL54",
                                  height: 80,
                                )),
                          ),
                          10.height,
                          const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'providerName',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )).center(),
                          20.height,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: const Text(
                                        "Name :",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ).paddingOnly(left: 10)),
                                  Expanded(
                                      child: const Text(
                                        'bilfetchListData.value[0].userName!',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ).paddingOnly(left: 10)),
                                ],
                              ),
                              20.height,
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: const Text(
                                        "Acc No. :",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ).paddingOnly(left: 10)),
                                  Expanded(
                                      child: const Text('billerNumber',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ).paddingOnly(left: 10)),
                                ],
                              ),
                              10.height,
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: const Text(
                                        "Bill Date :",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ).paddingOnly(left: 10)),
                                  Expanded(
                                      child: const Text(
                                        'bilfetchListData.value[0].billdate!',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ).paddingOnly(left: 10)),
                                ],
                              ),
                              10.height,
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: const Text(
                                        "Dua Date :",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ).paddingOnly(left: 10)),
                                  Expanded(
                                      child: const Text(
                                        'bilfetchListData.value[0].dueDate!',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ).paddingOnly(left: 10)),
                                ],
                              ),
                              10.height,
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: const Text(
                                        "Amount :",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ).paddingOnly(left: 10)),
                                  Expanded(
                                      child: const Text(
                                        "₹ " 'bilfetchListData.value[0].billAmount!',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ).paddingOnly(left: 10)),
                                ],
                              ),
                              10.height,
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Enter Pin",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              10.height,
                            ],
                          ),
                          20.height,
                          AppButton(
                              color: const Color.fromRGBO(254, 136, 122, 1),
                              textColor: Colors.white,
                              shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              width: MediaQuery.of(context).size.width,
                              onTap: isLoading.value
                                  ? null
                                  : () {
                                licBillPayment();
                              },
                              child: isLoading.value
                                  ? AppButton(
                                text: "Loading...",
                                textColor: Colors.white,
                                color:
                                const Color.fromRGBO(254, 136, 122, 1),
                                shapeBorder: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(30)),
                                width:
                                MediaQuery.of(context).size.width,
                                onTap: () {
                                  isLoading.value = false;
                                },
                              )
                                  : const Text('Payment',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)))
                              .paddingOnly(
                              left: MediaQuery.of(context).size.width * 0.1,
                              right:
                              MediaQuery.of(context).size.width * 0.1),
                        ],
                      ),
                    );
                  })),
            );
          });
    } else {
      fieldNumberController.clear();
      custmerNameController.clear();
      dateOfBirthController.clear();
      PopUp.toastErrorMessage(data['msg'].toString());
      PopUp.alertMessage(data['msg'].toString());
    }
  }

  void licBillPayment() async {

    // isLoading.value = true;
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    var request = http.Request('POST', Uri.parse('https://webapi.payimps.in/Services.aspx'));
    request.bodyFields = {
      'Pedha': 'PedhaPayLIC',
      'UserID': P_loginDataList.value.referId!,
      'Amount': dmtAmount,
      'LicNumber': fieldNumberController.text,
      'Tpin': tpin,
      'Name': custmerNameController.text,
      'Email': custmerNameController.text,
      'Token': P_loginDataList.value.referId!,
      'Birth': dateOfBirthController.text,
      'DeviceType': 'APP',
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String serverResponse = await response.stream.bytesToString();

    var data = jsonDecode(serverResponse);

    isLoading.value = false;

    debugPrint("server response $serverResponse");

    if (data["status"] == true) {
      dmtTxnId = data['tid'].toString();
      paymentStatus = "success";
      paymentMessage = 'Your Payment Completed Successfully !!';
      showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.dangerous,color: Colors.blue,size: 30,)),
                        ),
                        Image.asset("assets/success.gif", height: MediaQuery.of(Get.context!).size.height * 0.2,width: 400,),
                        10.height,
                        const Text("Payment Completed Successfully ",style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.green)),
                        20.height,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: const Text("Transfer to :", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),).paddingOnly(left: 10)),
                                Expanded(child: Text(bankName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),).paddingOnly(left: 10)),
                              ],
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: const Text("Amount :", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),).paddingOnly(left: 10)),
                                Expanded(child: Text("₹ $dmtAmount", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),).paddingOnly(left: 10)),
                              ],
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: const Text("Remarks :", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),).paddingOnly(left: 10)),
                                Expanded(child: Text(beneBankName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),).paddingOnly(left: 10)),
                              ],
                            ),
                            20.height,
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            AppButton(
                                color: const Color.fromRGBO(158,66,149,1),
                                textColor: Colors.white,
                                shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: MediaQuery.of(context).size.width,
                                onTap:  () {
                                  Get.back();
                                },
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                )
                            ).paddingOnly(
                              left: MediaQuery.of(context).size.width * 0.1,
                              right: MediaQuery.of(context).size.width * 0.1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )

              ),
            );
          }
      );
    }else if(data['message'] == "Invalid T-Pin"){
      tPinPaymentCOntroller.clear();
      PopUp.toastErrorMessage(data['message'].toString());

    } else {
      // Get.back();
      print(data['message'].toString());
      print(PopUp.toastErrorMessage(data['message'].toString()));
      amountController.clear();
      tPinPaymentCOntroller.clear();
      beneIfscCode.clear();
      // beneName.clear();
    }
    tpin  = "";
    tPinPaymentCOntroller.clear();
    amountController.clear();
    custmerNameController.clear();
    fieldNumberController.clear();
  }

}
