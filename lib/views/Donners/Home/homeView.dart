import 'dart:developer';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Model/DonnationTrackMasjidModel/DonnationTrackMasjidModel.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/ViewModel/Donner/HomeViewModel/HomeViewModel.dart';
import 'package:suffa_app/ViewModel/Lang/LanguageChangeViewModel.dart';
import 'package:suffa_app/res/components/AppBar/AppBar.dart';
import 'package:suffa_app/res/components/HomeComp/donnationChoices/DonnationChoiceComp.dart';
import 'package:suffa_app/res/components/HomeComp/donnationChoices/MasjidProgramSeeAll/MasjidProgramSeeAll.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/Utils.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
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
  final langController = Get.find<AppLanguageController>();
  final TextEditingController donatecontroller = TextEditingController();

  @override
  void dispose() {
    donatecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: HomeAppBar.HomeBar(
        context,
        Row(
          children: [
            0.02.pw,
            Expanded(
              child: Obx(
                () {
                  return CSCPicker(
                    selectedItemStyle:
                        const TextStyle(color: AppColor.whiteColor),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: AppColor.brownColor,
                    ),
                    layout: Layout.horizontal,
                    showCities: false,
                    showStates: false,
                    flagState: CountryFlag.DISABLE,
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
                },
              ),
            ),
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
                        backgroundColor: AppColor.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(
                                image: AssetImage(ImageAsset.applogo),
                                height: context.mw * 0.4,
                                width: context.mw * 0.4,
                              ),
                              0.01.ph,
                              Text(
                                'Select Language',
                                style: GoogleFonts.roboto(
                                  fontSize: context.mh * 0.024,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              0.01.ph,
                              buildLanguageItem(context, 'en', 'English'),
                              buildLanguageItem(context, 'de', 'German'),
                              buildLanguageItem(context, 'ur', 'Urdu'),
                            ],
                          ),
                        ),
                      );
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog.adaptive(
                        backgroundColor: AppColor.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(
                                image: AssetImage(ImageAsset.applogo),
                                height: context.mw * 0.4,
                                width: context.mw * 0.4,
                              ),
                              0.01.ph,
                              Text(
                                'Select Currency',
                                style: GoogleFonts.roboto(
                                  fontSize: context.mh * 0.024,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              0.01.ph,
                              buildCurrencyItem(
                                  context, Icons.currency_rupee, 'PKR'),
                              buildCurrencyItem(
                                  context, Icons.currency_pound_rounded, 'EUR'),
                              buildCurrencyItem(
                                  context, Icons.attach_money, 'USD'),
                            ],
                          ),
                        ),
                      );
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
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutesNames.seeAllProgramsScreen, arguments: [
                        homeController.country.value,
                        homeController.selectedCurrency.value,
                      ]);
                    },
                    child: Text(
                      l10n.seeAll,
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.017,
                        fontWeight: FontWeight.w600,
                        color: AppColor.mehroonColor,
                      ),
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
                          onprogramClick: () {
                            Utils.showBottomSheetForProgramDefault(
                              () {},
                              data['programTitle'],
                              data['purpose'],
                              context,
                            );
                          },
                          image: data['image'],
                          title: data['programTitle'],
                          ontap: () {
                            Get.toNamed(
                              RoutesNames.selectMasjidScreen,
                              arguments: [
                                data['programTitle'],
                                data['Price'],
                                homeController.country.value,
                                data['image'],
                                homeController.selectedCurrency.value,
                                data['personDefine']
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
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutesNames.seeAllMasjidProgramScreen);
                    },
                    child: Text(
                      l10n.seeAll,
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.017,
                        fontWeight: FontWeight.w600,
                        color: AppColor.mehroonColor,
                      ),
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
                  return const Text('No Data Found');
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
                            Utils.showBottomSheetAmmount(
                              () {
                                final DonnationTrackMasjidModel model =
                                    DonnationTrackMasjidModel(
                                  donnationAmmount: donatecontroller.text,
                                  requiredDonnation: data['Price'],
                                  image: data['image'],
                                  currency:
                                      homeController.selectedCurrency.value,
                                  personcnic: data['CnicNo'],
                                  personame: data['CardHolderName'],
                                  dateofBirth: data['dob'],
                                  dateofCardExpire: data['doExpire'],
                                  dateofCardIssue: data['doIssue'],
                                  masjidname: data['masjidname'],
                                  masjidid: data['MasjidId'],
                                  masjidAddress: data['MasjidAddress'],
                                  masjidCountry: data['countryMasjid'],
                                  masjidCity: data['masjidCity'],
                                  masjidState: data['masjidState'],
                                  masjidemail: data['masjidEmail'],
                                  program: data['programTitle'],
                                  muntazimId: data['muntazimId'],
                                  programId: data['programId'],
                                );
                                final List<DonnerModel> donnerModel = [];
                                DonnerModel donner = DonnerModel(
                                  donnerId: Apis.user.uid,
                                  donateAbleAmmount: donatecontroller.text,
                                  currency:
                                      homeController.selectedCurrency.value,
                                );
                                donnerModel.add(donner);
                                homeController.validateDonnation(
                                  double.parse(data['Price']).toInt(),
                                  data['image'],
                                  homeController.selectedCurrency.value,
                                  donatecontroller,
                                  model,
                                  donnerModel,
                                  context,
                                  data['centerDefine'].toString(),
                                );
                              },
                              donatecontroller,
                              context,
                            );
                          },
                          program: data['programTitle'],
                          price: data['Price'],
                          recivedDonnation: data['recivedDonnation'],
                          currency: homeController.selectedCurrency.value,
                          onProgramClick: () {
                            Utils.showBottomSheetForProgramDetails(
                              () {},
                              data['programTitle'],
                              data['masjidname'],
                              data['purpose'],
                              data['MasjidAddress'],
                              data['countryMasjid'],
                              data['masjidCity'],
                              data['masjidState'],
                              data['Price'],
                              data['recivedDonnation'],
                              homeController.selectedCurrency.value,
                              context,
                            );
                          },
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
      leading: Container(
          height: context.mw * 0.1,
          width: context.mw * 0.1,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColor.mehroonColor,
                AppColor.brownColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Icon(
            Icons.language_sharp,
            color: AppColor.geryColor,
            size: context.mh * 0.020,
          )),
      title: Text(
        languageName,
        style: GoogleFonts.poppins(
            fontSize: context.mh * 0.020, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        langController.changeLanguage(Locale(languageCode));
        Navigator.pop(context); // Close the dialog
      },
    );
  }

  Widget buildCurrencyItem(BuildContext context, IconData icon, currencyname) {
    return ListTile(
      leading: Container(
        height: context.mw * 0.1,
        width: context.mw * 0.1,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColor.mehroonColor,
              AppColor.brownColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Icon(
          icon,
          color: AppColor.geryColor,
          size: context.mh * 0.020,
        ),
      ),
      title: Text(
        currencyname,
        style: GoogleFonts.poppins(
            fontSize: context.mh * 0.020, fontWeight: FontWeight.w500),
      ),
      onTap: () async {
        homeController.selectedCurrency.value = currencyname;
        await SharePrefs.saveData(
            'currency', homeController.selectedCurrency.value.toString());
        log('Data Saved');
      },
    );
  }
}
