import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class ViewAffiliatedPrograms extends StatefulWidget {
  const ViewAffiliatedPrograms({super.key});

  @override
  State<ViewAffiliatedPrograms> createState() => _ViewAffiliatedProgramsState();
}

class _ViewAffiliatedProgramsState extends State<ViewAffiliatedPrograms> {
  @override
  Widget build(BuildContext context) {
    final id = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Affiliated Program',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        child: const Icon(IconlyBold.paper_plus),
        onPressed: () {
          Get.toNamed(RoutesNames.addaffiliatedProgramScreen, arguments: id);
        },
      ),
    );
  }
}
