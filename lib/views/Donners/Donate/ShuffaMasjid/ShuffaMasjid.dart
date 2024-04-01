import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/Donner/ShuffahMasjidViewModel/ShuffahMasjidViewmodel.dart';
import 'package:suffa_app/res/components/OneClickMethodsComp/DisplayOneClickMasjid.dart';
import 'package:suffa_app/res/components/TextFormFeilds/DonnerTextFeilds.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class ShuffaMasjidView extends StatefulWidget {
  final String currency;
  const ShuffaMasjidView({super.key, required this.currency});

  @override
  State<ShuffaMasjidView> createState() => _ShuffaMasjidViewState();
}

class _ShuffaMasjidViewState extends State<ShuffaMasjidView> {
  final controller = Get.put(ShuffahMasjidViewModel());
  final TextEditingController donateController = TextEditingController();

  @override
  void dispose() {
    donateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchMasjidProgramOneClick(widget.currency);
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
                    final masjid = controller.filteredPeople[index];
                    return DisplayOneClickMasjid(
                      cnic: masjid.cnicNo,
                      image: masjid.image,
                      masjidaddress: masjid.address,
                      muntazimid: masjid.muntazimId,
                      program: masjid.programTitle,
                      ontap: () {},
                      price: masjid.price,
                      recivedDonnation: masjid.recivedDonnation,
                      currency: widget.currency,
                      onaddressClick: () {},
                      masjidname: masjid.massjidname,
                      name: masjid.cardHolderName,
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
