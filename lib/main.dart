// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:boggle_solver/leaderboard.dart';
import 'package:boggle_solver/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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

/*
  void _parseText(XFile? img) async {
    var bytes = Io.File(img!.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);
    //print(img64);

    //Uri url = "https://api.ocr.space/parse/image";
    var httpsUri =
        Uri(scheme: 'https', host: 'api.ocr.space', path: '/parse/image');

    var payload = {"base64Image": "data:image/jpg;base64,${img64.toString()}"};
    var header = {"apikey": "K83166238588957"};
    var post = await http.post(httpsUri, body: payload, headers: header);

    String parsedText = '';
    var result = jsonDecode(post.body);
    parsedText = result['ParsedResults'][0]['ParsedText'];
    print(parsedText);
  }
*/
//////



/////

  void _openCamera(context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    //_parseText(image);
    Navigator.push(context, MaterialPageRoute(builder: (context) => results()));
  }

  void _openGallery(context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    Navigator.push(context, MaterialPageRoute(builder: (context) => results()));
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
                      MaterialPageRoute(builder: (context) => leaderboard()));
                },
              ),
            ),
          ]))),
    );
  }

}



/*
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
*/