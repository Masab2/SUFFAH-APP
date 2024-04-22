import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/BottomNavBar/BottomNavBarViewModel.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:suffa_app/views/Donners/Donate/DonateScreenView.dart';
import 'package:suffa_app/views/Donners/Home/homeView.dart';
import 'package:suffa_app/views/Donners/More/MoreScreenView.dart';
import 'package:suffa_app/views/Donners/Notifs/NotificationScreenView.dart';
import 'package:suffa_app/views/Donners/Profile/DonnerProfile/DonnerProfle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 2, 2),
      body: _mainWrapperBody(),
      bottomNavigationBar: SafeArea(
        child: _mainWrapperBottomNavBar(
          context,
          l10n!.homeTitle,
          l10n.donateTitle,
          l10n.notifsTitle,
          l10n.profileTitle,
          l10n.moreTitle,
        ),
      ),
    );
  }

  BottomAppBar _mainWrapperBottomNavBar(
      BuildContext context, String home, donate, notifs, profile, more) {
    return BottomAppBar(
      color: AppColor.brownColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.home,
                  page: 0,
                  label: home,
                  filledIcon: IconlyBold.home,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.heart,
                  page: 1,
                  label: donate,
                  filledIcon: IconlyBold.heart,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.notification,
                  page: 2,
                  label: notifs,
                  filledIcon: IconlyBold.notification,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.profile,
                  page: 3,
                  label: profile,
                  filledIcon: IconlyBold.profile,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.more_circle,
                  page: 4,
                  label: more,
                  filledIcon: IconlyBold.more_circle,
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
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (int page) => bottomController.changePage(page),
      controller: pageController,
      children: const [
        HomeScreen(),
        DonateScreenView(),
        NotificationScreenView(),
        DonnerProfile(),
        MoreScreenView(),
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
        pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 10),
          curve: Curves.fastLinearToSlowEaseIn,
        );
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
                color: AppColor.blackColor,
                size: context.mh * 0.029,
              ),
            ),
            0.003.ph,
            Text(
              label,
              style: GoogleFonts.aBeeZee(
                fontSize: context.mh * 0.015,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
