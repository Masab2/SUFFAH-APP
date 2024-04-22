import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/AdminDonnationTRack/AlShuffahPersonTrack/AlShuffahPersonTrack.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AlShuffahPersonDonnation extends StatefulWidget {
  const AlShuffahPersonDonnation({super.key});

  @override
  State<AlShuffahPersonDonnation> createState() =>
      _AlShuffahPersonDonnationState();
}

class _AlShuffahPersonDonnationState extends State<AlShuffahPersonDonnation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          0.02.ph,
          StreamBuilder(
            stream: Apis.getAllDonationTrackForPerson(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Text("Don't Recived Any Donnation");
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return AlShuffahPersonTrackForAdmin(
                          masjidname: data['masjidname'],
                          image: data['PersonProfile'],
                          masjidaddress: data['PersonAddress'],
                          muntazimid: data['muntazimId'],
                          cnicno: data['personcnic'],
                          program: data['program'],
                          ontap: () {},
                          price: data['requiredDonnation'],
                          recivedDonnation: data['recivedDonnation'],
                          currency: 'PKR',
                          onshopClick: () {},
                          personname: data['personname'], icon: Icons.person,);
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
