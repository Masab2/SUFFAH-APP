import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class MemberRequestRepo {
  Future<String?> acceptRequest(id) async {
    try {
      await Apis.acceptRequestofMember(id).then((value) {
        return 'Member Request Accept';
      }).onError((error, stackTrace) {
        return error.toString();
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
