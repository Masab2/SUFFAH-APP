import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/Donner/ZakatCalculatorViewModel/ZakatCalculatorViewModel.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ZakatCalculator extends StatefulWidget {
  const ZakatCalculator({super.key});

  @override
  State<ZakatCalculator> createState() => _ZakatCalculatorState();
}

class _ZakatCalculatorState extends State<ZakatCalculator> {
  final TextEditingController savingController = TextEditingController();
  final TextEditingController assetsController = TextEditingController();
  final TextEditingController debitsController = TextEditingController();
  final TextEditingController otherWealthController = TextEditingController();
  final controller = Get.put(ZakatCalculatorViewModel());
  @override
  void dispose() {
    super.dispose();
    savingController.dispose();
    assetsController.dispose();
    debitsController.dispose();
    otherWealthController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: context.mh * 0.30,
              width: context.mw,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColor.mehroonColor,
                    AppColor.brownColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Text(
                  l10n!.zakatCalculatorTitle,
                  style: GoogleFonts.poppins(
                    fontSize: context.mh * 0.029,
                    fontWeight: FontWeight.w500,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
            ),
            0.03.ph,
            CustomizedFeild(
              controller: savingController,
              title: l10n.depositedsavinggirasTitle,
              keyboardtype: TextInputType.number,
            ),
            0.02.ph,
            CustomizedFeild(
              controller: assetsController,
              title: l10n.propertyVechicleTitle,
              keyboardtype: TextInputType.number,
            ),
            0.02.ph,
            CustomizedFeild(
              controller: debitsController,
              title: l10n.debtsTitle,
              keyboardtype: TextInputType.number,
            ),
            0.02.ph,
            CustomizedFeild(
              controller: otherWealthController,
              title: l10n.otherWealthTitle,
              keyboardtype: TextInputType.number,
            ),
            0.04.ph,
            ReuseAblebtn(
              title: l10n.calculateZakatButton,
              onPressed: () {
                controller.calculateZakat(
                  savingController,
                  assetsController,
                  debitsController,
                  otherWealthController,
                  context,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
