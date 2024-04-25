import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MemberRequestRepo {
  Future<String?> acceptRequest(id,BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    try {
      await Apis.acceptRequestofMember(id).then((value) {
        return l10n!.memberRequestAccept;
      }).onError((error, stackTrace) {
        return error.toString();
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
