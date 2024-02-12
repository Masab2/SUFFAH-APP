import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class RequestedProgramComp extends StatelessWidget {
  final String image, programTitle, masjidname;
  final VoidCallback ontapDescrip;
  final VoidCallback ontapAccept;
  const RequestedProgramComp(
      {super.key,
      required this.image,
      required this.programTitle,
      required this.masjidname,
      required this.ontapDescrip,
      required this.ontapAccept});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
          child: ListTile(
            onTap: ontapDescrip,
            style: ListTileStyle.list,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            mouseCursor: MouseCursor.uncontrolled,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.mw * 0.03,
            ),
            selectedColor: AppColor.blackColor,
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColor.blackColor,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: AppColor.whiteColor,
                onBackgroundImageError: (exception, stackTrace) {
                  Get.snackbar('Error', exception.toString());
                },
                backgroundImage: NetworkImage(image),
                radius: context.mh * 0.050,
              ),
            ),
            title: Text(
              programTitle,
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.020,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              masjidname,
              style: GoogleFonts.poppins(),
            ),
            trailing: MaterialButton(
              color: AppColor.cgreenColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: ontapAccept,
              child: Text(
                'Accept',
                style: GoogleFonts.poppins(
                  fontSize: context.mh * 0.018,
                  color: AppColor.whiteColor,
                ),
              ),
            ),
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
