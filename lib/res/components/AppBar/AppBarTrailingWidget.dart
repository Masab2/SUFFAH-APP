import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AppBarTrailing extends StatelessWidget {
  final String currency, language;
  final VoidCallback onCurrency, onlanguage;
  const AppBarTrailing(
      {super.key,
      required this.currency,
      required this.language,
      required this.onCurrency,
      required this.onlanguage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        0.01.ph,
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog.adaptive(
                    title: const Text('Select Language'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildLanguageItem(context, 'en', 'English'),
                        buildLanguageItem(context, 'de', 'German'),
                        buildLanguageItem(context, 'ur', 'Urdu'),
                      ],
                    ));
              },
            );
          },
          child: Row(
            children: [
              0.02.pw,
              Icon(
                Icons.language,
                size: context.mh * 0.020,
              ),
              Text(
                language,
                style: GoogleFonts.poppins(
                  color: AppColor.whiteColor,
                  fontSize: context.mh * 0.013,
                ),
              ),
            ],
          ),
        ),
        0.003.ph,
        InkWell(
          onTap: onCurrency,
          child: Obx(() {
            return Row(
              children: [
                0.02.pw,
                Icon(
                  Icons.monetization_on_outlined,
                  size: context.mh * 0.020,
                ),
                Text(
                  currency,
                  style: GoogleFonts.poppins(
                    color: AppColor.whiteColor,
                    fontSize: context.mh * 0.013,
                  ),
                ),
                0.02.pw,
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget buildLanguageItem(
      BuildContext context, String languageCode, String languageName) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(
        languageName,
        style: GoogleFonts.poppins(
          fontSize: context.mh * 0.018,
        ),
      ),
      onTap: onlanguage,
    );
  }
}
