import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/HomeComp/donnationChoices/DefaultProgramSeeAll/DefaultprogramSeeAll.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeeAllProgramView extends StatefulWidget {
  const SeeAllProgramView({super.key});

  @override
  State<SeeAllProgramView> createState() => _SeeAllProgramViewState();
}

class _SeeAllProgramViewState extends State<SeeAllProgramView> {
  late String country;
  late String currency;
  @override
  void initState() {
    country = Get.arguments[0];
    currency = Get.arguments[1];
    super.initState();
  }

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
                      return DonnationChoiceSeeAll(
                        image: data['image'],
                        title: data['programTitle'],
                        ontap: () {
                          Get.toNamed(
                            RoutesNames.selectMasjidScreen,
                            arguments: [
                              data['programTitle'],
                              data['Price'],
                              country,
                              data['image'],
                              currency,
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
        ],
      ),
    );
  }
}
