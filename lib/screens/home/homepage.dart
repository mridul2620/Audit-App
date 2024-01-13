import 'package:audit_app/global_variable.dart';
import 'package:audit_app/list/page..dart';
import 'package:audit_app/screens/profile/profile.dart';
import 'package:audit_app/screens/rework/rework.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../profile/demoProfile.dart';
import 'home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  List screen = [const Landing(), AuditPage(), const Rework(), const Profile()];
  SharedPreferences? prefs;
  bool isScreenPopulated = false;
  int currpage = 0;
  String roleType = "";

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      roleType = prefs.getString('role_type') ?? "";
      print(roleType);
      _updateScreenList();
    });
  }

  void _updateScreenList() {
    switch (roleType) {
      case "Demo":
        screen = [const Landing(), AuditPage(), const Rework(), DemoProfile()];
        break;
      default:
        screen = [
          const Landing(),
          AuditPage(),
          const Rework(),
          const Profile()
        ];
        break;
    }
    setState(() {
      isScreenPopulated = true; // Mark that the screen list is now populated
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/logo.png',
          width: 141,
          height: 31,
        ),
        centerTitle: true,
      ),
      body: isScreenPopulated
          ? screen[_index]
          : const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor:
                    AlwaysStoppedAnimation(Color.fromARGB(255, 220, 216, 216)),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          selectedFontSize: 12,
          selectedIconTheme: const IconThemeData(color: maincolor),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
              backgroundColor: maincolor,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined, color: Colors.white),
                label: 'List',
                backgroundColor: maincolor),
            BottomNavigationBarItem(
                icon: Icon(Icons.repeat, color: Colors.white),
                label: 'Rework',
                backgroundColor: maincolor),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_3_sharp, color: Colors.white),
                label: 'Profile',
                backgroundColor: maincolor),
          ],
          currentIndex: _index,
          onTap: (value) {
            setState(() {
              _index = value;
            });
          }),
    );
  }
}
