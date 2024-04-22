import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Model/DonnationTrackModel/donnationTrackModel.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/Donner/displayNeedyPeopleController/NeedyPeopleController.dart';
import 'package:suffa_app/res/components/OneClickMethodsComp/DisplayOneClickPerson.dart';
import 'package:suffa_app/res/components/TextFormFeilds/DonnerTextFeilds.dart';
import 'package:suffa_app/utils/Utils.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class ShuffaPersonView extends StatefulWidget {
  final String currency;
  const ShuffaPersonView({super.key, required this.currency});

  @override
  State<ShuffaPersonView> createState() => _ShuffaPersonViewState();
}

class _ShuffaPersonViewState extends State<ShuffaPersonView> {
  final needyPeopleController = Get.put(NeedyPeopleController());
  final TextEditingController donateController = TextEditingController();
  @override
  void dispose() {
    donateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    needyPeopleController.fetchDataForOneClick(widget.currency);
    needyPeopleController.fetchPopupMenuItems();
    return Column(
      children: [
        Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
            child: Column(
              children: [
                DonnerTextFeilsComp(
                  hint: 'Search Person',
                  controller: donateController,
                  icon: Icons.sort_by_alpha_rounded,
                  icon2: Icons.search,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.mh * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            needyPeopleController.selectedprogram.value,
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.020,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          PopupMenuButton(
                            icon: const Icon(IconlyBold.filter),
                            onSelected: (value) {
                              needyPeopleController
                                  .handelSelectedItem(value.toString());
                              needyPeopleController
                                  .filterListForOneClick(value);
                            },
                            itemBuilder: (BuildContext context) {
                              List<String> allOptions = [
                                'All',
                                ...needyPeopleController.popupMenuItems
                              ];
                              return allOptions.map((item) {
                                return PopupMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Sort',
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.020,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          PopupMenuButton(
                            icon: const Icon(Icons.sort),
                            onSelected: (value) {
                              needyPeopleController
                                  .handelSelectedItem(value.toString());
                              needyPeopleController
                                  .filterListForOneClick(value);
                            },
                            itemBuilder: (BuildContext context) {
                              List<String> allOptions = [
                                'All',
                                ...needyPeopleController.popupMenuItems
                              ];
                              return allOptions.map((item) {
                                return PopupMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                0.02.ph,
              ],
            ),
          );
        }),
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
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: needyPeopleController.filteredPeople.length,
                itemBuilder: (context, index) {
                  final person = needyPeopleController.filteredPeople[index];

                  return DisplayOneClickPerson(
                    masjidname: person.masjidname,
                    image: person.image,
                    masjidaddress: person.address,
                    muntazimid: person.muntazimId,
                    cnicno: person.cnicno,
                    program: person.program,
                    ontap: () {
                      donateController.clear();
                      Utils.showBottomSheetAmmount(
                        () {
                          final DonnationTrackModel model = DonnationTrackModel(
                            donnationAmmount: donateController.text,
                            requiredDonnation: person.requiredDonnation,
                            image: '',
                            currency: widget.currency,
                            personcnic: person.cnicno,
                            personame: person.personname,
                            dateofBirth: person.dateofBirth,
                            dateofCardExpire: person.dateofExpire,
                            dateofCardIssue: person.dateofIssue,
                            personId: person.personId,
                            personPhoneNo: person.phoneno ?? '',
                            personaddress: person.address,
                            personprofile: person.image,
                            personGender: person.gender,
                            masjidname: person.masjidname,
                            masjidid: person.masjidid,
                            masjidAddress: person.masjidAddress,
                            masjidCountry: person.masjidCountry,
                            masjidCity: person.masjidCity,
                            masjidState: person.masjidState,
                            masjidemail: person.masjidemail,
                            program: person.program,
                            muntazimId: person.muntazimId,
                          );
                          final List<DonnerModel> donnerModel = [];
                          DonnerModel donner = DonnerModel(
                            donnerId: Apis.user.uid,
                            donateAbleAmmount: donateController.text,
                            currency: widget.currency,
                          );
                          donnerModel.add(donner);
                          needyPeopleController.validateDonnation(
                            double.parse(person.requiredDonnation).toInt(),
                            person.image,
                            widget.currency,
                            donateController,
                            model,
                            donnerModel,
                            context,
                            'forPerson',
                          );
                        },
                        donateController,
                        context,
                      );
                    },
                    price: person.requiredDonnation,
                    recivedDonnation: person.recivedDonnation,
                    currency: widget.currency,
                    onshopClick: () {
                      Utils.showShopDialog(person.program, context);
                    },
                    personname: person.personname,
                  );
                },
              ),
            );
          }
        }),
      ],
    );
  }
}
