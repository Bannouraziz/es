import 'package:Estichara/AfterRegister/home2.dart';
import 'package:Estichara/home.dart';
import 'package:Estichara/surveys/surveyslist.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Estichara/onboardscreen/onboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registerscreens/phone.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.notification.request();
  SurveyList().fetchSurveysAndImageURLs();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  final bool isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
  if (!hasSeenOnboarding) {
    prefs.setBool('hasSeenOnboarding', true);
  }
  final ConnectivityResult connectivityResult =
      await (Connectivity().checkConnectivity());

  if (connectivityResult != ConnectivityResult.none) {
    await SurveyList().fetchSurveysAndImageURLs();
    MobileAds.instance.initialize();
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
  runApp(MyApp(
    hasSeenOnboarding: hasSeenOnboarding,
    isAuthenticated: isAuthenticated,
  ));
}

class MyApp extends StatefulWidget {
  final bool hasSeenOnboarding;
  final bool isAuthenticated;
  MyApp({required this.hasSeenOnboarding, required this.isAuthenticated});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _subscribeToTopic();
  }

  Future<void> _subscribeToTopic() async {
    await _firebaseMessaging.subscribeToTopic('all_users');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        if (widget.hasSeenOnboarding) {
          if (widget.isAuthenticated) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Estichara',
              theme: ThemeData(
                primarySwatch: Colors.orange,
              ),
              home: MainMenu(),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Estichara',
              theme: ThemeData(
                primarySwatch: Colors.orange,
              ),
              home: MailScreen(),
            );
          }
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Estichara',
            theme: ThemeData(
              primarySwatch: Colors.orange,
            ),
            home: OnBoardingScreen(),
          );
        }
      },
    );
  }
}
