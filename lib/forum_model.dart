import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ForumModel extends ChangeNotifier {
  ForumModel({@required this.url});

  final String url;

  String _name = '';

  String get name => _name;

  set name(String val) {
    _name = val;
    notifyListeners();
  }

  Future<void> fetchForum() async {
    final response = await http.get(url);

    name = response.statusCode.toString();
  }
}
