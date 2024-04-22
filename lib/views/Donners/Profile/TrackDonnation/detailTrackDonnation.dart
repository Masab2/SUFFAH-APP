import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DetailTrackDonnation extends StatefulWidget {
  const DetailTrackDonnation({super.key});

  @override
  State<DetailTrackDonnation> createState() => _DetailTrackDonnationState();
}

class _DetailTrackDonnationState extends State<DetailTrackDonnation> {
  late String Status;
  late String time;
  
  @override
  void initState() {
    Status = Get.arguments[0];
    time = Get.arguments[1];
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Track Donnation',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.024,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.mehroonColor,
                AppColor.brownColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stepper(
            steps: [
              Step(
                title: const Text('Received By Admin'),
                content: const Text('Content for Step 1'),
                state: Status == 'Recived by Admin' ? StepState.complete : StepState.indexed,
                isActive: Status == 'Recived by Admin' ? true : false,
              ),
              Step(
                title: const Text('Received By Shops'),
                content: const Text('Content for Step 2'),
                state: Status == 'Recived Shop' ? StepState.complete : StepState.indexed,
                isActive: Status == 'Recived Shop' ? true : false,
              ),
              Step(
                title: const Text('Received by Person'),
                content: const Text('Content for Step 3'),
                state: Status == 'Recived by Admin' ? StepState.complete : StepState.indexed,
                isActive: Status == 'Recived by Person' ? true : false,
              ),
            ],
          ),         
        ],
      ),
    );
  }
}