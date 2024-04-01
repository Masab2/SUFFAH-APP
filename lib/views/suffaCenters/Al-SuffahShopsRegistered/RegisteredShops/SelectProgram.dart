import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/components/selectProgramComp/selectProgramComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

import '../../../../Service/Firebase/firebasehelper.dart';
import '../../../../ViewModel/SuffahCenter/Registered Shops/AddAlShuffahShopsViewModel.dart';

class SelectProgramforShopsAdd extends StatefulWidget {
  const SelectProgramforShopsAdd({super.key});

  @override
  State<SelectProgramforShopsAdd> createState() =>
      _SelectProgramforShopsAddState();
}

class _SelectProgramforShopsAddState extends State<SelectProgramforShopsAdd> {
  final controller = Get.put(AddAlsuffahShopsViewModel());
  late String muntazid;
  late String masjidId;
  late String masjidname;

  @override
  void initState() {
    muntazid = Get.arguments[0];
    masjidId = Get.arguments[1];
    masjidname = Get.arguments[2];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            masjidname,
            style: GoogleFonts.poppins(
              fontSize: context.mh * 0.024,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shop For Masjid Program',
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(() => Switch(
                        value: controller.isShopAdded.value,
                        onChanged: (value) {
                          controller.toggleShop(
                            muntazid,
                            masjidId,
                            masjidname,
                            controller.isShopAdded.value == true
                                ? 'For Masjid'
                                : '',
                          );
                        },
                      )),
                ],
              ),
            ),
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
                  return const Text('No Data');
                } else {
                  return Expanded(
                      child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.mw * 0.03,
                          vertical: context.mh * 0.03,
                        ),
                        child: SelectProgramComp(
                          image: data['image'],
                          title: data['programTitle'],
                          buttonTitle: 'Add Shop In This Program',
                          ontap: () {
                            Get.toNamed(RoutesNames.addShopsScreen, arguments: [
                              muntazid,
                              masjidId,
                              masjidname,
                              data['programTitle'],
                            ]);
                          },
                        ),
                      );
                    },
                  ));
                }
              },
            ),
          ],
        ));
  }
}
