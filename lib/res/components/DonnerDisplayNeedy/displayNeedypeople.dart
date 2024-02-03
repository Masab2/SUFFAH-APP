import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DisplayNeedyPeopleComp extends StatelessWidget {
  final String masjidname, image, masjidaddress, muntazimid;
  final String program;
  final VoidCallback ontap;
  final Widget traling;
  const DisplayNeedyPeopleComp(
      {super.key,
      required this.masjidname,
      required this.image,
      required this.masjidaddress,
      required this.ontap,
      required this.program,
      required this.muntazimid,
      required this.traling});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
          child: ListTile(
            onTap: ontap,
            style: ListTileStyle.list,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            mouseCursor: MouseCursor.uncontrolled,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.mw * 0.02,
            ),
            selectedColor: AppColor.blackColor,
            leading: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.blackColor,
                  )),
              child: CircleAvatar(
                onBackgroundImageError: (exception, stackTrace) {
                  Get.snackbar('Error', exception.toString());
                },
                backgroundImage: NetworkImage(image),
                radius: context.mh * 0.050,
              ),
            ),
            title: Text(
              masjidname,
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.020,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              masjidaddress,
              style: GoogleFonts.poppins(),
            ),
            trailing: traling,
          ),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        )
      ],
    );
  }
}
