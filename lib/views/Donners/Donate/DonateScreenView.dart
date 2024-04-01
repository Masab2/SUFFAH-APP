import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/ViewModel/Donner/DonateViewModel/DonateViewModel.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:suffa_app/views/Donners/Donate/ShuffaPerson/ShuffaPerson.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'ShuffaMasjid/ShuffaMasjid.dart';

class DonateScreenView extends StatefulWidget {
  const DonateScreenView({Key? key}) : super(key: key);

  @override
  State<DonateScreenView> createState() => _DonateScreenViewState();
}

class _DonateScreenViewState extends State<DonateScreenView>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  final controller = Get.put(DonateViewModel());
  String currency = 'PKR';
  Future<void> getCurrency() async {
    String currencyValue = await SharePrefs.getData('currency');
    setState(() {
      currency = currencyValue;
    });
  }

  @override
  void initState() {
    getCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: context.mw * 0.25,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image(
                  height: context.mw * 0.2,
                  width: context.mw * 0.2,
                  image: AssetImage(ImageAsset.applogo),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.mw * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          """ “${l10n?.taglineOne ?? ""}  """,
                          style: GoogleFonts.poppins(
                            color: AppColor.mehroonColor,
                            fontSize: context.mh * 0.014,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          """ ${l10n!.taglineTwo}” """,
                          style: GoogleFonts.poppins(
                            color: AppColor.mehroonColor,
                            fontSize: context.mh * 0.014,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  0.01.ph,
                  Obx(
                    () {
                      return TabBar(
                        onTap: (value) => controller.selectTab(value),
                        controller: tabController,
                        unselectedLabelColor: AppColor.blackColor,
                        labelColor: AppColor.whiteColor,
                        labelStyle: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            fontSize: context.mh * 0.020,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: context.mw * 0.01,
                        ),
                        isScrollable: false,
                        indicatorColor: AppColor.whiteColor,
                        indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 0,
                        ),
                        tabs: [
                          _buildTab(l10n.tabOne, 0),
                          _buildTab(l10n.tabTwo, 1),
                        ],
                      );
                    },
                  ),
                  0.01.ph,
                  SizedBox(
                    height: context.mh * 0.6,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      dragStartBehavior: DragStartBehavior.start,
                      children: [
                        ShuffaPersonView(
                          currency: currency,
                        ),
                        ShuffaMasjidView(
                          currency: currency,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: controller.selectedIndex.value == index
                  ? AppColor.mehroonColor
                  : AppColor.brownColor,
            ),
            child: Tab(
              text: text,
            ),
          ),
        ),
      ],
    );
  }
}
