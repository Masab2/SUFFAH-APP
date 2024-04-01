import 'dart:developer';

import 'package:suffa_app/Model/DonnationTrackModel/donnationTrackModel.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class PaymentRepo {
  Future<String?> donnationTrackAfterDonate(
    DonnationTrackModel model,
    List<DonnerModel> donnerlist,
  ) async {
    try {
      Apis.donnatationTark(
        model.program,
        model.requiredDonnation,
        model.masjidname,
        model.masjidid,
        model.muntazimId,
        model.masjidAddress,
        model.masjidCountry,
        model.masjidCity,
        model.masjidState,
        model.masjidemail,
        model.personcnic,
        model.personame,
        model.dateofBirth,
        model.dateofCardExpire,
        model.dateofCardIssue,
        model.personId,
        model.personPhoneNo,
        model.personaddress,
        model.personprofile,
        model.personGender,
        donnerlist,
      );
      Apis.updateDonationAmount(model.personId, model.donnationAmmount);
      return null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
