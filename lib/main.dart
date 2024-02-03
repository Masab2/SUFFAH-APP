import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suffa_app/ViewModel/Lang/LanguageChangeViewModel.dart';
import 'package:suffa_app/firebase_options.dart';
import 'package:suffa_app/res/routes/routes.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final langController = Get.put(AppLanguageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        locale: langController.appLocal,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('de'), // German
          Locale('ur'), // Urdu
        ],
        debugShowCheckedModeBanner: false,
        title: 'AL-SUFFA',
        theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColor.cgreenColor),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 0, 68, 61)),
          useMaterial3: true,
        ),
        getPages: AppRoutes.appRoutes(),
      );
    });
  }
}
