import 'package:boggle_solver/results.dart';
import 'package:flutter/material.dart';
import 'parse_dice.dart';

class BoardView extends StatefulWidget {
  List<String> lines;
  BoardView({Key? key,  required this.lines} ) : super(key: key);

  @override
  _BoardViewState createState() => _BoardViewState();
}


class _BoardViewState extends State<BoardView> {

  List<String> editedLines = [];
  TextEditingController _line1 = TextEditingController();
  TextEditingController _line2 = TextEditingController();
  TextEditingController _line3 = TextEditingController();
  TextEditingController _line4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    editedLines = widget.lines;
    _line1.text = editedLines[0];
    _line2.text = editedLines[1];
    _line3.text = editedLines[2];
    _line4.text = editedLines[3];
  }

  void _submitBoard() {
    //TODO
    print(_line1.text);
    List<String> diceValues = [];
    diceValues.addAll(_line1.text.characters);
    diceValues.addAll(_line2.text.characters);
    diceValues.addAll(_line3.text.characters);
    diceValues.addAll(_line4.text.characters);
    for (int i = 0; i < diceValues.length - 1; i++) {
      if (diceValues[i] == 'q') {
        diceValues[i] = 'qu';
        diceValues.removeAt(i+1);
      }
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => results(diceValues: diceValues)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View and edit board')),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _line1
            ),
            TextField(
              controller: _line2,
            ),
            TextField(
              controller: _line3,
            ),
            TextField(
              controller: _line4,
            ),
            TextButton(
              child: const Text("Submit Board"),
              onPressed: _submitBoard,
            )
          ],
        ),
        ),
      );
  }
}