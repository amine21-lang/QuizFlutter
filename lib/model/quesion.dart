// Classes simples pour les questions et réponses

import 'package:tp3/model/Reponse.dart';

class Question {
  final int id;
  final String text;
  final List<Reponse> reponses;

  Question({
    required this.id,
    required this.text,
    required this.reponses,
  });
}

final List<Question> questionsTest = [
  Question(
    id: 1,
    text: "Qu'est-ce que CDI dans le contexte de Java ?",
    reponses: [
      Reponse(id: 1, text: "Un conteneur pour la gestion de la dépendance", isCorrect: true),
      Reponse(id: 2, text: "Un moteur de base de données", isCorrect: false),
      Reponse(id: 3, text: "Un framework frontend", isCorrect: false),
      Reponse(id: 4, text: "Une extension de Spring Boot", isCorrect: false),
    ],
  ),
  Question(
    id: 2,
    text: "Quel est l'annotation utilisée pour injecter une dépendance en CDI ?",
    reponses: [
      Reponse(id: 5, text: "@Autowired", isCorrect: false),
      Reponse(id: 6, text: "@Inject", isCorrect: true),
      Reponse(id: 7, text: "@Resource", isCorrect: false),
      Reponse(id: 8, text: "@Component", isCorrect: false),
    ],
  ),
  Question(
    id: 3,
    text: "Quelle est une des principales différences entre Spring et CDI ?",
    reponses: [
      Reponse(id: 9, text: "CDI utilise @Inject, Spring utilise @Autowired", isCorrect: true),
      Reponse(id: 10, text: "CDI ne supporte pas l'injection de dépendances", isCorrect: false),
      Reponse(id: 11, text: "Spring ne supporte pas les beans", isCorrect: false),
      Reponse(id: 12, text: "CDI ne peut pas gérer le cycle de vie des objets", isCorrect: false),
    ],
  ),
  Question(
    id: 4,
    text: "Quel conteneur est utilisé pour faire fonctionner CDI ?",
    reponses: [
      Reponse(id: 13, text: "Spring Container", isCorrect: false),
      Reponse(id: 14, text: "CDI Container (comme Weld)", isCorrect: true),
      Reponse(id: 15, text: "Hibernate ORM", isCorrect: false),
      Reponse(id: 16, text: "Tomcat Servlet Engine", isCorrect: false),
    ],
  ),
  Question(
    id: 5,
    text: "Quel est le rôle principal du CDI container ?",
    reponses: [
      Reponse(id: 17, text: "Créer des interfaces utilisateur", isCorrect: false),
      Reponse(id: 18, text: "Gérer les injections de dépendances et le cycle de vie des beans", isCorrect: true),
      Reponse(id: 19, text: "Créer des bases de données", isCorrect: false),
      Reponse(id: 20, text: "Générer du code Java automatiquement", isCorrect: false),
    ],
  ),
  Question(
    id: 6,
    text: "Quelle annotation permet de définir un bean en CDI ?",
    reponses: [
      Reponse(id: 21, text: "@Component", isCorrect: false),
      Reponse(id: 22, text: "@Bean", isCorrect: false),
      Reponse(id: 23, text: "@Named", isCorrect: true),
      Reponse(id: 24, text: "@Service", isCorrect: false),
    ],
  ),
  Question(
    id: 7,
    text: "Quel scope représente un bean unique pour toute l'application en CDI ?",
    reponses: [
      Reponse(id: 25, text: "@RequestScoped", isCorrect: false),
      Reponse(id: 26, text: "@SessionScoped", isCorrect: false),
      Reponse(id: 27, text: "@ApplicationScoped", isCorrect: true),
      Reponse(id: 28, text: "@Dependent", isCorrect: false),
    ],
  ),
  Question(
    id: 8,
    text: "Quel framework est souvent utilisé comme implémentation de référence pour CDI ?",
    reponses: [
      Reponse(id: 29, text: "Hibernate", isCorrect: false),
      Reponse(id: 30, text: "Weld", isCorrect: true),
      Reponse(id: 31, text: "Tomcat", isCorrect: false),
      Reponse(id: 32, text: "Maven", isCorrect: false),
    ],
  ),
  Question(
    id: 9,
    text: "Comment CDI gère-t-il plusieurs implémentations d'une même interface ?",
    reponses: [
      Reponse(id: 33, text: "Avec @Autowired", isCorrect: false),
      Reponse(id: 34, text: "Avec @Primary", isCorrect: false),
      Reponse(id: 35, text: "Avec @Qualifier", isCorrect: true),
      Reponse(id: 36, text: "Avec @InjectOnly", isCorrect: false),
    ],
  ),
  Question(
    id: 10,
    text: "Que signifie l’annotation @Dependent en CDI ?",
    reponses: [
      Reponse(id: 37, text: "Le bean est partagé entre tous les utilisateurs", isCorrect: false),
      Reponse(id: 38, text: "Le bean est lié au cycle de vie du client", isCorrect: true),
      Reponse(id: 39, text: "Le bean est réutilisé comme singleton", isCorrect: false),
      Reponse(id: 40, text: "Le bean est réinitialisé à chaque redémarrage du serveur", isCorrect: false),
    ],
  ),
];

class QuizManager {
  final List<Question> questions;
  final List<Reponse?> userAnswers;
  int currentQuestionIndex = 0;

  QuizManager({required this.questions})
      : userAnswers = List.filled(questions.length, null);

  // Enregistrer la réponse de l'utilisateur
  void answerQuestion(Reponse reponse) {
    userAnswers[currentQuestionIndex] = reponse;
  }

  // Passer à la question suivante
  bool moveToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      return true;
    }
    return false;
  }

  // Vérifier si c'est la dernière question
  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;

  // Obtenir la question actuelle
  Question get currentQuestion => questions[currentQuestionIndex];

  // Calculer le score
  int calculateScore() {
    int score = 0;
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i]?.isCorrect == true) {
        score++;
      }
    }
    return score;
  }
}
