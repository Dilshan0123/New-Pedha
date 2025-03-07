/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation
library;

import 'dart:convert';

MsFingaPayDataModel msFingaPayDataModelFromJson(String str) => MsFingaPayDataModel.fromJson(json.decode(str));

String msFingaPayDataModelToJson(MsFingaPayDataModel data) => json.encode(data.toJson());

class MsFingaPayDataModel {
    MsFingaPayDataModel({
        this.data,
        this.message,
        this.status,
        this.statusCode,
    });

    Data? data;
    String? message;
    bool? status;
    int? statusCode;

    factory MsFingaPayDataModel.fromJson(Map<dynamic, dynamic> json) => MsFingaPayDataModel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
        statusCode: json["statusCode"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "status": status,
        "statusCode": statusCode,
    };
}

class Data {
    Data({
        this.agentId,
        this.merchantTxnId,
        this.terminalId,
        this.responseCode,
        this.transactionAmount,
        this.fpTransactionId,
        this.transactionStatus,
        this.balanceAmount,
        this.miniStatementStructureModel,
        this.transactionType,
        this.requestTransactionTime,
        this.bankRrn,
        this.miniOffusFlag,
    });

    int? agentId;
    String? merchantTxnId;
    String? terminalId;
    String? responseCode;
    int? transactionAmount;
    String? fpTransactionId;
    String? transactionStatus;
    double? balanceAmount;
    List<MiniStatementStructureModel>? miniStatementStructureModel;
    String? transactionType;
    String? requestTransactionTime;
    String? bankRrn;
    bool? miniOffusFlag;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        agentId: json["agentId"],
        merchantTxnId: json["merchantTxnId"],
        terminalId: json["terminalId"],
        responseCode: json["responseCode"],
        transactionAmount: json["transactionAmount"],
        fpTransactionId: json["fpTransactionId"],
        transactionStatus: json["transactionStatus"],
        balanceAmount: json["balanceAmount"]?.toDouble(),
        miniStatementStructureModel: List<MiniStatementStructureModel>.from(json["miniStatementStructureModel"].map((x) => MiniStatementStructureModel.fromJson(x))),
        transactionType: json["transactionType"],
        requestTransactionTime: json["requestTransactionTime"],
        bankRrn: json["bankRRN"],
        miniOffusFlag: json["miniOffusFlag"],
    );

    Map<dynamic, dynamic> toJson() => {
        "agentId": agentId,
        "merchantTxnId": merchantTxnId,
        "terminalId": terminalId,
        "responseCode": responseCode,
        "transactionAmount": transactionAmount,
        "fpTransactionId": fpTransactionId,
        "transactionStatus": transactionStatus,
        "balanceAmount": balanceAmount,
        "miniStatementStructureModel": List<dynamic>.from(miniStatementStructureModel!.map((x) => x.toJson())),
        "transactionType": transactionType,
        "requestTransactionTime": requestTransactionTime,
        "bankRRN": bankRrn,
        "miniOffusFlag": miniOffusFlag,
    };
}

class MiniStatementStructureModel {
    MiniStatementStructureModel({
        required this.date,
        required this.amount,
        required this.narration,
        required this.txnType,
    });

    String date;
    String amount;
    String narration;
    String txnType;

    factory MiniStatementStructureModel.fromJson(Map<dynamic, dynamic> json) => MiniStatementStructureModel(
        date: json["date"],
        amount: json["amount"],
        narration: json["narration"],
        txnType: json["txnType"],
    );

    Map<dynamic, dynamic> toJson() => {
        "date": date,
        "amount": amount,
        "narration": narration,
        "txnType": txnType,
    };
}
