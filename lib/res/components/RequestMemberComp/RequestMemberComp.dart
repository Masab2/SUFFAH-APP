// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class RequestMemberComp extends StatelessWidget {
  final VoidCallback onAccept, onReject;
  final String customername, image, email, address, centerId, city;
  const RequestMemberComp(
      {super.key,
      required this.customername,
      required this.image,
      required this.email,
      required this.onAccept,
      required this.centerId,
      required this.address,
      required this.city,
      required this.onReject});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(centerId,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColor.geryColor,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
                height: context.mh * 0.20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    height: context.mh * 0.10,
                    width: context.mw / 2.9,
                    imageUrl: image,
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
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
                height: context.mh * 0.20,
                width: context.mw / 2.2,
                // color: AppColor.geryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(customername,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: AppColor.geryColor,
                            fontWeight: FontWeight.bold)),
                    0.01.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('$email',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppColor.cgreenColor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    0.01.ph,
                    Text('$city'.toUpperCase(),
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppColor.geryColor,
                            fontWeight: FontWeight.bold)),
                    0.01.ph,
                    Text(address.toUpperCase(),
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          0.01.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MaterialButton(
                    minWidth: context.mw * 0.30,
                    color: AppColor.cgreenColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: onAccept,
                    child: Text('Accept',
                        style: GoogleFonts.poppins(color: AppColor.whiteColor)),
                  ),
                ),
                0.02.pw,
                Expanded(
                  child: MaterialButton(
                    minWidth: context.mw * 0.30,
                    color: AppColor.geryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: onReject,
                    child: Text('Reject',
                        style: GoogleFonts.poppins(color: AppColor.whiteColor)),
                  ),
                ),
              ],
            ),
          ),
          0.02.ph,
          const Divider(
            thickness: 2.0,
            endIndent: 20,
            indent: 20,
            color: AppColor.geryColor,
          )
        ],
      ),
    );
  }
}
