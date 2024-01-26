import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class MasjidDisplayComp extends StatelessWidget {
  final String masjidname, image, masjidaddress, muntazimid;
  final String program;
  final VoidCallback ontap;
  const MasjidDisplayComp(
      {super.key,
      required this.masjidname,
      required this.image,
      required this.masjidaddress,
      required this.ontap,
      required this.program, required this.muntazimid});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColor.blackColor.withOpacity(0.33),
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: CachedNetworkImage(
                  height: context.mh * 0.20,
                  width: context.mw,
                  imageUrl: image,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => const SpinKitChasingDots(
                    color: AppColor.cgreenColor,
                    duration: Duration(seconds: 5),
                    size: 40,
                  ),
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
              0.02.ph,
              Row(
                children: [
                  0.03.pw,
                  Container(
                    height: context.mh * 0.04,
                    width: context.mw * 0.30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.geryColor.withOpacity(0.33),
                    ),
                    child: Center(
                      child: Text(
                        program,
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.013,
                        ),
                      ),
                    ),
                  ),
                  0.02.pw,
                  Container(
                    height: context.mh * 0.04,
                    width: context.mw * 0.30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.geryColor.withOpacity(0.33),
                    ),
                    child: Center(
                      child: Text(
                        masjidname,
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.013,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              0.03.ph,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Meal Shared',
                          style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.020,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '10000',
                          style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.018,
                            fontWeight: FontWeight.bold,
                            color: AppColor.cgreenColor,
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder(
                        stream: Apis.getAllNeedyPeopleByProgram(
                            program, muntazimid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SpinKitChasingDots(
                                color: AppColor.cgreenColor,
                                duration: Duration(seconds: 5),
                                size: 40,
                              ),
                            );
                          } else if (!snapshot.hasData) {
                            return const Center(child: Text('No Data Found'));
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'People Waiting',
                                  style: GoogleFonts.poppins(
                                    fontSize: context.mh * 0.020,
                                    fontWeight: FontWeight.bold,
                                    // color: AppColor.cgreenColor,
                                  ),
                                ),
                                Text(
                                  snapshot.data!.docs.length.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: context.mh * 0.018,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.cgreenColor,
                                  ),
                                ),
                              ],
                            );
                          }
                        }),
                  ],
                ),
              ),
              0.02.ph,
              MaterialButton(
                minWidth: context.mw * 0.80,
                height: context.mh * 0.06,
                color: AppColor.cgreenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {},
                child: Text(
                  'Donate In this Masjid',
                  style: GoogleFonts.poppins(
                    fontSize: context.mh * 0.020,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
              0.02.ph,
            ],
          ),
        ),
        0.02.ph,
      ],
    );
  }
}
