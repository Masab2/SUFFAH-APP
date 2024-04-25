// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class CustomContainer extends StatelessWidget {
  final String title, profile;
  const CustomContainer({
    super.key,
    required this.title,
    required this.profile,
  });
  Future<Map<String, String>> _fetchDataFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String location = prefs.getString('country') ?? 'Pakis';
    String currency = prefs.getString('currency') ?? 'PK';
    String language = prefs.getString('language_code') ?? 'English';

    // Return the fetched data as a Map
    return {
      'location': location,
      'currency': currency,
      'language': language,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        profile == ''
            ? CircleAvatar(
                radius: context.mh * 0.10,
                backgroundColor: AppColor.brownColor,
                child: Icon(
                  IconlyBold.profile,
                  size: context.mh * 0.10,
                ),
              )
            : CachedNetworkImage(
                height: context.mw * 0.4,
                width: context.mw * 0.4,
                fit: BoxFit.cover,
                imageUrl: profile,
                placeholder: (context, url) => const SpinKitChasingDots(
                  color: AppColor.mehroonColor,
                  duration: Duration(seconds: 5),
                  size: 40,
                ),
                errorWidget: (context, url, error) {
                  return const Icon(Icons.error);
                },
              ),
        0.02.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconlyBold.message,
              size: context.mh * 0.022,
            ),
            Text(title,
                style: GoogleFonts.poppins(
                  fontSize: context.mh * 0.020,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
        0.01.ph,
        FutureBuilder(
          future: _fetchDataFromSharedPrefs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Display a loading indicator while fetching data
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    IconlyBold.location,
                    size: context.mh * 0.022,
                  ),
                  0.02.pw,
                  Text(
                    snapshot.data!['location'].toString(),
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.015,
                      fontWeight: FontWeight.w600,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  0.02.pw,
                  Icon(
                    Icons.monetization_on_outlined,
                    size: context.mh * 0.022,
                  ),
                  0.02.pw,
                  Text(
                    snapshot.data!['currency'].toString(),
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.015,
                      fontWeight: FontWeight.w600,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  0.02.pw,
                  Icon(
                    Icons.language,
                    size: context.mh * 0.022,
                  ),
                  0.02.pw,
                  Text(
                    snapshot.data!['language'].toString(),
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.015,
                      fontWeight: FontWeight.w600,
                      color: AppColor.whiteColor,
                    ),
                  )
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
