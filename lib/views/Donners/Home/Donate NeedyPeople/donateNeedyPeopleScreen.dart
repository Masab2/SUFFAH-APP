// ignore_for_file: unrelated_type_equality_checks
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/Donner/displayNeedyPeopleController/NeedyPeopleController.dart';
import 'package:suffa_app/ViewModel/PaymentMethods/JazzCash/jazzcashPaymentViewModel.dart';
import 'package:suffa_app/enum/AffiliatedProgramEnum.dart';
import 'package:suffa_app/res/components/AppBar/AppBar.dart';
import 'package:suffa_app/res/components/DonnerDisplayNeedy/displayNeedypeople.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/constant/constant.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DonateNeedyPeopleView extends StatefulWidget {
  const DonateNeedyPeopleView({super.key});

  @override
  State<DonateNeedyPeopleView> createState() => _DonateNeedyPeopleViewState();
}

class _DonateNeedyPeopleViewState extends State<DonateNeedyPeopleView> {
  final needyPeopleController = Get.put(NeedyPeopleController());
  final jazzcashPayment = Get.put(JazcashPaymentViewModel());
  final searchController = TextEditingController();
  final program = Get.arguments[0];
  final muntazimid = Get.arguments[1];
  @override
  void initState() {
    needyPeopleController.fetchData('OneTimeMeal', muntazimid);
    super.initState();
  }

  @override
  void dispose() {
    needyPeopleController.dispose();
    jazzcashPayment.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.alSuffahPersonbar(context, () {}),
      body: Column(
        children: [
          Obx(() {
            if (needyPeopleController.needyPeople.isEmpty) {
              return const Center(
                child: SpinKitChasingDots(
                  color: AppColor.cgreenColor,
                  duration: Duration(seconds: 5),
                  size: 40,
                ),
              );
            } else {
              return Expanded(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomizedFeild(
                          controller: searchController,
                          hint: 'Search Person',
                          prefixIcon: const Icon(
                            IconlyLight.search,
                          ),
                        ),
                      ),
                    ],
                  ),
                  0.02.ph,
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: needyPeopleController.needyPeople.length,
                      itemBuilder: (context, index) {
                        final person = needyPeopleController.needyPeople[index];
                        return DisplayNeedyPeopleComp(
                            masjidname: person.personname,
                            image: person.image,
                            masjidaddress: person.address,
                            ontap: () {
                              var key = utf8.encode(IntegeritySalt);
                              var bytes = utf8.encode(superdata);
                              var hmacSha256 = Hmac(sha256, key);
                              Digest sha256Result = hmacSha256.convert(bytes);
                              jazzcashPayment.jazzCashPayment(
                                '500',
                                '03264747056',
                                sha256Result.toString(),
                              );
                            },
                            program: program == ProgramType.ONETIMEMEAL
                                ? 'OneTimeMeal'
                                : 'RashanProgram',
                            muntazimid: muntazimid,
                            traling: IconButton(
                              onPressed: () async {
                                await needyPeopleController
                                    .updateStatus(person.personId);
                              },
                              icon: person.tempstatus == 'Added'
                                  ? const Icon(
                                      IconlyBold.heart,
                                      color: Colors.red,
                                    )
                                  : const Icon(IconlyLight.heart),
                            ));
                      },
                    ),
                  ),
                  Visibility(
                    visible: needyPeopleController.needyPeople.any(
                      (person) => person.tempstatus == 'Added',
                    ),
                    child: MaterialButton(
                      height: context.mh * 0.06,
                      minWidth: context.mw * 0.80,
                      color: AppColor.cgreenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Donate All',
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.020,
                          color: AppColor.whiteColor,
                        ),
                      ),
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
