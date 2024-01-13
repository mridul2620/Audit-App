// import 'package:flutter/material.dart';


// class CompletdQuesList {
//   final int answerId;
//   final int user_id;
//   final int audit_id;
//   final String checking_methodology;
//   final String observation;
//   final String recommendation;
//   final String risk;
//   final String evidence_img_1;
//   final String evidence_img_2;
//   final String evidence_img_3;
//   final String ques_id;
//   final String category_id;
//   final int questionNo;
//   final String questionName;

//   CompletdQuesList(
//       {required this.answerId,
//       required this.user_id,
//       required this.audit_id,
//       required this.checking_methodology,
//       required this.observation,
//       required this.recommendation,
//       required this.risk,
//       required this.evidence_img_1,
//       required this.evidence_img_2,
//       required this.evidence_img_3,
//       required this.ques_id,
//       required this.category_id,
//       required this.questionName,
//       required this.questionNo});
// }


// return CompletdQuesList(
//             answerId: item['answer_id'],
//             user_id: item['user_id'],
//             audit_id: item['audit_id'],
//             checking_methodology: item['checking_methodology'],
//             observation: item['observation'],
//             recommendation: item['recommmendation'],
//             risk: item['risk_level'],
//             evidence_img_1: item['evidence_image_1'],
//             evidence_img_2: item['evidence_image_2'],
//             evidence_img_3: item['evidence_image_3'],
//             ques_id: item['question_id'],
//             category_id: item['category_id'],
//             questionNo: item['question_no'],
//             questionName: item['question_name'],
//           );
//         }).toList();
//         print(_completedList);

//         final pendingData = data['data']['pending'] as List<dynamic>;
//         _pendingList = pendingData.map((item) {
//           return PendingQuesList(
//             category_id: item['category_id'],
//             audit_id: item['audit_id'],
//             questionNo: item['question_no'],
//             quesId: item['question_id'],
//             questionName: item['question_name'],
//           );
//         }).toList();

//   Widget completedListView(List<CompletdQuesList> list) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListView.builder(
//         itemCount: list.length,
//         itemBuilder: (context, index) {
//           final item = list[index];
//           return InkWell(
//             onTap: () {},
//             child: Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Q" + (item.questionNo).toString() + ".",
//                       style: GoogleFonts.secularOne(
//                         textStyle: normalstyle,
//                         fontSize: 13,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 2,
//                     ),
//                     Expanded(
//                       child: Text(
//                         item.questionName,
//                         style: GoogleFonts.secularOne(
//                           fontSize: 13,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget pendingListView(List<PendingQuesList> list) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListView.builder(
//         itemCount: list.length,
//         itemBuilder: (context, index) {
//           final item = list[index];
//           return InkWell(
//             onTap: () {},
//             child: Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Q" + (item.questionNo).toString() + ".",
//                       style: GoogleFonts.secularOne(
//                         textStyle: normalstyle,
//                         fontSize: 13,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 2,
//                     ),
//                     Expanded(
//                       child: Text(
//                         item.questionName,
//                         style: GoogleFonts.secularOne(
//                           fontSize: 13,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }