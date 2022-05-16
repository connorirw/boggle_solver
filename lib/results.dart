import 'package:boggle_solver/boggle_solver.dart';
import 'package:flutter/material.dart';
import 'score_calculator.dart';

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
  final myController = TextEditingController();
  List<String> words = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  late BoggleSolver b;

  @override
  void initState() {
    super.initState();
    b = BoggleSolver(widget.diceValues);
  }

  //removes word from user found words if the computer did not find them
  void _cleanUserFoundWords() {
    //words = words.toSet().toList();
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

  void _addWordToArray(String word) {
    //words.add(word);
    words = word.split(" ");
    print(words);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            content: Text(/*words.join("\n")*/ _getScore(words, b.foundWords)
                .toString() + "%"));
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          List<String> tmp = words;
          //_addWordToArray(words.join("\n") + "\n" + myController.text);
          _addWordToArray(myController.text);
          //myController.clear();
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
