import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  // Donnation Ammount Dialog
  static showDonnationDialog(
    TextEditingController controller,
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Donation Amount'),
          content: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
              hintText: 'Enter donation amount',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Donate'),
            ),
          ],
        );
      },
    );
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
  // Add Task Bottom Sheet
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
}
