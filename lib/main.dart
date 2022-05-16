// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:html';

import 'package:boggle_solver/board_view.dart';
import 'package:boggle_solver/leaderboard.dart';
import 'package:boggle_solver/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'parse_dice.dart' as ocr;
import 'dart:io' as Io;
import 'package:http/http.dart' as http;
import "dart:core";

///////////
import 'dart:async';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
///////////

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(
      ),
    );
  }

 

 

}////////
class FirstScreen extends StatelessWidget {

   Future<List<String>> _importText() async {
    List<String> words = [];
    await rootBundle.loadString('assets/text/bigDictionary.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        words.add(i);
      }
    });
    return words;
  }

  void _openCamera(context) async {
    XFile? image;
    final ImagePicker _picker = ImagePicker();
    while (image == null) {
      image = await _picker.pickImage(source: ImageSource.camera);
    }
    print('image path');
    print(image.path);
    ocr.DiceParcer parcer = ocr.DiceParcer(Io.File(image.path));
    List<String> lines = await parcer.parse();
    //Navigator.push(context, MaterialPageRoute(builder: (context) => results()));
    Navigator.push(context, MaterialPageRoute(builder: (context) => BoardView(lines: lines)));
  }

  void _openGallery(context) async {
    XFile? image;
    final ImagePicker _picker = ImagePicker();
    while(image == null) {
      image = await _picker.pickImage(source: ImageSource.gallery);
    }
    print('image path');
    print(image.path);
    ocr.DiceParcer parcer = ocr.DiceParcer(Io.File(image.path));
    List<String> lines = await parcer.parse();
    //List<String> lines = await ocr.DiceParcer.parseBoard(Io.File(image.path));
    //Navigator.push(context, MaterialPageRoute(builder: (context) => results()));
    Navigator.push(context, MaterialPageRoute(builder: (context) => BoardView(lines: lines)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Boggle Solver'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            const Icon(Icons.add_a_photo,
                size: 100, color: Color.fromARGB(255, 71, 149, 236)),
            Container(
              margin: const EdgeInsets.all(25),
              child: FlatButton(
                onPressed: () => _openCamera(context),
                child: const Text(
                  'Take Picture',
                  style: TextStyle(fontSize: 15.0),
                ),
                color: const Color.fromARGB(255, 71, 149, 236),
                textColor: const Color.fromARGB(255, 250, 250, 250),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: FlatButton(
                child: const Text(
                  'Select From Camera Roll',
                  style: TextStyle(fontSize: 15.0),
                ),
                color: const Color.fromARGB(255, 71, 149, 236),
                textColor: const Color.fromARGB(255, 250, 250, 250),
                onPressed: () => _openGallery(context),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: FlatButton(
                //onPressed: _openCamera,
                child: const Text(
                  'Leaderboard',
                  style: TextStyle(fontSize: 15.0),
                ),
                color: const Color.fromARGB(255, 71, 149, 236),
                textColor: const Color.fromARGB(255, 250, 250, 250),
                onPressed: () {
                  //right way: use context in below level tree with MaterialApp
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => leaderboard(),));
                },
              ),
            ),
            ///////////////////////
            
          ])),
    );
  }
}


/*
//////////////////////////////////////////////////////
class Home extends StatefulWidget {
  final Storage storage;

  Home({Key? key, required this.storage}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  String state = "";
  Future<Io.Directory> _appDocDir = getApplicationDocumentsDirectory();

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((String value) {
      setState(() {
        state = value;
      });
    });
  }

  Future<Io.File> writeData() async {
    setState(() {
      state = controller.text;
      controller.text = '';
    });

    return widget.storage.writeData(state);
  }

  void getAppDirectory() {
    setState(() {
      _appDocDir = getApplicationDocumentsDirectory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('${state ?? "File is Empty"}'),
            TextField(
              controller: controller,
            ),
            RaisedButton(
              onPressed: writeData,
              child: Text('Write to File'),
            ),
            RaisedButton(
              child: Text("Get DIR path"),
              onPressed: getAppDirectory,
            ),
            FutureBuilder<Io.Directory>(
              future: _appDocDir,
              builder:
                  (BuildContext context, AsyncSnapshot<Io.Directory> snapshot) {
                Text text = Text('');
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    text = Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    text = Text('Path: ${snapshot.data?.path}');
                  } else {
                    text = Text('Unavailable');
                  }
                }
                return new Container(
                  child: text,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<Io.File> get localFile async {
    final path = await localPath;
    return Io.File('$path/db.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<Io.File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}

*/