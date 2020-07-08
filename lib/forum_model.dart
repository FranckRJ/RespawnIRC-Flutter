import 'package:flutter/foundation.dart';

class ForumModel extends ChangeNotifier {
  ForumModel({@required this.url});

  final String url;

  String _name = '';

  String get name => _name;

  set name(String val) {
    _name = val;
    notifyListeners();
  }
}
