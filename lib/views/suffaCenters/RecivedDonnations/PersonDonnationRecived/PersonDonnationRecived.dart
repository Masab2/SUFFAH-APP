import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/AddMasjidMembers/viewMasjidMemberViewModel.dart';
import 'package:suffa_app/res/components/PersonDonnationRecived/PersonDonnationRecived.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class PersonDonnationRecived extends StatefulWidget {
  final String id, masjidId;
  const PersonDonnationRecived(
      {Key? key, required this.id, required this.masjidId})
      : super(key: key);

  @override
  State<PersonDonnationRecived> createState() => _PersonDonnationRecivedState();
}

class _PersonDonnationRecivedState extends State<PersonDonnationRecived> {
  final controller = Get.put(ViewMasjidMemberViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Apis.getAllDonationTrackForPersonForSuffaCenter(
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
                  return PersonDonnationRecivedComp(
                    title: data['personname'],
                    email: data['PersonPhoneNo'],
                    onGreenBtnPressed: () {
                      controller.launchPhoneApp(data['PersonPhoneNo']);
                    },
                    centerId: widget.masjidId,
                    address: data['PersonAddress'],
                    city: data['personcnic'],
                    onGreyBtnPressed: () {},
                    greenBtnText: 'Contact',
                    greyBtnText: 'Contact',
                    icon: Icons.person,
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
