import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/res/components/AppBar/AppBar.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';

class DonateScreenView extends StatefulWidget {
  const DonateScreenView({super.key});

  @override
  State<DonateScreenView> createState() => _DonateScreenViewState();
}

class _DonateScreenViewState extends State<DonateScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.HomeBar(
          context,
          const Icon(
            IconlyLight.search,
            color: AppColor.cgreenColor,
          ),
          const Icon(
            IconlyLight.notification,
            color: AppColor.cgreenColor,
          )),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
