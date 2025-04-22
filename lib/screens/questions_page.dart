/*import 'package:flutter/material.dart';
import 'package:tp3/model/Quesion.dart';
import 'package:tp3/model/Reponse.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late QuizManager quizManager;

  @override
  void initState() {
    super.initState();
    // Initialiser le gestionnaire de quiz avec les questions de test
    quizManager = QuizManager(questions: questionsTest);
  }

  void _selectAnswer(Reponse reponse) {
    // Enregistrer la réponse
    quizManager.answerQuestion(reponse);
    
    setState(() {});
    
    // Attendre un court instant pour montrer la sélection
    Future.delayed(const Duration(milliseconds: 500), () {
      // Passer à la question suivante ou montrer les résultats
      if (quizManager.moveToNextQuestion()) {
        setState(() {});
      } else {
        // Afficher un dialogue simple avec le score pour tester
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Quiz terminé'),
            content: Text('Votre score : ${quizManager.calculateScore()}/${quizManager.questions.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = quizManager.currentQuestion;
    final currentAnswer = quizManager.userAnswers[quizManager.currentQuestionIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Indicateur de progression
            LinearProgressIndicator(
              value: (quizManager.currentQuestionIndex + 1) / quizManager.questions.length,
            ),
            const SizedBox(height: 8),
            Text(
              'Question ${quizManager.currentQuestionIndex + 1}/${quizManager.questions.length}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // Texte de la question
            Text(
              currentQuestion.text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // Options de réponse
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.reponses.length,
                itemBuilder: (context, index) {
                  final reponse = currentQuestion.reponses[index];
                  final isSelected = currentAnswer?.id == reponse.id;
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: isSelected ? Colors.blue.shade200 : null,
                      ),
                      onPressed: () => _selectAnswer(reponse),
                      child: Text(reponse.text),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:tp3/model/Quesion.dart';
import 'package:tp3/model/Reponse.dart';

// Assurez-vous que ce fichier importe vos modèles (Question, Reponse, QuizManager)

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late QuizManager quizManager;

  @override
  void initState() {
    super.initState();
    // Initialiser le gestionnaire de quiz avec les questions de test
    quizManager = QuizManager(questions: questionsTest);
  }

  void _selectAnswer(Reponse reponse) {
    // Enregistrer la réponse
    quizManager.answerQuestion(reponse);

    setState(() {});

    // Attendre un court instant pour montrer la sélection
    Future.delayed(const Duration(milliseconds: 500), () {
      if (quizManager.isLastQuestion) {
        // Si c'est la dernière question, naviguer vers la page de résultats
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultatsScreen(quizManager: quizManager),
          ),
        );
      } else {
        // Sinon, passer à la question suivante
        setState(() {
          quizManager.moveToNextQuestion();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = quizManager.currentQuestion;
    final currentAnswer =
        quizManager.userAnswers[quizManager.currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Indicateur de progression
            LinearProgressIndicator(
              value: (quizManager.currentQuestionIndex + 1) /
                  quizManager.questions.length,
            ),
            const SizedBox(height: 8),
            Text(
              'Question ${quizManager.currentQuestionIndex + 1}/${quizManager.questions.length}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Texte de la question
            Text(
              currentQuestion.text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Options de réponse
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.reponses.length,
                itemBuilder: (context, index) {
                  final reponse = currentQuestion.reponses[index];
                  final isSelected = currentAnswer?.id == reponse.id;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor:
                            isSelected ? Colors.blue.shade200 : null,
                      ),
                      onPressed: () => _selectAnswer(reponse),
                      child: Text(reponse.text),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultatsScreen extends StatelessWidget {
  final QuizManager quizManager;

  const ResultatsScreen({Key? key, required this.quizManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final score = quizManager.calculateScore();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats du Quiz'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Score: $score/${quizManager.questions.length}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Afficher chaque question et la réponse de l'utilisateur
          ...List.generate(quizManager.questions.length, (index) {
            final question = quizManager.questions[index];
            final repnses=question.reponses[index];
            final userAnswer = quizManager.userAnswers[index];
            final correctAnswer =
                question.reponses.firstWhere((r) => r.isCorrect);

            final isCorrect = userAnswer?.isCorrect == true;

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${index + 1}: ${question.text}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                        'Votre réponse: ${userAnswer?.text ?? "Aucune réponse"}'),
                    const SizedBox(height: 4),
                    if (!isCorrect)
                      Text(
                        'Réponse correcte: ${correctAnswer.text}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Retourner à l'écran d'accueil
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Recommencer le Quiz'),
          ),
        ],
      ),
    );
  }
}
