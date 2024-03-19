import 'dart:developer';

import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class PaymentRepo {
  Future<String?> donnationTrackAfterDonate(
    program,
    requiredDonnation,
    masjidname,
    masjidId,
    muntazimId,
    masjidAddress,
    masjidCountry,
    masjidCity,
    masjidstate,
    masjidEmail,
    personcnic,
    personame,
    dateofBirth,
    dateofCardExpire,
    dateofCardIssue,
    personId,
    personPhoneNo,
    personaddress,
    personprofile,
    personGender,
    List<DonnerModel> donnerlist,
  ) async {
    try {
      Apis.donnatationTark(
        program,
        requiredDonnation,
        masjidname,
        masjidId,
        muntazimId,
        masjidAddress,
        masjidCountry,
        masjidCity,
        masjidstate,
        masjidEmail,
        personcnic,
        personame,
        dateofBirth,
        dateofCardExpire,
        dateofCardIssue,
        personId,
        personPhoneNo,
        personaddress,
        personprofile,
        personGender,
        donnerlist,
      );
      return null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
