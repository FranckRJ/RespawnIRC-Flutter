import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'forum_model.dart';

class ForumPageModel extends ChangeNotifier {
  ForumPageModel({@required this.forum, @required this.page});

  final ForumModel forum;
  final int page;

  Future<void> fetchPage() async {
    http.Response response;

    try {
      // do stuff to set page url from forum url
      // but i'm lazy so i won't do it now
      response = await http.get(forum.url);
    } catch (e) {
      forum.name = "LolCrash";
      return;
    }

    forum.name = response.statusCode.toString();
  }
}
