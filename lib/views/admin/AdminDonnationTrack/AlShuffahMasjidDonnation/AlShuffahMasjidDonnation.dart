import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/AdminDonnationTRack/AlShuffahPersonTrack/AlShuffahPersonTrack.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AlShuffahCenterDonnation extends StatefulWidget {
  const AlShuffahCenterDonnation({super.key});

  @override
  State<AlShuffahCenterDonnation> createState() =>
      _AlShuffahCenterDonnationState();
}

class _AlShuffahCenterDonnationState extends State<AlShuffahCenterDonnation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          0.02.ph,
          StreamBuilder(
            stream: Apis.getAllDonationTrackForMasjid(),
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
                        image: '',
                        masjidaddress: data['masjidAddress'],
                        muntazimid: data['muntazimId'],
                        cnicno: data['Muntazimcnic'],
                        program: data['program'],
                        ontap: () {},
                        price: data['requiredDonnation'],
                        recivedDonnation: data['recivedDonnation'],
                        currency: 'PKR',
                        onshopClick: () {},
                        personname: data['Muntazimname'],
                        icon: Icons.mosque,
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
