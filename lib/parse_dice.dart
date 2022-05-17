import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' as io;

class DiceParcer{
  late io.File image;
  DiceParcer(io.File boardImage) {
    image = boardImage;
  }

  Future<List<String>> parse() async {
    var bytes = image.readAsBytesSync();
    String img64 = base64Encode(bytes);
    String ocrResult = await _callOCR(img64);
    List<String> lines = ocrResult.split('\n');
    for (int i = 0; i < lines.length; i++) {
      lines[i] = lines[i].toLowerCase();
      lines[i] = lines[i].replaceAll(RegExp(r'[^a-z]'), '');
    }
    return lines;
  }

  Future<String> _callOCR(img64) async {
    var httpsUri =
      Uri(scheme: 'https', host: 'api.ocr.space', path: '/parse/image');
    var payload = {
      "base64Image": "data:image/jpg;base64, ${img64.toString()}",
      "OCREngine": "2",
      "isTable": "true",
      "scale": "false"};
    var header = {"apikey": "K83166238588957"};
    var post = await http.post(httpsUri, body: payload, headers: header);
    
    String parsedText = '';
    var result = await jsonDecode(post.body);
    parsedText = await result['ParsedResults'][0]['ParsedText'];
    return parsedText;
  }

  static Future<List<String>> parseBoard(io.File boardImage) async {
    var bytes = boardImage.readAsBytesSync();
    String img64 = base64Encode(bytes);
    var httpsUri =
      Uri(scheme: 'https', host: 'api.ocr.space', path: '/parse/image');
    var payload = {
      "base64Image": "data:image/jpg;base64, ${img64.toString()}",
      "OCREngine": "2",
      "isTable": "true",
      "scale": "true"};
    var header = {"apikey": "K83166238588957"};
    var post = await http.post(httpsUri, body: payload, headers: header);
    String parsedText = '';
    var result = jsonDecode(post.body);
    parsedText = result['ParcedResults'][0]['ParsedText'];
    List<String> lines = parsedText.split('\n');
    for (int i = 0; i < lines.length; i++) {
      lines[i] = lines[i].toLowerCase();
      lines[i] = lines[i].replaceAll(' ', '');
    }
    return lines;
  }
}
