import 'package:audit_app/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../fonts/fonts.dart';
import '../signup/signup.dart';
import 'auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _obscureText = true;
  // ignore: prefer_typing_uninitialized_variables
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 134),
                      child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Center(
                                child: SizedBox(
                                    width: 125,
                                    height: 120,
                                    child: Image.asset("assets/login.png"))),
                            const SizedBox(
                              height: 18,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 45,
                                    child: TextFormField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: maincolor, width: 1.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 184, 184, 184),
                                              width: 1.0),
                                        ),
                                        label: Text(
                                          "Enter your email",
                                          style: TextStyle(color: maincolor),
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
                                    height: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    child: TextFormField(
                                      controller: passController,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: maincolor, width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 184, 184, 184),
                                                width: 1.0),
                                          ),
                                          label: Text(
                                            "Enter your password",
                                            style: TextStyle(color: maincolor),
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _obscureText =
                                                    !_obscureText; // Toggle the visibility of the password
                                              });
                                            },
                                            child: Icon(
                                              _obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: maincolor,
                                            ),
                                          )),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Password cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Material(
                                    color: Colors.green.shade900,
                                    borderRadius: BorderRadius.circular(8),
                                    child: InkWell(
                                      onTap: () async {
                                        await _authService.login(
                                            emailController.text.toString(),
                                            passController.text.toString(),
                                            context);
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 45,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text("New User?",
                                              style: GoogleFonts.poppins(
                                                  textStyle: normalstyle,
                                                  fontSize: 13,
                                                  color: Colors.black)),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Container(
                                            width: 100,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const SignUpPage()));
                                              },
                                              child: Text("Register now.",
                                                  style: GoogleFonts.secularOne(
                                                      textStyle: normalstyle,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 13,
                                                      color: Colors.black)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ])),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 163.77,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/splash_logo_2.png"),
                              fit: BoxFit.fitWidth)),
                    ),
                  ])),
        ),
      ]),
    );
  }
}
