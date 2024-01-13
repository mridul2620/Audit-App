// import 'package:audit_app/screens/questions/risk.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../category_model.dart';

// class ApiHandling {
//   static Future<void> sendQuestionDataToAPI(QuestionData questionData) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int? auditId = prefs.getInt('auditId');
//     prefs = await SharedPreferences.getInstance();
//     int? userId = prefs.getInt('id');
//     const apiUrl = 'https://audit.safetycircle.in/api/audit-report';
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Authorization':
//             'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMjY3MDRlMDgyYTcyYTgwODFlMzBlODdhNjcwZGE3YTY0YjkxZTU4YjFhN2NhNjk2N2VlMzg1YWQ0ZGFlZjczY2YxMzMyZjcyMmNjZDJjMDAiLCJpYXQiOjE2OTIwMzQ3MzIuODY4NTE2LCJuYmYiOjE2OTIwMzQ3MzIuODY4NTIxLCJleHAiOjE2OTMzMzA3MzIuODYyNDc1LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.sy0ap-gUzJFVcTstqX4dY8PcjnrjCd3MjUFTrY3KqUFRegvassn2AJKShtLaVXWKRicRo-PoXAF7F2QixC96ABucBonSOF48lpbnN69MnJP8sYngfxilgwth1nrHxfak6xtcL6MnPWLAC3I1v959NQPnRP28ui7-BhN44EOQmYLcZrYlSIrdQCEjp34c_HMdRd885y2YSYKJu2u53vci19akNouDQm3zk2yxPD0j5z3isW6WFvy9oAhVoV31ZtS3um8LyIVyKk23zA-rSqxvPRQhpqfVnrF_tXQ4s034C23l8UQ-2JNQapXRV5wKtW6YqF-IzyHYRj3voOxRz3cdqLajU5CS9uClcwUlbXPPljDzV7GSrMdrLCl1Bfqt3LVOe8s2yaMmc3qVsWum4pKCrQ3-CvfZr0hr6k7W83azKi8lkyxJdl2RY0RX1amTObz-O59OjmGpO8Tn1fqYDcETHLICyuaGBuBAb5tVmwFIC7y8oJrpwzavMCwbNY_VAWTbt0_2sGjXaYk9vZQ7qQ1-bzSIZfI2eP3Jo-Nbz2Y_9pSIlP7PjE8omZfD9S4ONbAl2IkAxDc8RmtMFPe68f2dgQjnDCXxgYUXhrK8UC8aJg9typdM6KF3qVi-agJgcCMV4E0J8wKl4HQWxsjKce2_L3dM9Pn3bHXs7j_BtMK5SjY'
//       },
//       body: {
//         'user_id': userId,
//         'audit_id': auditId, // Replace with your actual shared prefs logic
//         'question_id': questionData.question.id.toString(),
//         'checking_methodology': questionData.selectedMethodology.toString(),
//         'recommendation': questionData.recommendation.toString(),
//         'observation': questionData.observation.toString(),
//         'risk_level':
//             _getRiskLevelString(questionData.riskLevel as int).toString(),
//         'evidence_image_1': questionData.evidenceImage1 != null
//             ? questionData.evidenceImage1?.path
//             : '',
//         'evidence_image_2': questionData.evidenceImage2 != null
//             ? questionData.evidenceImage2?.path
//             : '',
//         'evidence_image_3': questionData.evidenceImage3 != null
//             ? questionData.evidenceImage3?.path
//             : '',
//       },
//     );

//     if (response.statusCode == 200) {
//       print(response.body);
//       // Successfully sent data to API
//       print('Data sent to API successfully');
//     } else {
//       // Handle API error
//       print('Error sending data to API: ${response.statusCode}');
//     }
//   }
// }

// String _getRiskLevelString(int index) {
//   return DataHandling.getRiskLevelString(index);
// }
