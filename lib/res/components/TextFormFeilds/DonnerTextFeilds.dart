import 'package:flutter/material.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DonnerTextFeilsComp extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final IconData icon;
  final VoidCallback ? ontap;
  const DonnerTextFeilsComp(
      {super.key,
      required this.hint,
      this.onChanged,
      required this.controller,
      required this.icon, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.mh * 0.06,
          margin: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                AppColor.mehroonColor,
                AppColor.brownColor,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.topRight,
            ),
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColor.whiteColor,
              ),
            ),
            onChanged: onChanged,
          ),
        ),
        Positioned(
          top: 0,
          right: context.mw * 0.040,
          child: InkWell(
            onTap: ontap,
            child: Container(
              height: context.mw * 0.13,
              width: context.mw * 0.13,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.masjidgeryColor,
              ),
              child: Center(
                child: Icon(icon),
              ),
            ),
          ),
        )
      ],
    );
  }
}
