import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DisplayNeedyPeopleComp extends StatelessWidget {
  final String masjidname, image, masjidaddress, muntazimid;
  final String program;
  final VoidCallback ontap;
  final Widget traling;
  const DisplayNeedyPeopleComp(
      {super.key,
      required this.masjidname,
      required this.image,
      required this.masjidaddress,
      required this.ontap,
      required this.program,
      required this.muntazimid,
      required this.traling});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
          child: ListTile(
            onTap: ontap,
            style: ListTileStyle.list,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            mouseCursor: MouseCursor.uncontrolled,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.mw * 0.02,
            ),
            selectedColor: AppColor.blackColor,
            leading: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.blackColor,
                  )),
              child: CircleAvatar(
                onBackgroundImageError: (exception, stackTrace) {
                  Get.snackbar('Error', exception.toString());
                },
                backgroundImage: NetworkImage(image),
                radius: context.mh * 0.050,
              ),
            ),
            title: Text(
              masjidname,
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.020,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              masjidaddress,
              style: GoogleFonts.poppins(),
            ),
            trailing: traling,
          ),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        )
      ],
    );
  }
}

class DisplayPaymentMethodComp extends StatelessWidget {
  final String paymentname, image, paymentDescrip;
  final VoidCallback ontap;
  final Color color;
  const DisplayPaymentMethodComp({
    super.key,
    required this.paymentname,
    required this.image,
    required this.ontap,
    required this.color,
    required this.paymentDescrip,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: context.mw * 0.30,
                      padding:
                          EdgeInsets.symmetric(horizontal: context.mw * 0.03),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.geryColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: AssetImage(image),
                          height: context.mw * 0.15,
                          width: context.mw * 0.30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: context.mw * 0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paymentname,
                          style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.020,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          paymentDescrip,
                          style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.014,
                            fontWeight: FontWeight.w500,
                            color: AppColor.geryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentUperheading extends StatelessWidget {
  final String image, program, donnationprice, noofMeals, actualPrice;
  const PaymentUperheading(
      {super.key,
      required this.image,
      required this.program,
      required this.donnationprice,
      required this.noofMeals,
      required this.actualPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
          child: Row(
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: AssetImage(image),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        program,
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.020,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      0.01.ph,
                      Text(
                        'Meal for One: $actualPrice PKR',
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.012,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      0.01.ph,
                      Row(
                        children: [
                          Text(
                            donnationprice,
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.015,
                              color: AppColor.geryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          0.01.pw,
                          Text(
                            ' | ',
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.015,
                              color: AppColor.geryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          0.01.pw,
                          Text(
                            noofMeals,
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.015,
                              color: AppColor.geryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
