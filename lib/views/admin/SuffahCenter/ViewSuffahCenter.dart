import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class ViewSuffahCenter extends StatefulWidget {
  const ViewSuffahCenter({super.key});

  @override
  State<ViewSuffahCenter> createState() => _ViewSuffahCenterState();
}

class _ViewSuffahCenterState extends State<ViewSuffahCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(IconlyBold.arrow_left_circle)),
        title: Text(
          'Suffah Center',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          IconlyLight.add_user,
        ),
        onPressed: () {
          Get.toNamed(RoutesNames.addSuffahCenterScreen);
        },
      ),
    );
  }
}
