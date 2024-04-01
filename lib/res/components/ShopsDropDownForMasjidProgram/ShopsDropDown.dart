import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class ShopDropDownComp extends StatelessWidget {
  final ValueChanged<Object> onChanged;
  final List popupList;
  final String selectedValue;
  const ShopDropDownComp(
      {super.key,
      required this.onChanged,
      required this.popupList,
      required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Masjid Programs',
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.018,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          0.01.ph,
          Container(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
            decoration: BoxDecoration(
              color: AppColor.mehroonColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedValue,
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.017,
                      color: AppColor.whiteColor,
                    )),
                PopupMenuButton(
                  icon: const Icon(
                    Icons.note_alt_sharp,
                    color: AppColor.whiteColor,
                  ),
                  onSelected: onChanged,
                  itemBuilder: (BuildContext context) {
                    return popupList.map((item) {
                      return PopupMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
