import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/Admin/MemberRequestAccept/MemberRequestAcceptViewModel.dart';
import 'package:suffa_app/res/components/RequestMemberComp/RequestMemberComp.dart';
import 'package:suffa_app/utils/color/appColor.dart';

class MemberRequest extends StatefulWidget {
  const MemberRequest({super.key});

  @override
  State<MemberRequest> createState() => _MemberRequestState();
}

class _MemberRequestState extends State<MemberRequest> {
  final memberRequestViewModel = Get.put(MemberRequestAcceptViewModel());
  @override
  void dispose() {
    memberRequestViewModel.dispose();
    super.dispose();
  }

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
          'Members Requested',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: Apis.getSuffaCenterMembers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitChasingDots(
                    color: AppColor.cgreenColor,
                    duration: Duration(seconds: 5),
                    size: 40,
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No Data Found'));
              } else {
                return Expanded(
                    child: ListView.builder(
                  reverse: false,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    return RequestMemberComp(
                      customername: data['name'],
                      image: data['masjidimg'],
                      email: data['email'],
                      onAccept: () {
                        memberRequestViewModel.acceptRequest(data['MemberId']);
                      },
                      centerId: data['Desig'],
                      address: data['Masjidname'],
                      city: data['city'],
                      onReject: () {},
                    );
                  },
                ));
              }
            },
          )
        ],
      ),
    );
  }
}
