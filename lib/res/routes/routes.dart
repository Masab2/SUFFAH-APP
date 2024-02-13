import 'package:get/get.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/views/Auth/VerifyScreen/verifyScreen.dart';
import 'package:suffa_app/views/Auth/login/login.dart';
import 'package:suffa_app/views/Auth/signup/signUpScreen.dart';
import 'package:suffa_app/views/Donners/BottomNavBar/BottomNavbar.dart';
import 'package:suffa_app/views/Donners/Home/Donate%20NeedyPeople/donateNeedyPeopleScreen.dart';
import 'package:suffa_app/views/Donners/Home/PaymentScreen/Jazzcash/jazzcashScreen.dart';
import 'package:suffa_app/views/Donners/Home/PaymentScreen/paymentScreen.dart';
import 'package:suffa_app/views/Donners/Home/Select%20Masjids/ViewMasjids/SelectMasjidsView.dart';
import 'package:suffa_app/views/Donners/Profile/Setting/settings.dart';
import 'package:suffa_app/views/admin/Affiliated%20Program/addProgram/addPrograms.dart';
import 'package:suffa_app/views/admin/Affiliated%20Program/displayprogram/displayAffiliaatedProgram.dart';
import 'package:suffa_app/views/admin/Auth/LoginDashBoard/adminLoginDashBoard.dart';
import 'package:suffa_app/views/admin/ChoiceScreen/ChoiceScreen.dart';
import 'package:suffa_app/views/admin/DashBoard/adminDashboard.dart';
import 'package:suffa_app/views/admin/AdminAddSuffahCenter/ViewSuffahCenter.dart';
import 'package:suffa_app/views/admin/AdminAddSuffahCenter/addSuffahCenter.dart';
import 'package:suffa_app/views/admin/AdminAddSuffahCenter/createEmailView.dart';
import 'package:suffa_app/views/admin/MemberRequest/memberRequest.dart';
import 'package:suffa_app/views/admin/RequestedProgram/RequestedProgram.dart';
import 'package:suffa_app/views/splashView/splashView.dart';
import 'package:suffa_app/views/suffaCenters/Al-SuffahShopsRegistered/RegisteredShops/addShopOwnerCnic.dart';
import 'package:suffa_app/views/suffaCenters/Al-SuffahShopsRegistered/RegisteredShops/addShops.dart';
import 'package:suffa_app/views/suffaCenters/Al-SuffahShopsRegistered/RegisteredShops/genUsernameScreen.dart';
import 'package:suffa_app/views/suffaCenters/Al-SuffahShopsRegistered/ViewRegisteredShops/DisplayRegisterdShop.dart';
import 'package:suffa_app/views/suffaCenters/Auth/SuffahCenterAuth.dart';
import 'package:suffa_app/views/suffaCenters/CenterProgram/CreateFunding/addCenterProgram.dart';
import 'package:suffa_app/views/suffaCenters/CenterProgram/displayProgram/displayCenterProgram.dart';
import 'package:suffa_app/views/suffaCenters/DashBoard/suffacenterDashboard.dart';
import 'package:suffa_app/views/suffaCenters/Masjid%20Members/AddMembers/addMember.dart';
import 'package:suffa_app/views/suffaCenters/Masjid%20Members/GenerateEmail/generateEmail.dart';
import 'package:suffa_app/views/suffaCenters/Masjid%20Members/ViewMembers/MembersDetails/MembersDetails.dart';
import 'package:suffa_app/views/suffaCenters/Masjid%20Members/ViewMembers/ViewMasjidmembers.dart';
import 'package:suffa_app/views/suffaCenters/NeedyPeople/AddNeadyPeople/AddNeedyPeople.dart';
import 'package:suffa_app/views/suffaCenters/NeedyPeople/AddPersonalData/addPersonalData.dart';
import 'package:suffa_app/views/suffaCenters/NeedyPeople/selectProgram/selectProgram.dart';
import 'package:suffa_app/views/suffaCenters/Profile/suffaCenterProfileView.dart';
import 'package:suffa_app/views/suffaStores/Auth/SuffahStoreAuth.dart';
import 'package:suffa_app/views/suffaStores/DashBoard/shuffaShopDashBoard.dart';

