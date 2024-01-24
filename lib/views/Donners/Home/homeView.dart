import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/components/HomeComp/donnationChoices/DonnationChoiceComp.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: 'SUFFAH ',
                style: GoogleFonts.poppins(
                    fontSize: 23,
                    color: AppColor.cgreenColor,
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: 'APP',
                  style: GoogleFonts.poppins(
                      fontSize: 23,
                      color: AppColor.geryColor,
                      fontWeight: FontWeight.bold))
            ])),
        centerTitle: true,
      ),
      body: Column(
        children: [
          0.05.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
            child: Row(
              children: [
                Text(
                  'Our Donnation Choices',
                  style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.020,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          0.02.ph,
          DonnationChoice(
            image: ImageAsset.hungryimg,
            title: 'One Time Meal',
            ontap: () {},
          ),
          0.04.ph,
          DonnationChoice(
            image: ImageAsset.rashanimg,
            title: 'Rashan Program',
            ontap: () {},
          )
        ],
      ),
    );
  }
}
