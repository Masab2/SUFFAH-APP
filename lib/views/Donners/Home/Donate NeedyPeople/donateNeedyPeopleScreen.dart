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
import 'package:suffa_app/res/components/DonnerDisplayNeedy/displayNeedypeople.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.alSuffahPersonbar(context, () {
        final totalPrice =
            needyPeopleController.calulateTotalDonnation(int.parse(price));
        List<SuffahPersonModel> addedPeople = needyPeopleController.needyPeople
            .where((person) => person.tempstatus == 'Added')
            .toList();
        String tPrice = totalPrice.toString();
        Get.toNamed(RoutesNames.donatePaymentScreen,
            arguments: [addedPeople, tPrice, price]);
      }, program),
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
                          onChanged: (value) {
                            needyPeopleController.filterList(value);
                          },
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
                            ontap: () async {
                              await needyPeopleController
                                  .updateStatus(person.personId);
                            },
                            program: program,
                            muntazimid: muntazimid,
                            traling: IconButton(
                              onPressed: () async {
                                await needyPeopleController
                                    .updateStatus(person.personId);
                              },
                              icon: person.tempstatus == 'Added' &&
                                      person.donnerSelectionId.isNotEmpty &&
                                      person.donnerSelectionId == Apis.user.uid
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
                      (person) =>
                          person.tempstatus == 'Added' &&
                          person.donnerSelectionId == Apis.user.uid,
                    ),
                    child: MaterialButton(
                      height: context.mh * 0.06,
                      minWidth: context.mw * 0.80,
                      color: AppColor.cgreenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        final totalPrice = needyPeopleController
                            .calulateTotalDonnation(int.parse(price));
                        String tPrice = totalPrice.toString();
                        List<SuffahPersonModel> addedPeople =
                            needyPeopleController.needyPeople
                                .where((person) => person.tempstatus == 'Added')
                                .toList();
                        Get.toNamed(RoutesNames.donatePaymentScreen,
                            arguments: [
                              addedPeople,
                              tPrice,
                              price,
                            ]);
                      },
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
