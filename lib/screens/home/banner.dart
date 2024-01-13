import "dart:convert";
import 'package:http/http.dart' as http;
import "package:audit_app/global_variable.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class BannerImage extends StatefulWidget {
  const BannerImage({super.key});

  @override
  State<BannerImage> createState() => _BannerImageState();
}

class _BannerImageState extends State<BannerImage> {
  String completedAudit = "";
  String pendingAudit = "";
  late SharedPreferences prefs;
  String totalAudit = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pending_data();
  }

  Future<void> pending_data() async {
    prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    final response = await http.get(
      Uri.parse(category_api),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        if (response.statusCode == 200 && jsonData['success'] == true) {
          setState(() {
            totalAudit = jsonData['total_audit'].toString();
            completedAudit = jsonData['completed_audit'].toString();
            pendingAudit = jsonData['pending_audit'].toString();
          });
        }
      }
    }
  }

  Widget _buildInfoContainer(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Colors.white,
      ),
      height: 45,
      width: 105,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 205,
      child: Stack(children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/home_banner.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoContainer("Total", totalAudit,
                    const Color.fromARGB(255, 220, 198, 0)),
                _buildInfoContainer("Completed", completedAudit, Colors.green),
                _buildInfoContainer("Pending", pendingAudit, Colors.red),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
