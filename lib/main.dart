// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void _openCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  }

  void _openGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Boggle Solver'),
          ),
          body: Center(
              child: Column(
                children: <Widget>[
                  const Icon(
                    Icons.add_a_photo,
                    size: 100, 
                    color: Color.fromARGB(255, 71, 149, 236)
                  ),
                  
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: FlatButton(
                      onPressed: _openCamera,
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
                      onPressed: _openGallery,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: FlatButton(
                      onPressed: _openCamera,
                      child: const Text(
                        'Leaderboard',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      color: const Color.fromARGB(255, 71, 149, 236),
                      textColor: const Color.fromARGB(255, 250, 250, 250),
                    ),
                  ),
                ]))),
    );
  }
}
