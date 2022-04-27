// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Boggle Solver'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
              child: Icon(Icons.add_a_photo,
                  size: 100, color: Color.fromARGB(255, 71, 149, 236)),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: Text(
                  'Take Picture',
                  style: TextStyle(fontSize: 15.0),
                ),
                color: Color.fromARGB(255, 71, 149, 236),
                textColor: Color.fromARGB(255, 250, 250, 250),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: Text(
                  'Select From Camera Roll',
                  style: TextStyle(fontSize: 15.0),
                ),
                color: Color.fromARGB(255, 71, 149, 236),
                textColor: Color.fromARGB(255, 250, 250, 250),
                onPressed: () {},
              ),
            ),
          ]))),
    );
  }
}
