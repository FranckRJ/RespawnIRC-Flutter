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
    return Consumer<ForumPageModel>(
      builder: (context, model, child) => Scrollbar(
        child: ListView.builder(
          itemCount: max((model.topicsData.length * 2) - 1, 0),
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd) return Divider(height: 1, thickness: 1);

            int topicIndex = index ~/ 2;

            return TopicItem(
              topicData: model.topicsData[topicIndex],
              isBackgroundColored: topicIndex.isOdd,
            );
          },
        ),
      ),
    );
  }
}
