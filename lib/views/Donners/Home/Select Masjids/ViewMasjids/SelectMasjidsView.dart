import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/Donner/DisplayMasjid/displayMasjidViewmodel.dart';
import 'package:suffa_app/res/components/HomeComp/SelectMasjidComp/masjidDisplayComp.dart';
import 'package:suffa_app/res/components/TextFormFeilds/DonnerTextFeilds.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectMasjidsView extends StatefulWidget {
  const SelectMasjidsView({super.key});

  @override
  State<SelectMasjidsView> createState() => _SelectMasjidsViewState();
}

class _SelectMasjidsViewState extends State<SelectMasjidsView> {
  final searchController = TextEditingController();
  final masjidController = Get.put(DisplayMasjidViewModel());
  late String program;
  late String price;
  late String country;
  late String image;
  late String currency;
  @override
  void initState() {
    program = Get.arguments[0];
    price = Get.arguments[1];
    country = Get.arguments[2];
    image = Get.arguments[3];
    currency = Get.arguments[4];
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    masjidController.dispose();
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
          0.03.ph,
          DonnerTextFeilsComp(
            hint: l10n!.searchMasjid,
            controller: searchController,
            icon: Icons.search,
          ),
          0.03.ph,
          StreamBuilder(
            stream: Apis.getAllSuffaCenterByProgram(program, country),
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
                return const Center(child: Text('No Masjid Found'));
              } else {
                return Expanded(
                    child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    return MasjidDisplayComp(
                      masjidname: data['masjidname'],
                      image: data['masjidimg'],
                      masjidaddress: data['address'],
                      ontap: () {
                        
                        Get.toNamed(
                          RoutesNames.donateNeedyPeopleScreen,
                          arguments: [
                            program,
                            data['adminCreatedId'],
                            price,
                            image,
                            currency,
                            data['masjidname'],
                            data['centerid'],
                            data['address'],
                            data['country'],
                            data['city'],
                            data['state'],
                            data['email'],
                          ],
                        );
                      },
                      program: program,
                      muntazimid: data['adminCreatedId'],
                      receivedDonationsCount: 10,
                      waitingCount: 20,
                      onlocation: () {
                        masjidController.openGoogleMap(
                          data['address'],
                        );
                      },
                      country: data['country'],
                    );
                  },
                ));
              }
            },
          )
        ],
      ),
    );
  }
}
