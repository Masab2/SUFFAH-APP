import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/BottomNavBar/BottomNavBarViewModel.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:suffa_app/views/Donners/HomeScreen.dart';
import 'package:suffa_app/views/admin/SuffahCenter/ViewSuffahCenter.dart';
import 'package:suffa_app/views/admin/SuffahCenter/addSuffahCenter.dart';

class CustomizedBottomNavBar extends StatefulWidget {
  const CustomizedBottomNavBar({super.key});

  @override
  State<CustomizedBottomNavBar> createState() => _CustomizedBottomNavBarState();
}

class _CustomizedBottomNavBarState extends State<CustomizedBottomNavBar> {
  late PageController pageController;
  final bottomController = Get.put(BottomnNavbarViewModel());
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    bottomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 2, 2),
      body: _mainWrapperBody(),
      bottomNavigationBar: SafeArea(child: _mainWrapperBottomNavBar(context)),
    );
  }

  BottomAppBar _mainWrapperBottomNavBar(BuildContext context) {
    return BottomAppBar(
      color: AppColor.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.home,
                  page: 0,
                  label: "Home",
                  filledIcon: IconlyBold.home,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.heart,
                  page: 1,
                  label: "Donate",
                  filledIcon: IconlyBold.heart,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.profile,
                  page: 2,
                  label: "Profile",
                  filledIcon: IconlyBold.profile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PageView _mainWrapperBody() {
    return PageView(
      onPageChanged: (int page) => bottomController.changePage(page),
      controller: pageController,
      children: const [
        HomeScreen(),
        Scaffold(body: Center(child: Text('Home2'))),
        Scaffold(body: Center(child: Text('Home3'))),
      ],
    );
  }

  Widget _bottomAppBarItem(
    BuildContext context, {
    required defaultIcon,
    required page,
    required label,
    required filledIcon,
  }) {
    return GestureDetector(
      onTap: () {
        bottomController.changePage(page);
        pageController.animateToPage(page,
            duration: const Duration(milliseconds: 10),
            curve: Curves.fastLinearToSlowEaseIn);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            0.004.ph,
            Obx(
              () => Icon(
                bottomController.page.value == page ? filledIcon : defaultIcon,
                color: AppColor.cgreenColor,
                size: 26,
              ),
            ),
            0.003.ph,
            Text(
              label,
              style: GoogleFonts.aBeeZee(
                  fontSize: 13, fontWeight: FontWeight.w100),
            ),
          ],
        ),
      ),
    );
  }
}
