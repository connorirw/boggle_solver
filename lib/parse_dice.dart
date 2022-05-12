import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
void main() async {
  var bytes = io.File('realbboggle.jpg').readAsBytesSync();
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
  parsedText = result['ParsedResults'][0]['ParsedText'];
  print(parsedText);
}
