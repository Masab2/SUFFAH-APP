// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class SuffaCenterMembersComp extends StatelessWidget {
  VoidCallback ontap;
  String customername, email, address, centerId;
  SuffaCenterMembersComp(
      {super.key,
      required this.customername,
      required this.email,
      required this.ontap,
      required this.centerId,
      required this.address});

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
                    child: Image(image: AssetImage(ImageAsset.islamicIcon))),
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
                                  color: AppColor.mehroonColor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
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
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
              child: MaterialButton(
                minWidth: context.mw * 0.80,
                color: AppColor.mehroonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: ontap,
                child: Text('View Details',
                    style: GoogleFonts.poppins(color: AppColor.whiteColor)),
              )),
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
