// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

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

void main() => runApp(MaterialApp(
      title: "App",
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      image = await _picker.pickImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1920);
    }
    print('image path');
    print(image.path);
    ocr.DiceParcer parcer = ocr.DiceParcer(Io.File(image.path));
    List<String> lines = await parcer.parse();
    Navigator.push(context, MaterialPageRoute(builder: (context) => BoardView(lines: lines)));
  }

  void _openGallery(context) async {
    XFile? image;
    final ImagePicker _picker = ImagePicker();
    while(image == null) {
      image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
    }
    print('image path');
    print(image.path);
    ocr.DiceParcer parcer = ocr.DiceParcer(Io.File(image.path));
    List<String> lines = await parcer.parse();
    Navigator.push(context, MaterialPageRoute(builder: (context) => BoardView(lines: lines)));
  }

  void _runDemo(context) async {
    List<String> dice = [
      "a","t","i","e",
      "e","a","h","a",
      "v","e","l","r",
      "g","w","i","s"];
    Navigator.push(context, MaterialPageRoute(builder: (context) => results(diceValues: dice)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                child: const Text(
                  'Open Demo Board',
                  style: TextStyle(fontSize: 15.0),
                ),
                color: const Color.fromARGB(255, 71, 149, 236),
                textColor: const Color.fromARGB(255, 250, 250, 250),
                onPressed: () => _runDemo(context),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: FlatButton(
                child: const Text(
                  'Leaderboard',
                  style: TextStyle(fontSize: 15.0),
                ),
                color: const Color.fromARGB(255, 71, 149, 236),
                textColor: const Color.fromARGB(255, 250, 250, 250),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => leaderboard(storage: Storage())));
                },
              ),
            ),
          ]))),
    );
  }
}
