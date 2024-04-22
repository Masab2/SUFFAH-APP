import 'dart:io';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/ViewModel/Admin/addProgram/addAffilatedprogramViewModel.dart';
import 'package:suffa_app/res/components/AddNeedyPeople/addNeedyPeopleComp.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/BottomSheetContainer.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/PickImage.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AddProgramsView extends StatefulWidget {
  const AddProgramsView({super.key});

  @override
  State<AddProgramsView> createState() => _AddProgramsViewState();
}

class _AddProgramsViewState extends State<AddProgramsView> {
  final titleController = TextEditingController();
  final purposeController = TextEditingController();
  final priceController = TextEditingController();
  final controller = Get.put(AffiliatedViewModel());
  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    controller.dispose();
    purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Program',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.024,
            fontWeight: FontWeight.bold,
          ),
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
          AddNeedyPeopleComp(
              title: 'Purpose',
              icon: Icons.description,
              hint: 'Rashan Pack',
              controller: purposeController),
          0.01.ph,
          Obx(() {
            return Row(
              children: [
                Expanded(
                  child: AddNeedyPeopleComp(
                    title: 'Donation Price',
                    icon: Icons.title,
                    hint: '${controller.selectedCurrency.value} 00',
                    controller: priceController,
                  ),
                ),
                Column(
                  children: [
                    0.02.ph,
                    InkWell(
                      onTap: () {
                        showCurrencyPicker(
                          context: context,
                          showFlag: true,
                          showSearchField: true,
                          showCurrencyName: true,
                          showCurrencyCode: true,
                          favorite: ['PKR'],
                          onSelect: (Currency currency) {
                            controller.selectedCurrency.value = currency.code;
                          },
                        );
                      },
                      child: Container(
                          width: context.mw * 0.20,
                          height: context.mh * 0.07,
                          margin: EdgeInsets.only(right: context.mw * 0.02),
                          decoration: BoxDecoration(
                              color: AppColor.mehroonColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            controller.selectedCurrency.value,
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.018,
                              color: AppColor.whiteColor,
                            ),
                          ))),
                    ),
                  ],
                ),
              ],
            );
          }),
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
                      BorderSide(color: AppColor.mehroonColor))),
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
          0.03.ph,
          Padding(
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
              child: ReuseAblebtn(
                title: 'Add Program',
                onPressed: () {
                  controller.addAffiliatedProgram(
                    titleController,
                    controller.selectedValue.value,
                    priceController,
                    purposeController,
                  );
                },
              )),
        ],
      ),
    );
  }
}
