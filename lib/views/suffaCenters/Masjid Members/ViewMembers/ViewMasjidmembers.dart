import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/AddMasjidMembers/viewMasjidMemberViewModel.dart';
import 'package:suffa_app/res/components/RequestMemberComp/RequestMemberComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class ViewMasjidMembers extends StatefulWidget {
  const ViewMasjidMembers({super.key});

  @override
  State<ViewMasjidMembers> createState() => _ViewMasjidMembersState();
}

class _ViewMasjidMembersState extends State<ViewMasjidMembers> {
  final controller = Get.put(ViewMasjidMemberViewModel());
  late String id;
  late String masjidid;
  @override
  void initState() {
    id = Get.arguments[0] ?? '';
    masjidid = Get.arguments[1] ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Committee Members',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: Apis.getAllSuffaCenterMembers(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitChasingDots(
                    color: AppColor.mehroonColor,
                    duration: Duration(seconds: 5),
                    size: 40,
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Text('No Data Found');
              } else {
                return Expanded(
                    child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    return RequesttoAdminComp(
                      title: data['name'],
                      image: data['masjidimg'],
                      email: data['email'],
                      onGreenBtnPressed: () async {
                        await controller.launchPhoneApp(data['phoneno']);
                      },
                      centerId: data['Desig'],
                      address: data['address'],
                      city: '',
                      onGreyBtnPressed: () {},
                      greenBtnText: 'Contact',
                      greyBtnText: 'Disable',
                    );
                  },
                ));
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          IconlyBold.add_user,
          color: AppColor.whiteColor,
        ),
        onPressed: () {
          Get.toNamed(RoutesNames.suffacenterAddMembersScreen, arguments: [
            id,
            masjidid,
          ]);
        },
      ),
    );
  }
}
