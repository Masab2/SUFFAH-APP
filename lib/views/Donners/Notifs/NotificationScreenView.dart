import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/Donner/NotificationViewModel/NotificationViewModel.dart';
import 'package:suffa_app/res/components/NotificationComp/NtificationComp.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class NotificationScreenView extends StatefulWidget {
  const NotificationScreenView({super.key});

  @override
  State<NotificationScreenView> createState() => _NotificationScreenViewState();
}

class _NotificationScreenViewState extends State<NotificationScreenView> {
  final controller = Get.put(NotificationViewModel());
  @override
  void initState() {
    controller.fetchAllNotifis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.024,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.mehroonColor,
                AppColor.brownColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          const Icon(
            IconlyBold.filter,
          ),
          0.03.pw,
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            if (controller.notifsList.isEmpty) {
              return const Center(
                child: SpinKitChasingDots(
                  color: AppColor.mehroonColor,
                  duration: Duration(seconds: 5),
                  size: 40,
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.notifsList.length,
                  itemBuilder: (context, index) {
                    final notifs = controller.notifsList[index];
                    return NotificationComp(
                      title: notifs.title,
                      body: notifs.body,
                      time: notifs.time,
                    );
                  },
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
