import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Character Quiz',
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'ใครคือผู้ที่ได้รับสมญานามว่า “เทพเจ้าสายฟ้า”?',
      'answers': ['Iron Man', 'Thor', 'Hulk', 'Captain America'],
      'correctAnswer': 'Thor',
    },
    {
      'questionText': 'ตัวละครตัวไหนมีนามแฝงว่า "Wolverine"?',
      'answers': ['Logan', 'Bruce Banner', 'Peter Parker', 'Steve Rogers'],
      'correctAnswer': 'Logan',
    },
    {
      'questionText': 'ข้อใดคือชื่อจริงของ Iron Man ?',
      'answers': ['Tony Stark', 'Bruce Wayne', 'Clark Kent', 'Peter Parker'],
      'correctAnswer': 'Tony Stark',
    },
    {
      'questionText': 'ใครคือศัตรูตัวฉกาจของ Spider-Man?',
      'answers': ['Green Goblin', 'Venom', 'Doctor Octopus', 'Thanos'],
      'correctAnswer': 'Green Goblin',
    },
    {
      'questionText': 'ตัวละครตัวไหนมีชื่อเรียกอีกอย่างว่า “เมอร์คมีปาก”?',
      'answers': ['Deadpool', 'Black Widow', 'Punisher', 'Cable'],
      'correctAnswer': 'Deadpool',
    },
    {
      'questionText': 'Symbiote เอเลี่ยนผู้มีความรู้สึกผูกพันกับ Eddie Brock ชื่ออะไร?',
      'answers': ['Venom', 'Carnage', 'Toxin', 'Riot'],
      'correctAnswer': 'Venom',
    },
    {
      'questionText': 'ใครคือ Avenger ที่แข็งแกร่งที่สุด?',
      'answers': ['Thor', 'Hulk', 'Captain Marvel', 'Scarlet Witch'],
      'correctAnswer': 'Hulk',
    },
    {
      'questionText': 'ตัวละครใดเป็นผู้ปกครองประเทศ Wakanda ในแอฟริกา?',
      'answers': ['Black Panther', 'Storm', 'War Machine', 'Falcon'],
      'correctAnswer': 'Black Panther',
    },
    {
      'questionText': 'เทพเจ้านอร์สแห่งความชั่วร้ายและเป็นน้องชายของ Thor ชื่ออะไร?',
      'answers': ['Loki', 'Odin', 'Heimdall', 'Balder'],
      'correctAnswer': 'Loki',
    },
    {
      'questionText': 'ซูเปอร์ฮีโร่คนไหนที่ได้ฉายาว่า "First Avenger"?',
      'answers': ['Captain America', 'Iron Man', 'Black Widow', 'Hawkeye'],
      'correctAnswer': 'Captain America',
    },
  ];

  void _answerQuestion(String selectedAnswer) {
    if (_questions[_questionIndex]['correctAnswer'] == selectedAnswer) {
      setState(() {
        _score++;
      });
    }
    setState(() {
      _questionIndex++;
    });
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
      _questions.shuffle(); // Shuffle questions for a new quiz
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel Character Quiz'),
      ),
      body: _questionIndex < _questions.length
          ? QuizBody(
              questionData: _questions[_questionIndex],
              answerQuestion: _answerQuestion,
            )
          : QuizResult(
              score: _score,
              totalQuestions: _questions.length,
              restartQuiz: _restartQuiz,
            ),
    );
  }
}

class QuizBody extends StatelessWidget {
  final Map<String, Object> questionData;
  final Function(String) answerQuestion;

  QuizBody({
    required this.questionData,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            questionData['questionText'] as String,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        ...(questionData['answers'] as List<String>).map((answer) {
          return ElevatedButton(
            onPressed: () => answerQuestion(answer),
            child: Text(answer),
          );
        }).toList(),
      ],
    );
  }
}

class QuizResult extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final Function restartQuiz;

  QuizResult({
    required this.score,
    required this.totalQuestions,
    required this.restartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Your Score: $score / $totalQuestions',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () => restartQuiz(),
            child: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}