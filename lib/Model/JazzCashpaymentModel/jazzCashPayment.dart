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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pp_Amount'] = this.ppAmount;
    data['pp_AuthCode'] = this.ppAuthCode;
    data['pp_BankID'] = this.ppBankID;
    data['pp_BillReference'] = this.ppBillReference;
    data['pp_Language'] = this.ppLanguage;
    data['pp_MerchantID'] = this.ppMerchantID;
    data['pp_ResponseCode'] = this.ppResponseCode;
    data['pp_ResponseMessage'] = this.ppResponseMessage;
    data['pp_RetreivalReferenceNo'] = this.ppRetreivalReferenceNo;
    data['pp_SubMerchantId'] = this.ppSubMerchantId;
    data['pp_TxnCurrency'] = this.ppTxnCurrency;
    data['pp_TxnDateTime'] = this.ppTxnDateTime;
    data['pp_TxnRefNo'] = this.ppTxnRefNo;
    data['pp_SettlementExpiry'] = this.ppSettlementExpiry;
    data['pp_TxnType'] = this.ppTxnType;
    data['pp_Version'] = this.ppVersion;
    data['ppmpf_1'] = this.ppmpf1;
    data['ppmpf_2'] = this.ppmpf2;
    data['ppmpf_3'] = this.ppmpf3;
    data['ppmpf_4'] = this.ppmpf4;
    data['ppmpf_5'] = this.ppmpf5;
    data['pp_SecureHash'] = this.ppSecureHash;
    return data;
  }
}
