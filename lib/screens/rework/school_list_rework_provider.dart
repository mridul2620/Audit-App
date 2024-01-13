import 'dart:convert';
import 'package:audit_app/global_variable.dart';
import 'package:audit_app/screens/rework/question_list_model.dart';
import 'package:audit_app/screens/rework/questions/completed_ques_model.dart';
import 'package:audit_app/screens/rework/rework_category_model.dart';
import 'package:audit_app/screens/rework/school_list_rework_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReworkPageState extends ChangeNotifier {
  List<ReworkModel> _reworkList = [];
  List<ReworkModel> get reworkList => _reworkList;
  List<ReworkCategoryModel> _reworkCategoryList = [];
  List<ReworkCategoryModel> get reworkCategoryList => _reworkCategoryList;
  List<CompletdQuesList> _completedList = [];
  List<CompletdQuesList> get completedList => _completedList;

  List<QuestionListModel> _pendingList = [];
  List<QuestionListModel> get pendingList => _pendingList;
  bool rework_loading = true;

  Future<void> reworkApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    final String api = baseAPI + rework;
    final response = await http.get(
      Uri.parse(api),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        final reworkData = data['data'] as List<dynamic>;
        _reworkList.addAll(reworkData.map((item) {
          return ReworkModel(
            address: item['address'],
            auditName: item['audit_name'],
            totalAudits: item['total_audit'],
          );
        }).toList());
        rework_loading = false;
        notifyListeners();
      }
    } else {
      print(response.statusCode);
    }
  }

  Future<void> reworkCategoryApi(String auditName, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    String api = baseAPI + schoolAudit + "/" + auditName + "/" + address;
    print(api);
    final response = await http.get(
      Uri.parse(api),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        final auditReportData = data['data'] as List<dynamic>;
        _reworkCategoryList = auditReportData.map((item) {
          return ReworkCategoryModel(
            categoryId: item['category_id'],
            userId: item['user_id'],
            auditId: item['audit_id'],
            auditName: item['audit_name'],
            address: item['address'],
            auditDate: item['audit_date'],
            totalQues: item['total_questions'],
            pendingQues: item['pending_questions'],
            completedQues: item['completed_questions'],
            status: item['status'],
            categoryName: item['category_name'],
            categoryImage: item['category_image'],
          );
        }).toList();
        notifyListeners();
      }
    } else {
      print(response.statusCode);
    }
  }

  Future<void> fetchAuditReportDetails(int auditId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    final String api = baseAPI + 'audit-report-details/$auditId';
    print(api);
    final response = await http.get(
      Uri.parse(api),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      //print(data);
      if (data['success'] == true) {
        final completedData = data['data']['completed'] as List<dynamic>;
        _completedList = completedData.map((item) {
          return CompletdQuesList(
            answerId: item['answer_id'],
            user_id: item['user_id'],
            audit_id: item['audit_id'],
            checking_methodology: item['checking_methodology'],
            observation: item['observation'],
            recommendation: item['recommmendation'],
            risk: item['risk_level'],
            // evidence_img_1: item['evidence_image_1'],
            // evidence_img_2: item['evidence_image_2'],
            // evidence_img_3: item['evidence_image_3'],
            ques_id: item['question_id'],
            category_id: item['category_id'],
            questionNo: item['question_no'],
            questionName: item['question_name'],
          );
        }).toList();
        print(_completedList);
 
        final pendingData = data['data']['pending'] as List<dynamic>;
        _pendingList = pendingData.map((item) {
          return QuestionListModel(
            questionNo: item['question_no'],
            answerId: item['question_id'],
            questionName: item['question_name'],
          );
        }).toList();
        print(_pendingList);

        notifyListeners();
      }
    } else {
      print(response.statusCode);
    }
  }
}
