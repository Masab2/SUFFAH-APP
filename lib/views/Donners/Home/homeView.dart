import 'dart:developer';

import 'package:csc_picker/csc_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/Donner/HomeViewModel/HomeViewModel.dart';
import 'package:suffa_app/ViewModel/Lang/LanguageChangeViewModel.dart';
import 'package:suffa_app/res/components/AppBar/AppBar.dart';
import 'package:suffa_app/res/components/HomeComp/donnationChoices/DonnationChoiceComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeViewModel());
  final langController = Get.put(AppLanguageController());

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: HomeAppBar.HomeBar(
        context,
        Row(
          children: [
            0.02.pw,
            Expanded(child: Obx(() {
              return CSCPicker(
                defaultCountry: CscCountry.Pakistan,
                dropdownDecoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: AppColor.brownColor,
                ),
                layout: Layout.horizontal,
                showCities: false,
                showStates: false,
                flagState: CountryFlag.ENABLE,
                currentCountry: homeController.country.value,
                onCountryChanged: (value) {
                  log(homeController.country.value.toString());
                  homeController.updateCountry(value);
                  log(value);
                },
                onStateChanged: (value) {
                  homeController.onCityChanged(value ?? '');
                },
                onCityChanged: (value) {
                  homeController.onStateChanged(value ?? '');
                },
              );
            })),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      langController.appLocal?.languageCode ?? 'en',
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
                onTap: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showSearchField: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    favorite: ['PKR'],
                    onSelect: (Currency currency) {
                      homeController.selectedCurrency.value = currency.code;
                    },
                  );
                },
                child: Obx(() {
                  return Row(
                    children: [
                      0.02.pw,
                      Icon(
                        Icons.monetization_on_outlined,
                        size: context.mh * 0.020,
                      ),
                      Text(
                        homeController.selectedCurrency.value,
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
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [
            0.02.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n!.ourDonnationTitle,
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.017,
                      fontWeight: FontWeight.w600,
                      color: AppColor.mehroonColor,
                    ),
                  ),
                  Text(
                    l10n.seeAll,
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.017,
                      fontWeight: FontWeight.w600,
                      color: AppColor.mehroonColor,
                    ),
                  ),
                ],
              ),
            ),
            0.01.ph,
            StreamBuilder(
              stream: Apis.getAllPrograms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitChasingDots(
                      color: AppColor.mehroonColor,
                      duration: Duration(seconds: 5),
                      size: 40,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No Data');
                } else {
                  return SizedBox(
                    height: context.mh * 0.36,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return DonnationChoice(
                          image: data['image'],
                          title: data['programTitle'],
                          ontap: () {
                            Get.toNamed(RoutesNames.selectMasjidScreen,
                                arguments: [
                                  data['programTitle'],
                                  data['Price'],
                                ]);
                          },
                          program: data['programTitle'],
                        );
                      },
                    ),
                  );
                }
              },
            ),
            0.01.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      l10n.masjidDonateTitle,
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.017,
                        fontWeight: FontWeight.w600,
                        color: AppColor.mehroonColor,
                      ),
                    ),
                  ),
                  Text(
                    l10n.seeAll,
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.017,
                      fontWeight: FontWeight.w600,
                      color: AppColor.mehroonColor,
                    ),
                  ),
                ],
              ),
            ),
            0.01.ph,
            StreamBuilder(
              stream: Apis.getAllSuffahCenterDefinePrograms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitChasingDots(
                      color: AppColor.mehroonColor,
                      duration: Duration(seconds: 5),
                      size: 40,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No Data');
                } else {
                  return SizedBox(
                    height: context.mh * 0.3,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return DonnationChoiceMasjidComp(
                          image: data['image'],
                          title: data['programTitle'],
                          ontap: () {
                            Get.toNamed(
                              RoutesNames.selectMasjidScreen,
                              arguments: [
                                data['programTitle'],
                                data['Price'],
                              ],
                            );
                          },
                          program: data['programTitle'],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
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
      onTap: () {
        langController.changeLanguage(Locale(languageCode));
        Navigator.pop(context); // Close the dialog
      },
    );
  }
}
