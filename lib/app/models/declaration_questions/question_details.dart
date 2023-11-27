//
// import 'dart:convert';
//
// import 'package:medical/app/APImodels/declaration_questions/answer_details.dart';
//
// class QuestionDetails {
//   String? questionId;
//   String? question;
//   List<AnswerDetails>? answers;
//
//   QuestionDetails({
//     this.questionId,
//     this.question,
//     this.answers,
//   });
//
//   factory QuestionDetails.fromJson(Map<dynamic, dynamic> jsonData) {
//     var answers = jsonData['answers'] as List;
//
//     return QuestionDetails(
//       questionId: jsonData['questionId'],
//       question: jsonData['question'],
//       answers: answers != null
//           ? answers.map((i) => AnswerDetails.fromJson(i)).toList()
//           : [],
//     );
//   }
//
//   getJson() {
//     String temp = '[';
//     for (int i = 0; i < answers!.length; i++) {
//       if (i != 0) {
//         temp = temp + ',';
//       }
//       temp = temp + '${answers![i].getJson()}';
//     }
//     temp = temp + ']';
//     var data = {
//       'questionId': questionId,
//       'question': question,
//       'answers':  json.decode(temp),
//     };
//     return json.encode(data);
//   }
// }
