import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/Admin/AdminDonnationTrackVieModel/AdminDonnationTrackViewModel.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:suffa_app/views/admin/AdminDonnationTrack/AlShuffahMasjidDonnation/AlShuffahMasjidDonnation.dart';
import 'package:suffa_app/views/admin/AdminDonnationTrack/AlShuffahPersonDonnation/AlShuffahPersonDonnation.dart';

class AdminDonnationTrackView extends StatefulWidget {
  const AdminDonnationTrackView({super.key});

  @override
  State<AdminDonnationTrackView> createState() =>
      _AdminDonnationTrackViewState();
}

class _AdminDonnationTrackViewState extends State<AdminDonnationTrackView>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  final controller = Get.put(AdminDonnationTrackViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(
          'Admin Donnation Track',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: context.mh * 0.023,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(
            () {
              return TabBar(
                onTap: (value) => controller.selectTab(value),
                controller: tabController,
                unselectedLabelColor: AppColor.blackColor,
                labelColor: AppColor.whiteColor,
                labelStyle: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: context.mh * 0.020,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: context.mw * 0.01,
                ),
                isScrollable: false,
                indicatorColor: AppColor.whiteColor,
                indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
                tabs: [
                  _buildTab('Al-Suffah Person', 0),
                  _buildTab('Al-Suffah Center', 1),
                ],
              );
            },
          ),
          0.01.ph,
          SizedBox(
            height: context.mh * 0.6,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              dragStartBehavior: DragStartBehavior.start,
              children: const [
                AlShuffahPersonDonnation(),
                AlShuffahCenterDonnation(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: controller.selectedIndex.value == index
                  ? AppColor.mehroonColor
                  : AppColor.brownColor,
            ),
            child: Tab(
              text: text,
            ),
          ),
        ),
      ],
    );
  }
}
