import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/addAffilated/addAffiliatedProgramViewModel.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AddAffiliatedProgram extends StatefulWidget {
  const AddAffiliatedProgram({super.key});

  @override
  State<AddAffiliatedProgram> createState() => _AddAffiliatedProgramState();
}

class _AddAffiliatedProgramState extends State<AddAffiliatedProgram> {
  final programController = Get.put(AddAffiliatedViewModel());
  final titleController = TextEditingController();
  late String id;
  @override
  void initState() {
    id = Get.arguments ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Al SUFFAH Programs',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.020,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(() {
              if (programController.program.isEmpty) {
                return const Center(
                  child: SpinKitChasingDots(
                    color: AppColor.cgreenColor,
                    duration: Duration(seconds: 5),
                    size: 40,
                  ),
                );
              } else {
                return Column(
                  children: [
                    0.02.ph,
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: programController.program.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = programController.program[index];
                        return CheckboxListTile.adaptive(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: context.mw * 0.08,
                          ),
                          title: Text(
                            data.programTitle,
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.020,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: data.isSelected,
                          onChanged: (value) {
                            log(value.toString());
                            setState(() {
                             
                            });
                          },
                        );
                      },
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.mw * 0.06, vertical: context.mh * 0.03),
        child: MaterialButton(
          minWidth: context.mw * 0.80,
          height: context.mh * 0.06,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {},
          color: AppColor.cgreenColor,
          child: Text(
            'Request for New Program',
            style: GoogleFonts.poppins(
                color: AppColor.whiteColor,
                fontSize: context.mh * 0.020,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
