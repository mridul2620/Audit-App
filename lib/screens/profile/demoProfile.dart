import 'package:audit_app/global_variable.dart';
import 'package:audit_app/screens/login/sigin.dart';
import 'package:audit_app/screens/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fonts/fonts.dart';
import '../signup/signup_provider.dart';

class DemoProfile extends StatefulWidget {
  const DemoProfile({super.key});

  @override
  State<DemoProfile> createState() => _DemoProfileState();
}

class _DemoProfileState extends State<DemoProfile> {
  String name = '';
  String email = '';
  String address = '';
  String number = '';

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('first_name') ?? '';
      email = prefs.getString('email') ?? '';
      address = prefs.getString('address') ?? '';
      number = prefs.getString('mobile') ?? '';
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to the login page (replace with your login page route)
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignIn(), // Replace with your login page
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignUpProvider>(context);
    final demoProvider = Provider.of<DemoProfileProvider>(context);
    signupProvider.nameController.text = name;
    signupProvider.emailController.text = email;
    signupProvider.addressController.text = address;
    signupProvider.mobileController.text = number;
    return Scaffold(
      body: Container(
        height: double.infinity,
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Upgrade to Pro",
                style: GoogleFonts.secularOne(
                    color: Colors.black, textStyle: normalstyle, fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "This is a demo version of the application which will epire in 7 days. If you wish to get the complete version you can contact our sales team below",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      textStyle: normalstyle,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                child: TextFormField(
                  controller: signupProvider.nameController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                          width: 1.0),
                    ),
                    label: Text(
                      "Enter your name",
                      style: GoogleFonts.secularOne(
                          color: maincolor, textStyle: normalstyle),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                child: TextFormField(
                  controller: signupProvider.mobileController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(
                        10), // Limit to 10 characters
                  ],
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                          width: 1.0),
                    ),
                    label: Text(
                      "Enter your Mobile number",
                      style: GoogleFonts.secularOne(
                          color: maincolor, textStyle: normalstyle),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mobile number cannot be empty";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                child: TextFormField(
                  controller: demoProvider.alternateMobController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(
                        10), // Limit to 10 characters
                  ],
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                          width: 1.0),
                    ),
                    label: Text(
                      "Enter any alternate number",
                      style: GoogleFonts.secularOne(
                          color: maincolor, textStyle: normalstyle),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                child: TextFormField(
                  controller: signupProvider.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                          width: 1.0),
                    ),
                    label: Text(
                      "Enter your email",
                      style: GoogleFonts.secularOne(
                          color: maincolor, textStyle: normalstyle),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                child: TextFormField(
                  controller: signupProvider.addressController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                          width: 1.0),
                    ),
                    label: Text(
                      "Enter your address",
                      style: GoogleFonts.secularOne(
                          color: maincolor, textStyle: normalstyle),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Address cannot be empty";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                child: TextFormField(
                  controller: demoProvider.commentController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                          width: 1.0),
                    ),
                    label: Text(
                      "Comments",
                      style: GoogleFonts.secularOne(
                          color: maincolor, textStyle: normalstyle),
                    ),
                  ),
                  maxLines: 2,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 37,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: maincolor),
                    onPressed: () async {
                      demoProvider.sendQuery(
                          context,
                          signupProvider.nameController.text,
                          signupProvider.mobileController.text,
                          signupProvider.emailController.text,
                          signupProvider.addressController.text);
                    },
                    child: demoProvider.loader
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                valueColor: AlwaysStoppedAnimation(
                                    Color.fromARGB(255, 220, 216, 216)),
                              ),
                            ),
                          )
                        : Text("Send Query",
                            style: GoogleFonts.secularOne(
                                textStyle: normalstyle,
                                fontSize: 18,
                                color: Colors.white))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
