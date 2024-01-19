import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';

class LoginOrRow extends StatelessWidget {
  const LoginOrRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            endIndent: 20,
            indent: 30,
            thickness: 1,
            color: AppColor.geryColor,
          ),
        ),
        Text(
          'OR',
          style: GoogleFonts.poppins(
              color: AppColor.geryColor),
        ),
        const Expanded(
          child: Divider(
            endIndent: 30,
            indent: 20,
            thickness: 1,
            color: AppColor.geryColor,
          ),
        ),
      ],
    );
  }
}
