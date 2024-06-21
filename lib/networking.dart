import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.urlString);
  final String urlString;
  Future getRespCode() async {
    var url = Uri.parse(urlString);
    http.Response rsp = await http.get(url);
    return rsp.statusCode;
  }

  Future getData() async {
    var url = Uri.parse(urlString);
    http.Response rsp = await http.get(url);
    if (rsp.statusCode == 200) {
      String data = rsp.body;
      return jsonDecode(data);
    } else {
      print("Error ${rsp.statusCode}");
    }
  }
}
