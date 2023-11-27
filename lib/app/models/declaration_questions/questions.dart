// import 'dart:convert';
//
// import 'package:medical/app/APImodels/declaration_questions/question_details.dart';
// import 'package:medical/app/controllers/home_controller/declaration_conroller.dart';
//
// class Questions {
//   List<QuestionDetails>? questions;
//
//   Questions({
//     this.questions,
//   });
//
//   factory Questions.fromJson(Map<dynamic, dynamic> jsonData) {
//     var questions = jsonData['questions'] as List;
//     return Questions(
//       questions: questions != null
//           ? questions.map((i) => QuestionDetails.fromJson(i)).toList()
//           : [],
//     );
//   }
//
//   getJson(DeclarationController controller,int citizenId,int score) {
//
//     String temp = '[';
//     for (int i = 0; i < questions!.length; i++) {
//       if (i != 0) {
//         temp = temp + ',';
//       }
//       temp = temp + '${questions![i].getJson()}';
//     }
//     temp = temp + ']';
//     var data = {
//       "name": controller.userData['fullName'] ?? "",
//       "gender": controller.userData['gender'] ?? "",
//       "age": controller.userData['age'] ?? 0,
//       "patientId": citizenId,
//       "score" : score,
//       'questions':  json.decode(temp),
//     };
//     return json.encode(data);
//   }
// }
