import 'package:flutter/material.dart';
import 'question.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  const QuestionWidget({Key? key, required this.question}) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String? selectedAnswer;
  String feedbackText = '';
  bool isAnswered = false;

  void checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isAnswered = true;

      // Set feedback text based on whether the selected answer is correct or not
      if (answer == widget.question.correctAnswer) {
        feedbackText = 'Correct! 🎉';
      } else {
        feedbackText =
            'Wrong! 😞 The correct answer is: ${widget.question.correctAnswer}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the question text
        Text(
          widget.question.question,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Display the options as ElevatedButton widgets
        ...widget.question.options.map((option) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isAnswered
                  ? null // Disable the button after an answer is selected
                  : () => checkAnswer(option),
              child: Text(option),
            ),
          );
        }).toList(),

        const SizedBox(height: 16),

        // Display feedback text
        if (isAnswered)
          Text(
            feedbackText,
            style: TextStyle(
              fontSize: 16,
              color:
                  feedbackText.contains('Correct') ? Colors.green : Colors.red,
            ),
          ),
      ],
    );
  }
}
