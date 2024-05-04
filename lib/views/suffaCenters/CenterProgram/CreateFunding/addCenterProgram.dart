import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/res/components/AddNeedyPeople/addNeedyPeopleComp.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/PickImage.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/loginOrRow/loginOrRow.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

import '../../../../ViewModel/SuffahCenter/addAffilated/addAffiliatedProgramViewModel.dart';
import '../../../../res/components/AddSuffahCenter/BottomSheetContainer.dart';
import '../../../../res/components/CNICFormComp/CnicFormComp.dart';

class AddCenterProgramView extends StatefulWidget {
  const AddCenterProgramView({super.key});

  @override
  State<AddCenterProgramView> createState() => _AddCenterProgramViewState();
}

class _AddCenterProgramViewState extends State<AddCenterProgramView> {
  final AddCenterProgramController controller =
      Get.put(AddCenterProgramController());
  late String id;
  late String masjidname;
  late String masjidId;
  late String muntazimEmail;
  late String address;
  late String country;
  late String state;
  late String city;
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var purposeController = TextEditingController();
  var holdernameController = TextEditingController();
  var cnicnoController = TextEditingController();
  var doIssueController = TextEditingController();
  var doExpireController = TextEditingController();
  var dobController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  void initState() {
    id = Get.arguments[0];
    masjidname = Get.arguments[1];
    masjidId = Get.arguments[2];
    muntazimEmail = Get.arguments[3];
    address = Get.arguments[4];
    country = Get.arguments[5];
    state = Get.arguments[6];
    city = Get.arguments[7];
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    purposeController.dispose();
    holdernameController.dispose();
    cnicnoController.dispose();
    doIssueController.dispose();
    doExpireController.dispose();
    dobController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Center Program',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.024,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Obx(
              () => controller.imagePath.isEmpty
                  ? PickImageWidgetCircle(
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
            AddNeedyPeopleComp(
                title: 'Title',
                icon: Icons.person,
                hint: 'For Masjid / SuffaPerson',
                controller: titleController),
            AddNeedyPeopleComp(
                title: 'Required Price',
                icon: Icons.person,
                hint: 'Masab / Ayesha',
                controller: priceController),
            AddNeedyPeopleComp(
                title: 'Phone No',
                icon: Icons.person,
                hint: '*********',
                controller: phoneController),
            AddNeedyPeopleComp(
              title: 'Purpose',
              icon: Icons.person,
              hint: 'For Needy People / For Masjid etc',
              controller: purposeController,
            ),
            0.02.ph,
            CnicFormComp(
              cardHoldername: holdernameController,
              doIssue: doIssueController,
              doExpire: doExpireController,
              doBirth: dobController,
              cnicno: cnicnoController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.mw * 0.06,
                vertical: context.mw * 0.03,
              ),
              child: ReuseAblebtn(
                title: 'Insert Data',
                onPressed: () {
                  controller.requestProgramManually(
                    titleController,
                    priceController,
                    purposeController,
                    holdernameController,
                    cnicnoController,
                    dobController,
                    doIssueController,
                    doExpireController,
                    'Requested',
                    id,
                    masjidname,
                    masjidId,
                    muntazimEmail,
                    phoneController,
                    address,
                    country,
                    state,
                    city,
                    context,
                  );
                },
              )),
          const LoginOrRow(),
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.mw * 0.06,
                vertical: context.mw * 0.03,
              ),
              child: ReuseAblebtn(
                title: 'Scan Id Card',
                onPressed: () {
                  controller.scanIdcardforAutomate(
                    titleController,
                    priceController,
                    purposeController,
                    holdernameController,
                    cnicnoController,
                    dobController,
                    doIssueController,
                    doExpireController,
                    'Requested',
                    id,
                    masjidname,
                    masjidId,
                    muntazimEmail,
                    phoneController,
                    address,
                    country,
                    state,
                    city,
                    context,
                    ImageSource.camera,
                  );
                },
              )),
        ],
      ),
    );
  }
}
