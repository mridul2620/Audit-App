import "package:audit_app/global_variable.dart";
import "package:audit_app/screens/signup/signup_provider.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "../../fonts/fonts.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignUpProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 150,
                height: 120,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/login.png"),
                        fit: BoxFit.fill)),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: signupProvider.formKey,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: TextFormField(
                        controller: signupProvider.nameController,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: maincolor, width: 1.0),
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
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  LengthLimitingTextInputFormatter(
                                      10), // Limit to 10 characters
                                ],
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: maincolor, width: 1.0),
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
                        controller: signupProvider.emailController,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: maincolor, width: 1.0),
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
                            borderSide:
                                BorderSide(color: maincolor, width: 1.0),
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
                      height: 40,
                      child: TextFormField(
                        controller: signupProvider.passwordController,
                        obscureText: signupProvider.obscureText,
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: maincolor, width: 1.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 184, 184, 184),
                                  width: 1.0),
                            ),
                            label: Text(
                              "Enter password",
                              style: GoogleFonts.secularOne(
                                  color: maincolor, textStyle: normalstyle),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  signupProvider.obscureText = !signupProvider
                                      .obscureText; // Toggle the visibility of the password
                                });
                              },
                              child: Icon(
                                signupProvider.obscureText
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
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: TextFormField(
                        controller: signupProvider.confirmPasswordController,
                        obscureText: signupProvider.obscureText,
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: maincolor, width: 1.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 184, 184, 184),
                                  width: 1.0),
                            ),
                            label: Text(
                              "Enter confirm password",
                              style: GoogleFonts.secularOne(
                                  color: maincolor, textStyle: normalstyle),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  signupProvider.obscureText = !signupProvider
                                      .obscureText; // Toggle the visibility of the password
                                });
                              },
                              child: Icon(
                                signupProvider.obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: maincolor,
                              ),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Confirm Password cannot be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
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
                      if (signupProvider.formKey.currentState!.validate()) {
                        await signupProvider.registerUser(context);
                      }
                    },
                    child: signupProvider.loader
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
                        : Text("Register",
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
