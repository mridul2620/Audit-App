import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audit_app/screens/home/homepage.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      Response response = await post(
        Uri.parse("https://audit.safetycircle.in/api/login"),
        body: {"email": email, "password": password},
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> output = json.decode(response.body);
        String accessToken = output['access_token'];
        int parentId = output['data']['parent_id'];
        String firstName = output['data']['first_name'];
        String lastName = output['data']['last_name'];
        String gender = output['data']['gender'];
        String userEmail = output['data']['email'];
        String userMobile = output['data']['mobile'];
        String dob = output['data']['dob'];
        String profileImage = output['data']['profile_image'];
        int userId = output['data']['id'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('id', userId);
        prefs.setInt('parent_id', parentId);
        prefs.setString('access_token', accessToken);
        prefs.setString('first_name', firstName);
        prefs.setString('last_name', lastName);
        prefs.setString('gender', gender);
        prefs.setString('email', userEmail);
        prefs.setString('mobile', userMobile);
        prefs.setString('dob', dob);
        prefs.setString('profile_image', profileImage);
        // ignore: use_build_context_synchronously
        moveToHome(context);
        print(parentId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Login failed. Please check your credentials.'),
          duration: Duration(seconds: 3),
        ));
      }
      // ignore: empty_catches
    } catch (e) {
      print(e);
      print('error');
    }
  }

  moveToHome(BuildContext context) async {
    // ignore: use_build_context_synchronously
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }
}
