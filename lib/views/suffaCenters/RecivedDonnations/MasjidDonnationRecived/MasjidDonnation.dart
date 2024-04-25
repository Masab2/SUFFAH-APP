import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/MasjidDonnationRecived/MasjidDonnationRecived.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class MasjidDonnationRecived extends StatefulWidget {
  final String id, masjidId;
  const MasjidDonnationRecived(
      {Key? key, required this.id, required this.masjidId})
      : super(key: key);

  @override
  State<MasjidDonnationRecived> createState() => _MasjidDonnationRecivedState();
}

class _MasjidDonnationRecivedState extends State<MasjidDonnationRecived> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Apis.getAllDonationTrackForMasjidForSuffaCenter(
            widget.masjidId, widget.id),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data.docs[index];
                final requiredDonation = data['requiredDonnation'] ?? '';
                final receivedDonation = data['recivedDonnation'] ?? '';
                if (receivedDonation == requiredDonation) {
                  return MasjidDonnationRecivedComp(
                    title: data['Muntazimname'],
                    email: data['masjidEmail'],
                    onGreenBtnPressed: () {},
                    centerId: widget.masjidId,
                    address: data['masjidAddress'],
                    city: data['Muntazimcnic'],
                    onGreyBtnPressed: () {},
                    greenBtnText: 'Contact',
                    greyBtnText: 'Contact',
                    icon: Icons.mosque,
                  );
                } else {
                  return Column(
                    children: [
                      0.4.ph,
                      const Center(
                        child: Text('No data available'),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
