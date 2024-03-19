// ignore_for_file: unrelated_type_equality_checks
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/Donner/displayNeedyPeopleController/NeedyPeopleController.dart';
import 'package:suffa_app/res/components/DonnerDisplayNeedy/AmmountDialog/AmmountDialog.dart';
import 'package:suffa_app/res/components/DonnerDisplayNeedy/displayNeedypeople.dart';
import 'package:suffa_app/res/components/TextFormFeilds/DonnerTextFeilds.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DonateNeedyPeopleView extends StatefulWidget {
  const DonateNeedyPeopleView({super.key});

  @override
  State<DonateNeedyPeopleView> createState() => _DonateNeedyPeopleViewState();
}

class _DonateNeedyPeopleViewState extends State<DonateNeedyPeopleView> {
  final needyPeopleController = Get.put(NeedyPeopleController());
  final searchController = TextEditingController();
  final donnateController = TextEditingController();
  late String program;
  late String muntazimid;
  late String price;
  late String image;
  late String currency;
  late String masjidname;
  late String masjidid;
  late String masjidAddress;
  late String masjidCountry;
  late String masjidCity;
  late String masjidState;
  late String masjidemail;
  late double convertAmmountDonate;

  @override
  void initState() {
    program = Get.arguments[0];
    muntazimid = Get.arguments[1];
    price = Get.arguments[2];
    image = Get.arguments[3];
    currency = Get.arguments[4];
    masjidname = Get.arguments[5];
    masjidid = Get.arguments[6];
    masjidAddress = Get.arguments[7];
    masjidCountry = Get.arguments[8];
    masjidCity = Get.arguments[9];
    masjidState = Get.arguments[10];
    masjidemail = Get.arguments[11];
    needyPeopleController.fetchData(program, muntazimid, currency);
    convertAmmountDonate =
        needyPeopleController.convertCurrency(double.parse(price), currency);
    super.initState();
  }

  @override
  void dispose() {
    needyPeopleController.dispose();
    searchController.dispose();
    donnateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.brownColor,
        title: Text(
          program,
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.023,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(() {
            if (needyPeopleController.needyPeople.isEmpty) {
              return const Center(
                child: SpinKitChasingDots(
                  color: AppColor.mehroonColor,
                  duration: Duration(seconds: 5),
                  size: 40,
                ),
              );
            } else {
              return Expanded(
                  child: Column(
                children: [
                  0.02.ph,
                  Row(
                    children: [
                      Expanded(
                        child: DonnerTextFeilsComp(
                          hint: l10n!.searchPersonHint,
                          onChanged: (value) {
                            needyPeopleController.filterList(value);
                          },
                          controller: searchController,
                          icon: Icons.store,
                          ontap: () {},
                        ),
                      ),
                    ],
                  ),
                  0.02.ph,
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: needyPeopleController.filteredPeople.length,
                      itemBuilder: (context, index) {
                        final person =
                            needyPeopleController.filteredPeople[index];
                        return DisplayNeedyPeopleComp(
                          masjidname: person.personname,
                          image: person.image,
                          masjidaddress: person.address,
                          ontap: () {
                            try {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AmmountDialog(
                                    controller: donnateController,
                                    ontap: () {
                                      needyPeopleController.validateDonnation(
                                        convertAmmountDonate.toInt(),
                                        image,
                                        currency,
                                        donnateController,
                                        person.cnicno,
                                        person.personname,
                                        person.dateofBirth,
                                        person.dateofExpire,
                                        person.dateofIssue,
                                        person.personId,
                                        person.phoneno,
                                        person.address,
                                        person.image,
                                        person.gender,
                                        masjidname,
                                        muntazimid,
                                        masjidAddress,
                                        masjidCountry,
                                        masjidCity,
                                        masjidState,
                                        masjidemail,
                                        program,
                                      );
                                    },
                                  );
                                },
                              );
                            } catch (e) {
                              log(e.toString());
                            }
                            // Navigator.pop(context);
                            // donnateController.clear();
                          },
                          program: program,
                          muntazimid: muntazimid,
                          cnicno: person.cnicno,
                          price: '$convertAmmountDonate',
                          recivedDonnation: person.recivedDonnation,
                          currency: currency,
                        );
                      },
                    ),
                  ),
                  0.02.ph,
                ],
              ));
            }
          }),
        ],
      ),
    );
  }
}
