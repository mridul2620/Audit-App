import 'package:flutter/material.dart';
import 'list_api.dart';
import 'list_model.dart';

class AuditViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Audit> _completedAudits = [];
  List<Audit> _pendingAudits = [];
  List<Audit> get completedAudits => _completedAudits;
  List<Audit> get pendingAudits => _pendingAudits;

  Future<void> fetchAudits() async {
    final auditData = await _apiService.getAuditData();
    _completedAudits = auditData['Completed']
        .map<Audit>((auditJson) => Audit.fromJson(auditJson))
        .toList();
    _pendingAudits = auditData['Pending']
        .map<Audit>((auditJson) => Audit.fromJson(auditJson))
        .toList();
    print(_completedAudits);
    print(_pendingAudits);
    notifyListeners();
  }
}