class AppRoutes {
  static appRoutes() => [
        //! Donner Auth Screens
        GetPage(
            name: RoutesNames.splashScreen,
            page: () => const SplashView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.loginScreen,
            page: () => const LoginView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.signUpScreen,
            page: () => const SignUpScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.verifyScreen,
            page: () => const VerifyScreen(),
            transition: Transition.leftToRight),

        //? Choice Screen
        GetPage(
            name: RoutesNames.choiceScreen,
            page: () => const ChoiceScreen(),
            transition: Transition.leftToRight),

        //^ Donner DashBoard
        GetPage(
            name: RoutesNames.bottomNavbarScreen,
            page: () => const CustomizedBottomNavBar(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.settingsScreen,
            page: () => const DonnerSettings(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.selectMasjidScreen,
            page: () => const SelectMasjidsView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.donateNeedyPeopleScreen,
            page: () => const DonateNeedyPeopleView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.donatePaymentScreen,
            page: () => const PaymentScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.jazzCashPaymentScreen,
            page: () => const JazzCashView(),
            transition: Transition.leftToRight),

        //! Adminstration DashBoard
        GetPage(
            name: RoutesNames.loginDashBoardScreen,
            page: () => const AdminLoginDashBoard(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.adminDashBoardScreen,
            page: () => const AdminDashBoard(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.viewSuffahCenterScreen,
            page: () => const ViewSuffahCenter(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.addSuffahCenterScreen,
            page: () => const AddSuffahCenter(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.createEmailScreen,
            page: () => const CreateEmail(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.memberRequestScreen,
            page: () => const MemberRequest(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.addaffiliatedProgramScreenforAdmin,
            page: () => const AddProgramsView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.requestProgramScreen,
            page: () => const RequestedProgramView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.displayaffiliatedProgramScreenforAdmin,
            page: () => const DisplayAffiliatedProgram(),
            transition: Transition.leftToRight),

        //* Suffa Center DashBoard
        GetPage(
            name: RoutesNames.suffahloginDashBoardScreen,
            page: () => const SuffahCenterLoginDashBoard(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.suffacenterDashBoardScreen,
            page: () => const SuffaCenterDashboard(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.suffacenterProfileScreen,
            page: () => const SuffaCenterProfile(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.suffacenterViewMembersScreen,
            page: () => const ViewMasjidMembers(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.suffacenterAddMembersScreen,
            page: () => const AddSuffahMember(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.suffacentergenerateEmailScreen,
            page: () => const GenerateEmailSuffaMembers(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.suffacenterMemberDetailScreen,
            page: () => const SuffaCenterMemberDetail(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.addNeedyPeopleScreen,
            page: () => const AddNeedyPeople(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.addPersonalDataScreen,
            page: () => const AddPersonalData(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.centerProgramScreen,
            page: () => const AddCenterProgramView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.selectProgramScreen,
            page: () => const SelectProgram(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.centerProgramDisplayScreen,
            page: () => const DisplayCenterProgram(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.addShopsScreen,
            page: () => const AddAlSuffahShops(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.addShopsCnicScreen,
            page: () => const AddSuffahShopCnic(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.genUsernamePassShopScreen,
            page: () => const GenUserNamePassShopScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.displayShopScreen,
            page: () => const DisplayAlshuffaRegisteredShop(),
            transition: Transition.leftToRight),

        //& Shuffa Store Routes
        GetPage(
            name: RoutesNames.suffahStoreloginScreen,
            page: () => const SuffahStoreLoginDashBoard(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.suffahStoreDashBoardScreen,
            page: () => const ShuffaShopDashBoardView(),
            transition: Transition.leftToRight),
      ];
}
