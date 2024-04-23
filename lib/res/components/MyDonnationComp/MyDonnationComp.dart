import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class MyDonnationComp extends StatelessWidget {
  final IconData icon;
  final String cnicno, personname, address, location, program, lastDonnated;
  const MyDonnationComp({
    super.key,
    required this.icon,
    required this.cnicno,
    required this.personname,
    required this.address,
    required this.location,
    required this.program,
    required this.lastDonnated,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsetsDirectional.only(
        bottom: context.mh * 0.02,
        start: context.mw * 0.02,
        end: context.mw * 0.02,
      ),
      height: context.mh * 0.30,
      decoration: BoxDecoration(
        color: AppColor.masjidgeryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: context.mw * 0.05,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [
                  AppColor.mehroonColor,
                  AppColor.brownColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    0.02.ph,
                    Row(
                      children: [
                        0.02.pw,
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.mehroonColor,
                              radius: context.mh * 0.06,
                              child: Icon(
                                icon,
                                size: context.mh * 0.06,
                                color: AppColor.whiteColor,
                              ),
                            ),
                            0.01.ph,
                            Text(
                              program,
                              style: GoogleFonts.poppins(
                                fontSize: context.mh * 0.013,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        0.02.pw,
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: context.mw * 0.03,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        l10n!.cnicTitle,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        cnicno,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.013,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        l10n.nameTitle,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        personname,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.013,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        l10n.addressTitle,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        address,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.013,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Location',
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        location,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.013,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Last Donnated',
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        lastDonnated,
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
                        ),
                      ],
                    ),
                    0.01.ph,
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
