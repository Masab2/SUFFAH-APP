// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DetailTrackDonation extends StatefulWidget {
  const DetailTrackDonation({Key? key}) : super(key: key);

  @override
  State<DetailTrackDonation> createState() => _DetailTrackDonationState();
}

class _DetailTrackDonationState extends State<DetailTrackDonation> {
  late String status;
  late String time;
  late String donationStatus;

  @override
  void initState() {
    status = Get.arguments[0];
    time = Get.arguments[1];
    donationStatus = Get.arguments[2];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Track Donation',
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StepIndicator(
                  title: 'Received By Admin',
                  isActive: status == 'Recived by Admin',
                ),
                _StepIndicator(
                  title: 'Received By Shops',
                  isActive: status == 'Received by Shop',
                ),
                _StepIndicator(
                  title: donationStatus == "forPerson"
                      ? 'Received by Person'
                      : 'Received by Masjid',
                  isActive: status == 'Received by Masjid' &&
                      donationStatus == "forPerson",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final String title;
  final bool isActive;
  final bool isLast;

  const _StepIndicator({
    required this.title,
    required this.isActive,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            0.03.pw,
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? AppColor.mehroonColor : Colors.grey,
              ),
              child: Center(
                child: Icon(
                  isActive ? Icons.check : Icons.radio_button_unchecked,
                  color: Colors.white,
                ),
              ),
            ),
            0.03.pw,
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isActive ? Colors.black : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (!isLast) // Add vertical line if it's not the last step
          Row(
            children: [
              0.03.pw,
              Container(
                width: 2,
                height: 70,
                color: isActive ? AppColor.mehroonColor : Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 15),
              ),
            ],
          ),
      ],
    );
  }
}
