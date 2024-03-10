// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Model/alSuffahPersonModel/suffaPersonModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/Donner/displayNeedyPeopleController/NeedyPeopleController.dart';
import 'package:suffa_app/ViewModel/PaymentMethods/JazzCash/jazzcashPaymentViewModel.dart';
import 'package:suffa_app/res/components/AppBar/AppBar.dart';
import 'package:suffa_app/res/components/DonnerDisplayNeedy/AmmountDialog/AmmountDialog.dart';
import 'package:suffa_app/res/components/DonnerDisplayNeedy/displayNeedypeople.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/TextFormFeilds/DonnerTextFeilds.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/Utils.dart';
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
  final jazzcashPayment = Get.put(JazcashPaymentViewModel());
  final searchController = TextEditingController();
  final donnateController = TextEditingController();
  late String program;
  late String muntazimid;
  late String price;
  @override
  void initState() {
    program = Get.arguments[0];
    muntazimid = Get.arguments[1];
    price = Get.arguments[2];
    needyPeopleController.fetchData(program, muntazimid);
    super.initState();
  }

  @override
  void dispose() {
    needyPeopleController.dispose();
    jazzcashPayment.dispose();
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
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AmmountDialog(
                                  controller: donnateController,
                                  ontap: () {
                                    needyPeopleController.validateDonnation(
                                      100,
                                      1000,
                                    );
                                  },
                                );
                              },
                            );

                            // DonationDialog(controller: searchController);
                            // Get.toNamed(
                            //   RoutesNames.donatePaymentScreen,
                            //   arguments: [
                            //     tPrice,
                            //     price,
                            //   ],
                            // );
                          },
                          program: program,
                          muntazimid: muntazimid,
                          cnicno: person.cnicno,
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
