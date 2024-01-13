import 'package:audit_app/global_variable.dart';
import 'package:audit_app/screens/profile/plans.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fonts/fonts.dart';
import '../login/sigin.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late SharedPreferences prefs;
  String? emailId;
  String? number;
  String? dob;
  String? gender;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      emailId = prefs.getString('email')??"";
      number = prefs.getString('mobile')??"";
      dob = prefs.getString('dob')??"";
      gender = prefs.getString('gender')??"";
      isLoading = false;
    });
  }

  Future<void> _logout(BuildContext context) async {
    // ignore: unnecessary_null_comparison
    if (prefs != null) {
      await prefs.clear();
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: maincolor,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 233,
                            height: 150,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/profile_logo.png"),
                                    fit: BoxFit.cover)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 423,
                      decoration: const BoxDecoration(
                        color: bodyColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6.0, right: 6.0, top: 1, bottom: 1),
                            child: Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Container(
                                  height: 55,
                                  padding: const EdgeInsets.all(6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Auditor ID",
                                        style: GoogleFonts.secularOne(
                                            fontSize: 13,
                                            textStyle: softnormal,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 2),
                                      Expanded(
                                        child: Text(
                                          emailId!,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6.0, right: 6.0, top: 1, bottom: 1),
                            child: Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Container(
                                  height: 55,
                                  padding: const EdgeInsets.all(6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mobile Number",
                                        style: GoogleFonts.secularOne(
                                            fontSize: 13,
                                            textStyle: softnormal,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 2),
                                      Expanded(
                                        child: Text(
                                          number!,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6.0, right: 6.0, top: 1, bottom: 1),
                            child: Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Container(
                                  height: 55,
                                  padding: const EdgeInsets.all(6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gender",
                                        style: GoogleFonts.secularOne(
                                            fontSize: 13,
                                            textStyle: softnormal,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 2),
                                      Expanded(
                                        child: Text(
                                          gender!,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6.0, right: 6.0, top: 1, bottom: 1),
                            child: Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Container(
                                  height: 55,
                                  padding: const EdgeInsets.all(6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "DOB",
                                        style: GoogleFonts.secularOne(
                                            fontSize: 13,
                                            textStyle: softnormal,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 2),
                                      Expanded(
                                        child: Text(
                                          dob!,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6.0, right: 6.0, top: 1, bottom: 1),
                            child: Container(
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Container(
                                      height: 55,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SubscriptionPage(),
                                            ),
                                          );
                                        },
                                        child: Center(
                                          child: Text(
                                            'UPGRADE TO PRO',
                                            style: GoogleFonts.secularOne(
                                              fontSize: 14,
                                              textStyle: softnormal,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 18,
                                    top: 0,
                                    bottom: 0,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Container(
                              height: 45,
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 1, bottom: 1),
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                onPressed: () => _logout(context),
                                child: const Text('Logout'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
