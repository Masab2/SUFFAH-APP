import 'dart:developer';

import 'package:suffa_app/Model/DonnationTrackMasjidModel/DonnationTrackMasjidModel.dart';
import 'package:suffa_app/Model/DonnationTrackModel/donnationTrackModel.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class PaymentRepo {
  Future<String?> donnationTrackForPerson(
    DonnationTrackModel? model,
    List<DonnerModel> donnerlist,
  ) async {
    try {
      Apis.donnatationTarkPerson(
        model?.program,
        model?.requiredDonnation,
        model?.masjidname,
        model?.masjidid,
        model?.muntazimId,
        model?.masjidAddress,
        model?.masjidCountry,
        model?.masjidCity,
        model?.masjidState,
        model?.masjidemail,
        model?.personcnic,
        model?.personame,
        model?.dateofBirth,
        model?.dateofCardExpire,
        model?.dateofCardIssue,
        model?.personId,
        model?.personPhoneNo,
        model?.personaddress,
        model?.personprofile,
        model?.personGender,
        donnerlist,
      );
      Apis.updateDonationAmount(model?.personId, model?.donnationAmmount);
      Apis.addNotification(
        'Donnation Sent',
        'Donnation Sent to Admin for ${model?.personame} of ${model?.program} Program',
        model?.donnationAmmount.toString() ?? '0',
        model?.currency ?? 'PKR',
      );
      Apis.addDonationTrack(
        'Donnation Sent',
        'Track for ${model?.personame} of ${model?.program} Program',
        model?.donnationAmmount.toString() ?? '',
        model?.currency ?? 'PKR',
        'Recived by Admin',
        model?.personcnic ?? '',
        model?.personame ?? '',
        model?.personaddress ?? '',
        '${model?.masjidCountry}/${model?.masjidCity}/${model?.masjidState} ',
        model?.program ?? '', 'forPerson',
      );
      return null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // For Masjid Program
  Future<String?> donnationTrackForMasjid(
    DonnationTrackMasjidModel? model,
    List<DonnerModel> donnerlist,
  ) async {
    try {
      Apis.donnatationTarkMasjid(
        model?.program,
        model?.requiredDonnation,
        model?.masjidname,
        model?.masjidid,
        model?.muntazimId,
        model?.masjidAddress,
        model?.masjidCountry,
        model?.masjidCity,
        model?.masjidState,
        model?.masjidemail,
        model?.personcnic,
        model?.personame,
        model?.dateofBirth,
        model?.dateofCardExpire,
        model?.dateofCardIssue,
        model?.programId,
        donnerlist,
      );
      Apis.updateDonationAmountForMasjid(
        model?.programId,
        model?.donnationAmmount,
      );
      Apis.addNotification(
        'Donnation Sent',
        'Donnation Sent to Admin for ${model?.masjidname} of ${model?.program} Program ',
        model?.donnationAmmount.toString() ?? '0',
        model?.currency ?? 'PKR',
      );
      Apis.addDonationTrack(
        'Donnation Sent',
        'Track for ${model?.masjidname} of ${model?.program} Program',
        model?.donnationAmmount.toString() ?? '',
        model?.currency ?? 'PKR',
        'Recived by Admin',
        model?.personcnic ?? '',
        model?.personame ?? '',
        model?.masjidAddress ?? '',
        '${model?.masjidCountry}/${model?.masjidCity}/${model?.masjidState} ',
        model?.program ?? '', 'forMasjid',
      );
      return null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
