//! Firebase Collections
// ignore_for_file: non_constant_identifier_names
import 'package:intl/intl.dart';

const String donorinfoCollection = 'DonnerInfo';
const String adminCollection = 'admin';
const String suffahCenterCollection = 'SuffahCenter';
const String suffahCenterMembers = 'SuffahCenterMembers';
const String suffahCenterNeedyPeople = 'SuffahCenterNeedyPeople';
const String donnationTrackPerson = 'donnationTrackPerson';
const String donnationTrackDonnerAll = 'donnationTrackDonnerAll';
const String donnationTrackMasjid = 'donnationTrackMasjid';
const String suffahAffiliatedprogram = 'suffahAffiliatedprogram';
const String suffahCenterDefineProgram = 'CenterDefineProgram';
const String suffahShop = 'SuffahShop';
const String notifsCollection = 'Notifications';

//^ Payment Methods
// jazzcash Payment
String dateandTime = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
String pp_ReturnUrl =
    'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';
String pp_ver = "1.1";
String pp_TxnCurrency = "PKR";
String pp_TxnDateTime = '20/10/2003';
String pp_TxnExpireDateTime = '20/10/2003';
String tre = "T$dateandTime";
String pp_Amount = "100000";
String pp_BillReference = "billRef";
String pp_Description = "Description";
String pp_Language = "EN";
String pp_MerchantID = "MC72717";
String pp_Password = "w533gw6yy7";
String pp_TxnRefNo = tre.toString();
String pp_TxnType = "MWALLET";
String ppmpf_1 = "4456733833993";
String IntegeritySalt = "cvtty681x";
String and = '&';
String superdata = IntegeritySalt +
    and +
    pp_Amount +
    and +
    pp_BillReference +
    and +
    pp_Description +
    and +
    pp_Language +
    and +
    pp_MerchantID +
    and +
    pp_Password +
    and +
    pp_ReturnUrl +
    and +
    pp_TxnCurrency +
    and +
    pp_TxnDateTime +
    and +
    pp_TxnExpireDateTime +
    and +
    pp_TxnRefNo +
    and +
    pp_TxnType +
    and +
    pp_ver +
    and +
    ppmpf_1;
