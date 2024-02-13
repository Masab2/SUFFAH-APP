import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/components/adminDashBoardTiles/adminTilesUperheading/upperHeading.dart';

class ShuffaShopDashBoardView extends StatefulWidget {
  const ShuffaShopDashBoardView({super.key});

  @override
  State<ShuffaShopDashBoardView> createState() =>
      _ShuffaShopDashBoardViewState();
}

class _ShuffaShopDashBoardViewState extends State<ShuffaShopDashBoardView> {
  late String shopname;
  @override
  void initState() {
    shopname = Get.arguments[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AL-SUFFAH SHOP',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          UpperHeading(icon: Icons.shopify_rounded, title: shopname),
        ],
      ),
    );
  }
}
