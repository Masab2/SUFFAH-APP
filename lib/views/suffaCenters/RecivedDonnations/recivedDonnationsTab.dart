import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/addAffilated/tabControllerViewSuffahProgramViewModel.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:suffa_app/views/suffaCenters/RecivedDonnations/MasjidDonnationRecived/MasjidDonnation.dart';
import 'package:suffa_app/views/suffaCenters/RecivedDonnations/PersonDonnationRecived/PersonDonnationRecived.dart';

class RecivedDonnationTab extends StatefulWidget {
  const RecivedDonnationTab({super.key});

  @override
  State<RecivedDonnationTab> createState() => _RecivedDonnationTabState();
}

class _RecivedDonnationTabState extends State<RecivedDonnationTab>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  final controller = Get.put(ViewSuffahProgramsViewModel());
  late String id;
  late String masjidId;
  @override
  void initState() {
    id = Get.arguments[0];
    masjidId = Get.arguments[1];
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recived Donnation',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.023,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: context.mw,
                child: Align(
                  alignment: Alignment.center,
                  child: Obx(() {
                    return TabBar(
                        onTap: (value) => controller.selectTab(value),
                        controller: tabController,
                        unselectedLabelColor: AppColor.whiteColor,
                        labelColor: AppColor.whiteColor,
                        labelStyle: GoogleFonts.nunito(
                            textStyle: TextStyle(
                          fontSize: context.mh * 0.018,
                          fontWeight: FontWeight.w600,
                        )),
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: context.mw * 0.01,
                        ),
                        isScrollable: false,
                        indicatorColor: AppColor.whiteColor,
                        indicatorPadding: EdgeInsets.symmetric(
                          horizontal: context.mw * 0.04,
                          vertical: 0,
                        ),
                        tabs: [
                          _buildTab('Person Donnation', 0),
                          _buildTab('Masjid Donnation', 1),
                        ]);
                  }),
                ),
              ),
              SizedBox(
                width: context.mw,
                height: context.mh * 0.8,
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.mw * 0.03,
                            vertical: context.mh * 0.02),
                        child:
                            PersonDonnationRecived(id: id, masjidId: masjidId),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.mw * 0.03,
                            vertical: context.mh * 0.02),
                        child:
                            MasjidDonnationRecived(id: id, masjidId: masjidId),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return Container(
      width: context.mw,
      decoration: BoxDecoration(
        color: controller.selectedIndex.value == index
            ? AppColor.mehroonColor
            : AppColor.brownColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Tab(
        text: text,
      ),
    );
  }
}
