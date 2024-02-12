import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:suffa_app/views/suffaCenters/CenterProgram/displayProgram/Active/Al-suffahactiveprogram.dart';
import 'package:suffa_app/views/suffaCenters/CenterProgram/displayProgram/Rejected/Al-SuffahRejectedProgram.dart';
import 'package:suffa_app/views/suffaCenters/CenterProgram/displayProgram/Requested/Al-SuffahRequestedProgram.dart';

import '../../../../Service/Firebase/firebasehelper.dart';
import '../../../../res/components/RequestMemberComp/RequestMemberComp.dart';
import '../../../../utils/color/appColor.dart';

class DisplayCenterProgram extends StatefulWidget {
  const DisplayCenterProgram({super.key});

  @override
  State<DisplayCenterProgram> createState() => _DisplayCenterProgramState();
}

class _DisplayCenterProgramState extends State<DisplayCenterProgram>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);
  late String id;
  late String masjidname;
  late String masjidId;
  late String muntazimEmail;
  @override
  void initState() {
    id = Get.arguments[0];
    masjidname = Get.arguments[1];
    masjidId = Get.arguments[2];
    muntazimEmail = Get.arguments[3];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Al-Suffah Program',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.023,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: TabBar(
                      controller: tabController,
                      unselectedLabelColor: AppColor.blackColor,
                      labelColor: AppColor.blackColor,
                      labelStyle: GoogleFonts.nunito(
                          textStyle: TextStyle(
                        fontSize: context.mh * 0.020,
                        fontWeight: FontWeight.w600,
                      )),
                      labelPadding: EdgeInsets.symmetric(
                        horizontal: context.mw * 0.01,
                      ),
                      isScrollable: true,
                      indicatorColor: AppColor.blackColor,
                      indicatorPadding: EdgeInsets.symmetric(
                        horizontal: context.mw * 0.04,
                        vertical: 0,
                      ),
                      tabs: [
                        Container(
                          width: context.mw * 0.30,
                          decoration: BoxDecoration(
                            color: AppColor.cgreenColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Tab(
                            text: 'Active',
                          ),
                        ),
                        Container(
                          width: context.mw * 0.30,
                          decoration: BoxDecoration(
                            color: AppColor.cgreenColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Tab(
                            text: 'Requested',
                          ),
                        ),
                        Container(
                          width: context.mw * 0.30,
                          decoration: BoxDecoration(
                            color: AppColor.cgreenColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Tab(
                            text: 'Rejected',
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                width: double.maxFinite,
                height: context.mh,
                child: TabBarView(controller: tabController, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.mw * 0.03,
                        vertical: context.mh * 0.02),
                    child: const AlSuffahActiveProgramView(),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.mw * 0.03,
                          vertical: context.mh * 0.02),
                      child: const AlSuffahRequestedprogramView()),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.mw * 0.03,
                          vertical: context.mh * 0.02),
                      child: const AlSuffahRejectedView()),
                ]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(
              RoutesNames.centerProgramScreen,
              arguments: [
                id,
                masjidname,
                masjidId,
                muntazimEmail,
              ],
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
