import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Model/DonnationTrackMasjidModel/DonnationTrackMasjidModel.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/Donner/HomeViewModel/HomeViewModel.dart';
import 'package:suffa_app/ViewModel/Donner/ShuffahMasjidViewModel/ShuffahMasjidViewmodel.dart';
import 'package:suffa_app/res/components/OneClickMethodsComp/DisplayOneClickMasjid.dart';
import 'package:suffa_app/res/components/TextFormFeilds/DonnerTextFeilds.dart';
import 'package:suffa_app/utils/Utils.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class ShuffaMasjidView extends StatefulWidget {
  final String currency;
  final String country;
  const ShuffaMasjidView({super.key, required this.currency, required this.country});

  @override
  State<ShuffaMasjidView> createState() => _ShuffaMasjidViewState();
}

class _ShuffaMasjidViewState extends State<ShuffaMasjidView> {
  final controller = Get.put(ShuffahMasjidViewModel());
  final homeController = Get.put(HomeViewModel());
  final TextEditingController donateController = TextEditingController();

  @override
  void dispose() {
    donateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchMasjidProgramOneClick(widget.currency,widget.country);
    return Scaffold(
      body: Column(
        children: [
          DonnerTextFeilsComp(
            hint: 'Search Masjid',
            controller: donateController,
            icon: Icons.sort_by_alpha_rounded,
            icon2: Icons.search,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'All',
                style: GoogleFonts.poppins(
                  fontSize: context.mh * 0.020,
                  fontWeight: FontWeight.w500,
                ),
              ),
              PopupMenuButton(
                icon: const Icon(IconlyBold.filter_2),
                onSelected: (value) {
                  // needyPeopleController
                  //     .handelSelectedItem(value.toString());
                  // needyPeopleController.filterListForOneClick(value);
                },
                itemBuilder: (BuildContext context) {
                  List<String> allOptions = [
                    'All',
                    'Masjid Marbel',
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
          Obx(() {
            if (controller.needyPeople.isEmpty) {
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
                  itemCount: controller.filteredPeople.length,
                  itemBuilder: (context, index) {
                    final data = controller.filteredPeople[index];
                    return DisplayOneClickMasjid(
                      cnic: data.cnicNo,
                      image: data.image,
                      masjidaddress: data.address,
                      muntazimid: data.muntazimId,
                      program: data.programTitle,
                      ontap: () {
                        Utils.showBottomSheetAmmount(
                          () {
                            final DonnationTrackMasjidModel model =
                                DonnationTrackMasjidModel(
                              donnationAmmount: donateController.text,
                              requiredDonnation: data.price,
                              image: data.image,
                              currency: widget.currency,
                              personcnic: data.cnicNo,
                              personame: data.cardHolderName,
                              dateofBirth: data.dob,
                              dateofCardExpire: data.doExpire,
                              dateofCardIssue: data.doIssue,
                              masjidname: data.massjidname,
                              masjidid: data.masjidid,
                              masjidAddress: data.masjidAddress,
                              masjidCountry: data.masjidCountry,
                              masjidCity: data.masjidCity,
                              masjidState: data.masjidState,
                              masjidemail: data.masjidEmail,
                              program: data.programTitle,
                              muntazimId: data.muntazimId,
                              programId: data.programId,
                            );
                            final List<DonnerModel> donnerModel = [];
                            DonnerModel donner = DonnerModel(
                              donnerId: Apis.user.uid,
                              donateAbleAmmount: donateController.text,
                              currency: widget.currency,
                            );
                            donnerModel.add(donner);
                            homeController.validateDonnation(
                              double.parse(data.price).toInt(),
                              data.image,
                              widget.currency,
                              donateController,
                              model,
                              donnerModel,
                              context,
                              'forMasjid',
                            );
                          },
                          donateController,
                          context,
                        );
                      },
                      price: data.price,
                      recivedDonnation: data.recivedDonnation,
                      currency: widget.currency,
                      onaddressClick: () {
                        controller.openGoogleMap(data.address);
                      },
                      masjidname: data.massjidname,
                      name: data.cardHolderName,
                      onshopClick: () {
                        Utils.showShopDialog(
                          data.programTitle,
                          context,
                          () {
                            controller.openGoogleMap(data.address);
                          },
                        );
                      },
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
