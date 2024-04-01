import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/Lang/LanguageChangeViewModel.dart';
import 'package:suffa_app/res/components/SuffahCenterProfile/suffaCenterProfile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DonnerSettings extends StatefulWidget {
  const DonnerSettings({super.key});

  @override
  State<DonnerSettings> createState() => _DonnerSettingsState();
}

class _DonnerSettingsState extends State<DonnerSettings> {
  final langController = Get.put(AppLanguageController());
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: context.mh * 0.30,
                width: context.mw,
                decoration: const BoxDecoration(
                  color: AppColor.brownColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings,
                      size: context.mh * 0.15,
                      color: Colors.black38,
                    ),
                    Text(
                      l10n!.appSetting,
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.028,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: context.mw * 0.01,
                top: context.mh * 0.05,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
              )
            ],
          ),
          0.03.ph,
          // Expanded(
          //   child: Obx(
          //     () {
          //       return CSCPicker(
          //         selectedItemStyle:
          //             const TextStyle(color: AppColor.whiteColor),
          //         dropdownDecoration: const BoxDecoration(
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(10),
          //           ),
          //           color: AppColor.brownColor,
          //         ),
          //         layout: Layout.horizontal,
          //         showCities: false,
          //         showStates: false,
          //         flagState: CountryFlag.DISABLE,
          //         currentCountry: homeController.country.value,
          //         onCountryChanged: (value) {
          //           log(homeController.country.value.toString());
          //           homeController.updateCountry(value);
          //           log(value);
          //         },
          //         onStateChanged: (value) {
          //           homeController.onCityChanged(value ?? '');
          //         },
          //         onCityChanged: (value) {
          //           homeController.onStateChanged(value ?? '');
          //         },
          //       );
          //     },
          //   ),
          // ),
          SettingInfoListTile(
            icon: Icons.language,
            title: AppLocalizations.of(context)!.langHeading,
            subtitle: AppLocalizations.of(context)!.langSubtitle,
            traling: DropdownButton<String>(
              value: langController.appLocal?.languageCode ?? 'en',
              icon: const Icon(Icons.keyboard_arrow_down),
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'de', child: Text('German')),
                DropdownMenuItem(value: 'ur', child: Text('Urdu')),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  langController.changeLanguage(Locale(newValue));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
