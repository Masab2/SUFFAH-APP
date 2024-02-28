import 'package:flutter/material.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

import '../../../../utils/color/appColor.dart';

class UpperHeading extends StatelessWidget {
  final IconData icon;
  final String title;
  const UpperHeading({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
      margin: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.mehroonColor,
        borderRadius: BorderRadius.circular(20),
      ),
      height: context.mh * 0.200, // Adjust the height as needed
      // Change the background color as needed
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: context.mh * 0.060,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                size: context.mh * 0.050,
                color: AppColor.mehroonColor,
              ),
            ),
            0.01.ph,
            Text(
              title,
              style: TextStyle(
                fontSize: context.mh * 0.024,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
