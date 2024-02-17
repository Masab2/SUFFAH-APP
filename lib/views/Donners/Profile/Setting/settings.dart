import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/Lang/LanguageChangeViewModel.dart';
import 'package:suffa_app/res/components/SuffahCenterProfile/suffaCenterProfile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.appSetting,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          0.03.ph,
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
