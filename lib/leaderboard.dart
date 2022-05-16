import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


/*
class leaderboard extends StatelessWidget {
  const leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}
*/

////////////////////////////////////////////

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Reading and Writing to Storage",
      home: leaderboard(
        storage: Storage(),
      ),
    );
  }
}


class leaderboard extends StatefulWidget {
  final Storage storage;

  leaderboard({Key? key, required this.storage}) : super(key: key);

  @override
  leaderboardState createState() => leaderboardState();
}

class leaderboardState extends State<leaderboard> {
  TextEditingController controller = TextEditingController();
  String state = "";
  Future<Directory> _appDocDir = getApplicationDocumentsDirectory();

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((String value) {
      setState(() {
        state = value;
      });
    });
  }

  Future<File> writeData() async {
    setState(() {
      state = controller.text;
      controller.text = '';
    });

    return widget.storage.writeData(state);
  }

  void _resetData() {
    widget.storage.resetData();
    widget.storage.readData().then((String value) {
      setState(() {
        state = value;
      });
    });
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
            Text('${state}'),
            TextField(
              controller: controller,
            ),
            ElevatedButton(
              onPressed: writeData,
              child: Text('Write to File'),
            ),
            // RaisedButton(
            //   onPressed: readData,
            //   child: Text("Read from File"),
            // ),
            ElevatedButton(
              child: Text("Get DIR path"),
              onPressed: getAppDirectory,
            ),
            ElevatedButton(
              child: Text("Reset Leaderboard"),
              onPressed: _resetData,
            ),
            FutureBuilder<Directory>(
              future: _appDocDir,
              builder:
                  (BuildContext context, AsyncSnapshot<Directory> snapshot) {
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

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
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

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data\n", mode: FileMode.append);
  }

  Future<File> resetData() async {
    final file = await localFile;
    return file.writeAsString("Erik    12.50%\n");
  }
}
