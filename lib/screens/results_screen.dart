// import 'package:flutter/material.dart';


// class ResultsScreen extends StatelessWidget {
//   final List<String> chosenAnswers;

//   const ResultsScreen({super.key, required this.chosenAnswers});

//   List<Map<String, Object>> getSummaryData() {
//     final List<Map<String, Object>> summary = [];
//     for (var i = 0; i < chosenAnswers.length; i++) {
//       summary.add({
//         'question_index': i,
//         'question': questions[i].question ?? '', // Ensure non-null
//         'correct_answer': questions[i].answer[0] ?? '', // Ensure non-null
//         'user_answer': chosenAnswers[i] ?? '', // Ensure non-null
//       });
//     }
//     return summary;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final summaryData = getSummaryData();
//     final numTotalQuestions = questions.length;
//     final numcorrectquestions = summaryData.where((data) {
//       return data['user_answer'] == data['correct_answer'];
//     }).length;

//     return SizedBox(
//       width: double.infinity,
//       child: Container(
//         margin: const EdgeInsets.all(40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'You answered $numcorrectquestions  out of $numTotalQuestions questions correctly',
//               style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             const SizedBox(height: 20),
//             QuestionsSummary(summaryData: summaryData),
//           ],
//         ),
//       ),
//     );
//   }
// }
