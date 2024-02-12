import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/ViewModel/Admin/addProgram/addAffilatedprogramViewModel.dart';
import 'package:suffa_app/res/components/AddNeedyPeople/addNeedyPeopleComp.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/BottomSheetContainer.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/PickImage.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AddProgramsView extends StatefulWidget {
  const AddProgramsView({super.key});

  @override
  State<AddProgramsView> createState() => _AddProgramsViewState();
}

class _AddProgramsViewState extends State<AddProgramsView> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final controller = Get.put(AffiliatedViewModel());
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
          Obx(
            () => controller.imagePath.isEmpty
                ? PickImageWidget(
                    ontap: () {
                      Get.bottomSheet(BottomSheetContainer(
                        ongallery: () {
                          controller.getImageFromgallery(ImageSource.gallery);
                        },
                        oncamera: () {
                          controller.getImageFromgallery(ImageSource.camera);
                        },
                      ));
                    },
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.mw * 0.04),
                    child: SizedBox(
                      height: context.mh * 0.20,
                      width: context.mw * 0.60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                            height: context.mh * 0.20,
                            width: context.mw * 0.40,
                            fit: BoxFit.cover,
                            image: FileImage(
                                File(controller.imagePath.toString()))),
                      ),
                    ),
                  ),
          ),
          0.05.ph,
          AddNeedyPeopleComp(
              title: 'Program Title',
              icon: Icons.title,
              hint: 'Rashan Pack',
              controller: titleController),
          0.01.ph,
          AddNeedyPeopleComp(
              title: 'Donnation Price',
              icon: Icons.title,
              hint: '00 PKR',
              controller: priceController),
          0.02.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
            child: Text(
              'Select Status',
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.020,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
              margin: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: const Border.fromBorderSide(
                      BorderSide(color: AppColor.cgreenColor))),
              child: DropdownButton<String>(
                isExpanded: true,
                value: controller.selectedValue.value,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: controller.programs.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  controller.onItemSelected(newValue);
                },
              ),
            ),
          ),
          0.05.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
            child: MaterialButton(
              minWidth: context.mw * 0.80,
              height: context.mh * 0.06,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                controller.addAffiliatedProgram(
                  titleController,
                  controller.selectedValue.value,
                  priceController,
                );
              },
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
