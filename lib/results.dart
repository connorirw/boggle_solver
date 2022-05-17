import 'package:boggle_solver/boggle_solver.dart';
import 'package:flutter/material.dart';
import 'score_calculator.dart';
import 'leaderboard.dart' as lb;

void main() => runApp(results(diceValues: <String>[
      "a",
      "t",
      "i",
      "e",
      "e",
      "a",
      "h",
      "a",
      "v",
      "e",
      "l",
      "r",
      "g",
      "w",
      "i",
      "s"
    ]));

class results extends StatelessWidget {
  List<String> diceValues;
  results({Key? key, required this.diceValues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(diceValues: diceValues),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  List<String> diceValues;
  MyCustomForm({Key? key, required this.diceValues}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final userWordsController = TextEditingController();
  final userNameController = TextEditingController();
  List<String> words = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userWordsController.dispose();
    super.dispose();
  }

  late BoggleSolver b;

  @override
  void initState() {
    super.initState();
    b = BoggleSolver(widget.diceValues);
    userNameController.text = 'username';
  }

  //removes word from user found words if the computer did not find them
  void _cleanUserFoundWords() {
    words.insert(0, "");
    for (var i = 0; i < words.length; i++) {
      if (!b.foundWords.contains(words[i])) {
        words.removeAt(i);
        i--;
      }
    }
  }

  double _getScore(List<String> userWords, List<String> compWords) {
    score_calculator c = score_calculator();
    _cleanUserFoundWords();
    int userScore = c.calcScore(userWords);
    int compScore = c.calcScore(compWords);
    print("user: $userScore, computer: $compScore");
    return (userScore / compScore) * 100;
  }

  void _saveScore(String answer, String username) {
    words = answer.split(" ");
    _cleanUserFoundWords();
    double score = _getScore(words, b.foundWords);
    lb.Storage s = lb.Storage();
    s.writeData('$username    ${score.toStringAsFixed(2)}%');
    //_displayScore(answer);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            content:
                Text('Score Posted: ${score.toStringAsFixed(2)}\n Words on Board: ${b.foundWords.join(' ')}'));
      },
    );
  }

  void _displayScore(String word) {
    words = word.split(" ");
    print(words);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            content:
                Text(_getScore(words, b.foundWords).toStringAsFixed(2) + "%"));
      },
    );
    print(b.foundWords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: userWordsController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: userNameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                  child: const Text('Submit to Leaderboard'),
                  onPressed: () {
                    _saveScore(
                        userWordsController.text, userNameController.text);
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          List<String> tmp = words;
          _displayScore(userWordsController.text);
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
