import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/MyDonnationComp/MyDonnationComp.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:suffa_app/views/Donners/Profile/MyDonnation/Donnation%20pdf/donnationPdf.dart';

class MyDonnation extends StatefulWidget {
  const MyDonnation({super.key});

  @override
  State<MyDonnation> createState() => _MyDonnationState();
}

class _MyDonnationState extends State<MyDonnation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Donnations',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.024,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.mehroonColor,
                AppColor.brownColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              MyDonnationPdf.generateDonationHistoryPDF();
            },
            icon: const Icon(
              IconlyBold.download,
            ),
          ),
          0.03.pw,
        ],
      ),
      body: Column(
        children: [
          0.02.ph,
          StreamBuilder(
            stream: Apis.getAllDonnationTrack(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitChasingDots(
                    color: AppColor.mehroonColor,
                    duration: Duration(seconds: 5),
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Text('No Data');
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return MyDonnationComp(
                        icon: data['DonnationStatus'] == 'forPerson'
                            ? IconlyBold.profile
                            : Icons.mosque_rounded,
                        cnicno: data['cnicNo'],
                        personname: data['name'],
                        address: data['address'],
                        location: data['location'],
                        program: data['program'],
                        lastDonnated: '${data['Ammount']} ${data['currency']}',
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
