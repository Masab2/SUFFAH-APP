import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/Donner/SplashViewModel/SplashViewModel.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final splashController = Get.put(SplashViewModel());
  @override
  void initState() {
    splashController.isLogin();
    super.initState();
  }

  @override
  void dispose() {
    splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            0.3.ph,
            Center(
              child: Image(
                image: AssetImage(ImageAsset.applogo),
                height: context.mw * 0.6,
                width: context.mw * 0.6,
              ),
            ),
            0.02.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  """ “${l10n?.taglineOne ?? ""}  """,
                  style: GoogleFonts.poppins(
                    color: AppColor.mehroonColor,
                    fontSize: context.mh * 0.014,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  """ ${l10n!.taglineTwo}” """,
                  style: GoogleFonts.poppins(
                    color: AppColor.mehroonColor,
                    fontSize: context.mh * 0.014,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
