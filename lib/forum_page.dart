import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forum_page_model.dart';
import 'topic_item.dart';

class ForumPage extends StatefulWidget {
  ForumPage({@required this.page});

  final int page;

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  @override
  void initState() {
    super.initState();
    context.read<ForumPageModel>().fetchPage();
  }

  Widget build(BuildContext context) {
    final model = context.watch<ForumPageModel>();
    final int itemCount = max((model.topicsData.length * 2) - 1, 0);
    final children = <Widget>[];

    for (int idx = 0; idx < itemCount; ++idx) {
      if (idx.isOdd) {
        children.add(const Divider(height: 1, thickness: 1));
        continue;
      }

      int topicIndex = idx ~/ 2;

      children.add(TopicItem(
        topicData: model.topicsData[topicIndex],
        isBackgroundColored: topicIndex.isOdd,
      ));
    }

    return Scrollbar(
      child: ListView(children: children),
    );
  }
}
