import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Model/DonnationTrackMasjidModel/DonnationTrackMasjidModel.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/Donner/HomeViewModel/HomeViewModel.dart';
import 'package:suffa_app/res/components/HomeComp/donnationChoices/MasjidProgramSeeAll/MasjidProgramSeeAll.dart';
import 'package:suffa_app/utils/Utils.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeeAllMasjidProgramView extends StatefulWidget {
  const SeeAllMasjidProgramView({super.key});

  @override
  State<SeeAllMasjidProgramView> createState() =>
      _SeeAllMasjidProgramViewState();
}

class _SeeAllMasjidProgramViewState extends State<SeeAllMasjidProgramView> {
  final homeController = Get.find<HomeViewModel>();
  final TextEditingController donateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.brownColor,
        title: Text(
          l10n!.seeAll,
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.023,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          0.02.ph,
          StreamBuilder(
            stream: Apis.getAllSuffahCenterDefinePrograms(
              homeController.country.value,
            ),
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
                return Text(l10n.noDataFound);
              } else {
                return Expanded(
                  child: ListView.builder(
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
                                donnationAmmount: donateController.text,
                                requiredDonnation: data['Price'],
                                image: data['image'],
                                currency: homeController.selectedCurrency.value,
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
                                donateAbleAmmount: donateController.text,
                                currency: homeController.selectedCurrency.value,
                              );
                              donnerModel.add(donner);
                              homeController.validateDonnation(
                                double.parse(data['Price']).toInt(),
                                data['image'],
                                homeController.selectedCurrency.value,
                                donateController,
                                model,
                                donnerModel,
                                context,
                                data['centerDefine'].toString(),
                              );
                            },
                            donateController,
                            context,
                          );
                        },
                        program: data['programTitle'],
                        price: data['Price'],
                        recivedDonnation: data['recivedDonnation'],
                        currency: homeController.selectedCurrency.value,
                        onProgramClick: () {
                          Utils.showBottomSheetForProgramDetails(
                            () {
                              Get.back();
                              Utils.showBottomSheetAmmount(
                                () {
                                  final DonnationTrackMasjidModel model =
                                      DonnationTrackMasjidModel(
                                    donnationAmmount: donateController.text,
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
                                    donateAbleAmmount: donateController.text,
                                    currency:
                                        homeController.selectedCurrency.value,
                                  );
                                  donnerModel.add(donner);
                                  homeController.validateDonnation(
                                    double.parse(data['Price']).toInt(),
                                    data['image'],
                                    homeController.selectedCurrency.value,
                                    donateController,
                                    model,
                                    donnerModel,
                                    context,
                                    data['centerDefine'].toString(),
                                  );
                                },
                                donateController,
                                context,
                              );
                            },
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
    );
  }
}
