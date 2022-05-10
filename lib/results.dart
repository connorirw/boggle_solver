import 'package:boggle_solver/boggle_solver.dart';
import 'package:flutter/material.dart';
import 'score_calculator.dart';

void main() => runApp(const results());

class results extends StatelessWidget {
  const results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

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

  BoggleSolver b = BoggleSolver([
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p'
  ]);

  double _getScore(List<String> userWords, List<String> compWords) {
    score_calculator c = score_calculator();
    int userScore = c.getMaxScore(userWords);
    int compScore = c.getMaxScore(compWords);
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
            content: Text(words.join("\n")));
      },
    );
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
          _addWordToArray(words.join("\n") + "\n" + myController.text);
          myController.clear();
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
