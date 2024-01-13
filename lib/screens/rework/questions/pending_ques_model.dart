class PendingQuesList {
  final int quesId;
  final int questionNo;
  final String questionName;
  final String category_id;
  final String audit_id;

  PendingQuesList(
      {required this.quesId,
      required this.questionName,
      required this.questionNo,
      required this.category_id,
      required this.audit_id});
}
