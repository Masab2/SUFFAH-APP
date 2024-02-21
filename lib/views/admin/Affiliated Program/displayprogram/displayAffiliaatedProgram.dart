import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DisplayAffiliatedProgram extends StatefulWidget {
  const DisplayAffiliatedProgram({Key? key}) : super(key: key);

  @override
  State<DisplayAffiliatedProgram> createState() =>
      _DisplayAffiliatedProgramState();
}

class _DisplayAffiliatedProgramState extends State<DisplayAffiliatedProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Affiliated Program',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.024,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
                    
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(
          Icons.description,
          color: AppColor.whiteColor,
        ),
        onPressed: () {
          Get.toNamed(RoutesNames.addaffiliatedProgramScreenforAdmin);
        },
        label: Text(
          'Add Program',
          style: GoogleFonts.poppins(
            color: AppColor.whiteColor,
            fontSize: context.mh * 0.018,
          ),
        ),
      ),
    );
  }
}
