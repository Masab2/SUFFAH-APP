import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/DonnorAuth/loginViewModel.dart';
import 'package:suffa_app/utils/color/appColor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(LoginViewModel());
  @override
  void dispose() {
    super.dispose();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
            onPressed: () {
              controller.logOutAccount();
            },
            child: Text(
              'LogOut',
              style: GoogleFonts.roboto(
                  fontSize: 13,
                  color: AppColor.cgreenColor,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
