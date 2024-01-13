class CompletdQuesList {
  final int answerId;
  final int user_id;
  final int audit_id;
  final String checking_methodology;
  final String observation;
  final String recommendation;
  final String risk;
  // final String evidence_img_1;
  // final String evidence_img_2;
  // final String evidence_img_3;
  final String ques_id;
  final int category_id;
  final int questionNo;
  final String questionName;

  CompletdQuesList(
      {required this.answerId,
      required this.user_id,
      required this.audit_id,
      required this.checking_methodology,
      required this.observation,
      required this.recommendation,
      required this.risk,
      // required this.evidence_img_1,
      // required this.evidence_img_2,
      // required this.evidence_img_3,
      required this.ques_id,
      required this.category_id,
      required this.questionName,
      required this.questionNo});
}