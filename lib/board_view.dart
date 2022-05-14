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
    _line1.text = editedLines[1];
    _line2.text = editedLines[2];
    _line3.text = editedLines[3];
    _line4.text = editedLines[4];
  }

  void _submitBoard() {
    //TODO
    print("TODO");
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