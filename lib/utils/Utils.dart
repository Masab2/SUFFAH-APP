import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

import '../Service/Firebase/firebasehelper.dart';

class Utils {
  static String dateFormated(var date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('yyyyMMddHHmmss').format(dateTime).toString();
  }

  static String dateFormatedForNotifs(var date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('MMMM:dd:yyyy').format(dateTime).toString();
  }

  static String dateFormatedExpire(var date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('yyyyMMddHHmmss')
        .format(
          dateTime.add(
            const Duration(days: 1),
          ),
        )
        .toString();
  }

  // Show Shop Dialog
  static showShopDialog(program, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          backgroundColor: AppColor.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          content: Container(
            height: context.mh * 0.60,
            width: context.mw,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage(ImageAsset.applogo),
                  height: context.mw * 0.4,
                  width: context.mw * 0.4,
                ),
                0.01.ph,
                Text(
                  'Shops Registered',
                  style: GoogleFonts.roboto(
                    fontSize: context.mh * 0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                0.02.ph,
                Expanded(
                  child: StreamBuilder(
                    stream: Apis.getShopsforByProgram(program),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitChasingDots(
                            color: AppColor.mehroonColor,
                            duration: Duration(seconds: 5),
                            size: 40,
                          ),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No Shops Registered'));
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: CircleAvatar(
                                  radius: context.mh * 0.020,
                                  backgroundImage: NetworkImage(
                                    snapshot.data!.docs[index]['Image'],
                                  ),
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]['ShopTitle'],
                                ),
                                subtitle: Text(
                                    snapshot.data!.docs[index]['masjidname']),
                                trailing: const Icon(
                                  IconlyBold.location,
                                ));
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Show Donnation Bottom Sheet
  static void showBottomSheetAmmount(
    VoidCallback ontap,
    TextEditingController title,
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Image(
                  image: AssetImage(ImageAsset.applogo),
                  height: context.mw * 0.3,
                  width: context.mw * 0.3,
                ),
              ),
              0.02.ph,
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Donnation Ammount',
                  style: GoogleFonts.poppins(
                    fontSize: context.mh * 0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              0.04.ph,
              CustomizedFeild(
                controller: title,
                hint: 'Donnation Amount',
                title: 'Amount',
                keyboardtype: TextInputType.number,
              ),
              0.03.ph,
              Row(
                children: [
                  Expanded(
                      child: ReuseAblebtn(
                    title: 'Donate Now',
                    onPressed: ontap,
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show Bottom Sheet for the Program Details
  static void showBottomSheetForProgramDetails(
    VoidCallback ontap,
    title,
    masjidname,
    purpose,
    masjidaddress,
    country,
    city,
    state,
    price,
    recivedDonnation,
    currency,
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Image(
                  image: AssetImage(ImageAsset.applogo),
                  height: context.mw * 0.3,
                  width: context.mw * 0.3,
                ),
              ),
              0.02.ph,
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: context.mh * 0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              0.04.ph,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Masjid Name',
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.015,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            masjidname,
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.013,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Purpose',
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.015,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            purpose,
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.013,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Address',
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.015,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            masjidaddress,
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.013,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Country',
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.015,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '$country/$state/$city',
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.013,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Donnation Amount',
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.015,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '$recivedDonnation $currency /$price $currency',
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.013,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              0.03.ph,
              Row(
                children: [
                  Expanded(
                      child: ReuseAblebtn(
                    title: 'Donate Now',
                    onPressed: ontap,
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showBottomSheetForProgramDefault(
    VoidCallback ontap,
    title,
    purpose,
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Image(
                  image: AssetImage(ImageAsset.applogo),
                  height: context.mw * 0.3,
                  width: context.mw * 0.3,
                ),
              ),
              0.02.ph,
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: context.mh * 0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              0.04.ph,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Purpose :',
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.017,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    0.01.ph,
                    Text(
                      purpose,
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.015,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              0.03.ph,
              Row(
                children: [
                  Expanded(
                      child: ReuseAblebtn(
                    title: 'Donate Now',
                    onPressed: ontap,
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Logout Dialog Box
  static showBlurDialog(BuildContext context, title, content, darkbtntext,
      lightBtntext, VoidCallback ontap) {
    return showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: AppColor.brownColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      darkbtntext,
                      style: GoogleFonts.poppins(color: AppColor.whiteColor),
                    ),
                  ),
                  0.02.pw,
                  MaterialButton(
                    color: AppColor.mehroonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    onPressed: ontap,
                    child: Text(lightBtntext,
                        style: GoogleFonts.poppins(color: AppColor.whiteColor)),
                  ),
                ],
              )
            ],
            backgroundColor: AppColor.masjidgeryColor.withOpacity(0.23),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: Align(
              alignment: Alignment.topCenter,
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: context.mh * 0.020,
                ),
              ),
            ),
            contentTextStyle: const TextStyle(overflow: TextOverflow.ellipsis),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    content,
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.017,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showZakatDialog(zakatAmount) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Image(
              image: AssetImage(ImageAsset.applogo),
              height: context.mw * 0.3,
              width: context.mw * 0.3,
            ),
          ),
          content: Text(
            'Your Zakat amount is $zakatAmount',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            MaterialButton(
              color: AppColor.mehroonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                Get.back();
              },
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                  color: AppColor.whiteColor,
                  fontSize: context.mh * 0.016,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
