import 'package:audit_app/global_variable.dart';
import 'package:audit_app/screens/home/homepage.dart';
import 'package:audit_app/screens/login/sigin.dart';
import 'package:audit_app/screens/profile/profile_provider.dart';
import 'package:audit_app/screens/rework/school_list_rework_provider.dart';
import 'package:audit_app/screens/signup/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dependency.dart';
import 'list/viewModel.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ReworkPageState>(create: (_) => ReworkPageState()),
      ChangeNotifierProvider<SignUpProvider>(create: (_) => SignUpProvider()),
      ChangeNotifierProvider<DemoProfileProvider>(create: (_) => DemoProfileProvider())
    ],
    child: MyApp(),
  ));
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuditViewModel(),
      child: GetMaterialApp(
        title: 'Audit Wizard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
 
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    checkTokenAndNavigate();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }

  bool _isAnimated = false;
  Future<void> checkTokenAndNavigate() async {
    prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    Future.delayed(const Duration(seconds: 2), () {
      if (accessToken != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignIn(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyColor,
        body: Center(
          child: Column(
            children: [
              Spacer(
                flex: 1,
              ),
              AnimatedOpacity(
                opacity: _isAnimated ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: Image.asset(
                  'assets/splash_logo.png',
                  height: 200,
                ),
              ),
              Spacer(
                flex: 1,
              ),
              AnimatedOpacity(
                opacity: _isAnimated ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: Image.asset(
                  'assets/splash_logo_2.png',
                  height: 200,
                ),
              ),
            ],
          ),
        ));
  }
}
