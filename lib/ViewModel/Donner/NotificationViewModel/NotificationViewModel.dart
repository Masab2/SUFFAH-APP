import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/NotifsModel/NotifsModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class NotificationViewModel extends GetxController {
  final RxList<NotifsModel> notifsList = <NotifsModel>[].obs;
  final RxList<NotifsModel> filterednotifsList = <NotifsModel>[].obs;
  final RxBool isLoading = true.obs; // Add loading flag

  void fetchAllNotifis() async {
    isLoading.value = true; // Set loading flag to true
    Apis.getAllNotifs().listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      final List<NotifsModel> data = snapshot.docs.map((doc) {
        return NotifsModel(
          title: doc['title'],
          body: doc['body'],
          seen: doc['seen'],
          time: doc['time'],
          id: doc['notifId'],
          userId: doc['donnnerId'],
          ammount: doc['Ammount'],
          currency: doc['currency'],
        );
      }).toList();
      notifsList.assignAll(data);
      filterednotifsList.assignAll(data);
      isLoading.value = false; // Set loading flag to false after data is fetched
    });
  }
}
