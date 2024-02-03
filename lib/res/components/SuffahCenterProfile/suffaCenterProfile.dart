import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class UserInfoListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const UserInfoListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: context.mh * 0.030,
        backgroundColor: AppColor.cgreenColor,
        child: Icon(
          icon,
          color: AppColor.whiteColor,
        ),
      ),
      selectedColor: AppColor.cgreenColor.withOpacity(0.23),
      splashColor: AppColor.cgreenColor.withOpacity(0.23),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle),
    );
  }
}

class SettingInfoListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget traling;
  final VoidCallback? ontap;
  const SettingInfoListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.traling,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: Icon(
        icon,
        color: AppColor.cgreenColor,
      ),
      selectedColor: AppColor.cgreenColor.withOpacity(0.23),
      splashColor: AppColor.cgreenColor.withOpacity(0.23),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle),
      trailing: traling,
    );
  }
}

// class LogOutListTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback ontap;
//   const LogOutListTile(
//       {super.key,
//       required this.icon,
//       required this.title,
//       required this.ontap});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: ontap,
//       leading: CircleAvatar(
//         backgroundColor: AppColor.lightColor,
//         child: Icon(
//           icon,
//           color: AppColor.amberColor,
//         ),
//       ),
//       selectedColor: AppColor.lightColor,
//       splashColor: AppColor.lightColor,
//       textColor: AppColor.whiteColor,
//       title: Text(title),
//     );
//   }
// }
