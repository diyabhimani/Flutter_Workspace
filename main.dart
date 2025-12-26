import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GuessGame(),
    );
  }
}

class GuessGame extends StatefulWidget {
  const GuessGame({super.key});

  @override
  State<GuessGame> createState() => _GuessGameState();
}

class _GuessGameState extends State<GuessGame> {
  final TextEditingController controller = TextEditingController();
  final Random random = Random();

  late int number;
  String message = "Guess a number between 1 and 100";
  int attempts = 0;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    number = random.nextInt(100) + 1;
    attempts = 0;
    message = "Guess a number between 1 and 100";
    controller.clear();
    setState(() {});
  }

  void checkGuess() {
    int guess = int.parse(controller.text);
    attempts++;

    if (guess > number) {
      message = " Too High!";
    } else if (guess < number) {
      message = " Too Low!";
    } else {
      message = "Correct! Attempts: $attempts";
    }

    controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Number Guessing Game")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter your guess",
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: checkGuess,
              child: const Text("Check"),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: resetGame,
              child: const Text("Restart Game"),
            )
          ],
        ),
      ),
    );
  }
}
