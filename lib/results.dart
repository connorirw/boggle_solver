import 'package:flutter/material.dart';

List<String> words = [];

class results extends StatelessWidget {
  const results({Key? key}) : super(key: key);

  void _addWord(String word) {
    words.add(word);
    print(words);
  }

  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    return Scaffold(
      body: Center(
        child: TextField(
          controller: _controller,
          onSubmitted: (String value) async {
            _addWord(value.toString());
            /*
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thanks!'),
                  content: Text(
                      'You typed "$value", which has length ${value.characters.length}.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
            */
          },
        ),
      ),
    );
  }
}
