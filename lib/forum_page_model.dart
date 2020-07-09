import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'forum_model.dart';
import 'topic_data.dart';

class ForumPageModel extends ChangeNotifier {
  ForumPageModel({@required this.forum, @required this.page});

  static final _pageForumUrlNumberPattern = RegExp(
      r'^(https?://www\.jeuxvideo\.com/forums/[0-9]*-([0-9]*)-[0-9]*-[0-9]*-[0-9]*-)([0-9]*)(-[0-9]*-[^.]*\.htm)');

  static final RegExp _wholeTopicPattern = RegExp(
      r'<li (class="[^"]*" data-id="[^"]*"|class="message[^"]*")>.*?<span class="topic-subject">.*?</li>',
      dotAll: true);

  static final RegExp _nameAndLinkPattern = RegExp(
      r'<a class="lien-jv topic-title[^"]*" href="([^"]*" title="[^"]*)"[^>]*>');
  static final RegExp _topicNumberMessagesPattern =
      RegExp(r'<span class="topic-count">[^0-9]*([0-9]*)');
  static final RegExp _topicNumberMessagesAdmPattern =
      RegExp(r'<span class="topic-count-adm">[^0-9]*([0-9]*)');
  static final RegExp _topicAuthorPattern = RegExp(
      r'<span class=".*?text-([^ ]*) topic-author[^>]*>[^A-Za-z0-9\[\]_-]*([^<\n\r ]*)');
  static final RegExp _topicDatePattern =
      RegExp(r'<span class="topic-date">[^<]*<span[^>]*>[^0-9/:]*([0-9/:]*)');

  final ForumModel forum;
  final int page;
  List<TopicData> _topicsData = [];

  UnmodifiableListView<TopicData> get topicsData =>
      UnmodifiableListView<TopicData>(_topicsData);

  Future<void> fetchPage() async {
    http.Response response;

    try {
      final pageForumUrlNumberMatch =
          _pageForumUrlNumberPattern.firstMatch(forum.url);
      final pageUrl = pageForumUrlNumberMatch.group(1) +
          (((page) * 25) + 1).toString() +
          pageForumUrlNumberMatch.group(4);
      // do stuff to set page url from forum url
      // but i'm lazy so i won't do it now
      response = await http.get(pageUrl);
    } catch (e) {
      forum.name = 'LolCrash';
      return;
    }

    _topicsData.clear();

    for (final wholeTopicMatch
        in _wholeTopicPattern.allMatches(response.body)) {
      final wholeTopic = wholeTopicMatch.group(0);

      final nameAndLinkMatch = _nameAndLinkPattern.firstMatch(wholeTopic);
      final topicNumberMessagesMatch =
          _topicNumberMessagesPattern.firstMatch(wholeTopic);
      final topicAuthorMatch = _topicAuthorPattern.firstMatch(wholeTopic);
      final topicDateMatch = _topicDatePattern.firstMatch(wholeTopic);

      final String topicNameAndLinkString = nameAndLinkMatch.group(1);
      final String title = topicNameAndLinkString
          .substring(topicNameAndLinkString.indexOf(r'title="') + 7);

      _topicsData.add(
        TopicData(
          title: title,
          messageCount: int.parse(topicNumberMessagesMatch.group(1)),
          author: topicAuthorMatch?.group(2)?.trim() ?? 'Pseudo supprimé',
          date: topicDateMatch.group(1),
        ),
      );
    }

    forum.name = response.statusCode.toString();
    notifyListeners();
  }
}
