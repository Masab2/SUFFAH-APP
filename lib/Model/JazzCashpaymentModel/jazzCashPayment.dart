class JazzcashModel {
  String? ppAmount;
  String? ppAuthCode;
  String? ppBankID;
  String? ppBillReference;
  String? ppLanguage;
  String? ppMerchantID;
  String? ppResponseCode;
  String? ppResponseMessage;
  String? ppRetreivalReferenceNo;
  String? ppSubMerchantId;
  String? ppTxnCurrency;
  String? ppTxnDateTime;
  String? ppTxnRefNo;
  String? ppSettlementExpiry;
  String? ppTxnType;
  String? ppVersion;
  String? ppmpf1;
  String? ppmpf2;
  String? ppmpf3;
  String? ppmpf4;
  String? ppmpf5;
  String? ppSecureHash;

  JazzcashModel(
      {this.ppAmount,
      this.ppAuthCode,
      this.ppBankID,
      this.ppBillReference,
      this.ppLanguage,
      this.ppMerchantID,
      this.ppResponseCode,
      this.ppResponseMessage,
      this.ppRetreivalReferenceNo,
      this.ppSubMerchantId,
      this.ppTxnCurrency,
      this.ppTxnDateTime,
      this.ppTxnRefNo,
      this.ppSettlementExpiry,
      this.ppTxnType,
      this.ppVersion,
      this.ppmpf1,
      this.ppmpf2,
      this.ppmpf3,
      this.ppmpf4,
      this.ppmpf5,
      this.ppSecureHash});

  JazzcashModel.fromJson(Map<String, dynamic> json) {
    ppAmount = json['pp_Amount'];
    ppAuthCode = json['pp_AuthCode'];
    ppBankID = json['pp_BankID'];
    ppBillReference = json['pp_BillReference'];
    ppLanguage = json['pp_Language'];
    ppMerchantID = json['pp_MerchantID'];
    ppResponseCode = json['pp_ResponseCode'];
    ppResponseMessage = json['pp_ResponseMessage'];
    ppRetreivalReferenceNo = json['pp_RetreivalReferenceNo'];
    ppSubMerchantId = json['pp_SubMerchantId'];
    ppTxnCurrency = json['pp_TxnCurrency'];
    ppTxnDateTime = json['pp_TxnDateTime'];
    ppTxnRefNo = json['pp_TxnRefNo'];
    ppSettlementExpiry = json['pp_SettlementExpiry'];
    ppTxnType = json['pp_TxnType'];
    ppVersion = json['pp_Version'];
    ppmpf1 = json['ppmpf_1'];
    ppmpf2 = json['ppmpf_2'];
    ppmpf3 = json['ppmpf_3'];
    ppmpf4 = json['ppmpf_4'];
    ppmpf5 = json['ppmpf_5'];
    ppSecureHash = json['pp_SecureHash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pp_Amount'] = ppAmount;
    data['pp_AuthCode'] = ppAuthCode;
    data['pp_BankID'] = ppBankID;
    data['pp_BillReference'] = ppBillReference;
    data['pp_Language'] = ppLanguage;
    data['pp_MerchantID'] = ppMerchantID;
    data['pp_ResponseCode'] = ppResponseCode;
    data['pp_ResponseMessage'] = ppResponseMessage;
    data['pp_RetreivalReferenceNo'] = ppRetreivalReferenceNo;
    data['pp_SubMerchantId'] = ppSubMerchantId;
    data['pp_TxnCurrency'] = ppTxnCurrency;
    data['pp_TxnDateTime'] = ppTxnDateTime;
    data['pp_TxnRefNo'] = ppTxnRefNo;
    data['pp_SettlementExpiry'] = ppSettlementExpiry;
    data['pp_TxnType'] = ppTxnType;
    data['pp_Version'] = ppVersion;
    data['ppmpf_1'] = ppmpf1;
    data['ppmpf_2'] = ppmpf2;
    data['ppmpf_3'] = ppmpf3;
    data['ppmpf_4'] = ppmpf4;
    data['ppmpf_5'] = ppmpf5;
    data['pp_SecureHash'] = ppSecureHash;
    return data;
  }
}
