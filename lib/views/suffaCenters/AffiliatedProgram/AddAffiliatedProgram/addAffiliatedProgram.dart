import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/components/AddNeedyPeople/addNeedyPeopleComp.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/BottomSheetContainer.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/PickImage.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AddAffiliatedProgram extends StatefulWidget {
  const AddAffiliatedProgram({super.key});

  @override
  State<AddAffiliatedProgram> createState() => _AddAffiliatedProgramState();
}

class _AddAffiliatedProgramState extends State<AddAffiliatedProgram> {
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Program',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          0.02.ph,
          PickImageWidget(
            title: 'Choose Banner',
            ontap: () {
              Get.bottomSheet(BottomSheetContainer(
                ongallery: () {
                  // peronalInfoController
                  //     .getImageFromgallery(ImageSource.gallery);
                },
                oncamera: () {
                  // peronalInfoController.getImageFromgallery(ImageSource.camera);
                },
              ));
            },
          ),
          0.05.ph,
          AddNeedyPeopleComp(
              title: 'Program Title',
              icon: Icons.title,
              hint: 'Rashan Pack',
              controller: titleController),
          0.05.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
            child: MaterialButton(
              minWidth: context.mw * 0.80,
              height: context.mh * 0.06,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {},
              color: AppColor.cgreenColor,
              child: Text(
                'Add Program',
                style: GoogleFonts.poppins(
                    color: AppColor.whiteColor,
                    fontSize: context.mh * 0.020,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
