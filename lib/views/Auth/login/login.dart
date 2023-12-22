import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/res/components/loginOrRow/loginOrRow.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              height: context.mh * 0.55,
              decoration: const BoxDecoration(
                  color: AppColor.cgreenColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  )),
            ),
            Positioned(
                top: 20,
                right: 50,
                left: 50,
                child: Image(image: AssetImage(ImageAsset.applogo))),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Padding(
                padding: EdgeInsets.only(
                  top: context.mh * 0.35,
                  left: context.mw * 0.05,
                  right: context.mw * 0.05,
                ),
                child: Container(
                  height: context.mh * 0.55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sign In to your accocunt',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        0.03.ph,
                        CustomizedFeild(
                            controller: emailController,
                            title: 'Email',
                            prefixIcon: const Icon(
                              IconlyBold.message,
                            )),
                        0.02.ph,
                        CustomizedFeild(
                            controller: emailController,
                            title: 'Password',
                            prefixIcon: const Icon(
                              IconlyBold.password,
                            )),
                        0.03.ph,
                        MaterialButton(
                          height: context.mh * 0.05,
                          minWidth: context.mw * 0.80,
                          color: AppColor.cgreenColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {},
                          child: Text(
                            'Login',
                            style:
                                GoogleFonts.poppins(color: AppColor.whiteColor),
                          ),
                        ),
                        0.03.ph,
                        const LoginOrRow(),
                        0.02.ph,
                        SignInButton(
                          buttonType: ButtonType.google,
                          onPressed: () {},
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
        0.02.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Dont't have an account",
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: AppColor.geryColor,
                  fontWeight: FontWeight.bold),
            ),
            0.01.pw,
            InkWell(
              onTap: () {
                Get.toNamed(RoutesNames.signUpScreen);
              },
              child: Text(
                "Sign Up",
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: AppColor.cgreenColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
