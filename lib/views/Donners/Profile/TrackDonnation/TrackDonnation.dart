import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/Donner/TrackDonnation/trackDonnationViewModel.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class TrackDonnation extends StatefulWidget {
  const TrackDonnation({Key? key}) : super(key: key);

  @override
  State<TrackDonnation> createState() => _TrackDonnationState();
}

class _TrackDonnationState extends State<TrackDonnation>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  final controller = Get.put(TrackDonnationViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Track Donnation',
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
      ),
      body: Column(
        children: [
          0.02.ph,
          StreamBuilder(
            stream: Apis.getAllDonnationTrack(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitChasingDots(
                    color: AppColor.mehroonColor,
                    duration: Duration(seconds: 5),
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Text('No Data');
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.mh * 0.01,
                          horizontal: context.mw * 0.02,
                        ),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.white,
                          shadowColor: AppColor.mehroonColor,
                          margin: EdgeInsets.zero,
                          clipBehavior: Clip.antiAliasWithSaveLayer,

                          child: ListTile(
                            leading: CircleAvatar(
                              radius: context.mw * 0.060,
                              backgroundColor: AppColor.mehroonColor,
                              child: Icon(
                                IconlyBold.heart,
                                color: AppColor.whiteColor,
                                size: context.mw * 0.050,
                              ),
                            ),
                            title: Text(data['title'],
                                style: GoogleFonts.poppins(
                                  fontSize: context.mh * 0.018,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.mehroonColor,
                                )),
                            subtitle: Text(
                              data['body'],
                            ),
                            trailing: InkWell(
                              onTap: () {
                                Get.toNamed(
                                    RoutesNames.detailtrackDonnationScreen,
                                    arguments: [
                                      data['Status'],
                                      data['time'],
                                    ]);
                              },
                              child: Container(
                                width: context.mw * 0.20,
                                height: context.mh * 0.05,
                                decoration: BoxDecoration(
                                    color: AppColor.mehroonColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Track',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
