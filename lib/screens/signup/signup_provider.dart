import 'package:audit_app/screens/home/homepage.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import '../../fonts/fonts.dart';
import '../../global_variable.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool obscureText = true;
  bool loader = false;
  final formKey = GlobalKey<FormState>();

  Future<void> registerUser(BuildContext context) async {
    loader = true;
    notifyListeners();
    String api = baseAPI + registerAPI;
    try {
      Response response = await post(
        Uri.parse(api),
        body: {
          "name": nameController.text,
          "email": emailController.text,
          "mobile": mobileController.text,
          "address": addressController.text,
          "password": passwordController.text,
          "password_confirmation": confirmPasswordController.text
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> output = json.decode(response.body);
        int userId = output['data']['id'];
        String accessToken = output['access_token'] ?? "";
        String roleType = output['data']['role_type'] ?? "";
        String firstName = output['data']['first_name'] ?? "";
        String gender = output['data']['gender'] ?? "";
        String email = output['data']['email'] ?? "";
        String mobile = output['data']['mobile'] ?? "";
        String address = output['data']['address'] ?? "";
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('id', userId);
        prefs.setString('role_type', roleType);
        prefs.setString('access_token', accessToken);
        prefs.setString('name', firstName);
        prefs.setString('gender', gender);
        prefs.setString('email', email);
        prefs.setString('mobile', mobile);
        prefs.setString('address', address);
        // ignore: use_build_context_synchronously
        moveToHome(context);
        print("Login Successfully");
        print(roleType);
        loader = false;
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: maincolor,
          content: Text(
            'Registration failed. Please try again.',
            style: GoogleFonts.secularOne(textStyle: normalstyle, fontSize: 13),
          ),
          duration: const Duration(seconds: 3),
        ));
        loader = false;
        notifyListeners();
      }
    } catch (e) {
      loader = false;
      notifyListeners();
      print(e);
    }
  }

  moveToHome(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    // ignore: use_build_context_synchronously
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }
}
