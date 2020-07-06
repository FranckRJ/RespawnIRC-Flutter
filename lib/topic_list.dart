import 'dart:math';

import 'package:flutter/material.dart';

import 'topic_item.dart';

class TopicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topicDatas = [
      TopicData(
          title: 'It is a title',
          author: 'not me',
          date: '5/12/1235',
          messageCount: 5),
      TopicData(
          title: 'Bored to find',
          author: 'someone else',
          date: '5/2/1235',
          messageCount: 0),
      TopicData(
          title: 'Something',
          author: 'big big boy',
          date: '5/12/3155',
          messageCount: 15),
      TopicData(
          title: 'Something else',
          author: 'not so far away',
          date: '5/12/6453',
          messageCount: 1235,
          type: TopicType.MultiPage),
      TopicData(
          title: 'One day it will be original',
          author: 'original',
          date: 'yesterday',
          messageCount: 2,
          type: TopicType.Locked),
      TopicData(
          title: 'But not now',
          author: 'not original',
          date: '12:53',
          messageCount: 32),
      TopicData(
          title: 'It is a title',
          author: 'not me',
          date: '5/12/1235',
          messageCount: 5),
      TopicData(
          title: 'Bored to find',
          author: 'someone else',
          date: '5/2/1235',
          messageCount: 0,
          type: TopicType.Deleted),
      TopicData(
          title: 'Something',
          author: 'big big boy',
          date: '5/12/3155',
          messageCount: 15),
      TopicData(
          title: 'Something else',
          author: 'not so far away',
          date: '5/12/6453',
          messageCount: 1235),
      TopicData(
          title: 'One day it will be original',
          author: 'original',
          date: 'yesterday',
          messageCount: 2,
          type: TopicType.Pinned),
      TopicData(
          title: 'But not now',
          author: 'not original',
          date: '12:53',
          messageCount: 32),
      TopicData(
          title: 'It is a title',
          author: 'not me',
          date: '5/12/1235',
          messageCount: 5),
      TopicData(
          title: 'Bored to find',
          author: 'someone else',
          date: '5/2/1235',
          messageCount: 0,
          type: TopicType.PinnedAndLocked),
      TopicData(
          title: 'Something',
          author: 'big big boy',
          date: '5/12/3155',
          messageCount: 15),
      TopicData(
          title: 'Something else',
          author: 'not so far away',
          date: '5/12/6453',
          messageCount: 1235),
      TopicData(
          title: 'One day it will be original',
          author: 'original',
          date: 'yesterday',
          messageCount: 2,
          type: TopicType.Solved),
      TopicData(
          title: 'But not now',
          author: 'not original',
          date: '12:53',
          messageCount: 32),
    ];

    return Scrollbar(
      child: ListView.builder(
        itemCount: max((topicDatas.length * 2) - 1, 0),
        itemBuilder: (BuildContext context, int index) {
          if (index.isOdd) return Divider(height: 1, thickness: 1);

          int topicIndex = index ~/ 2;

          return TopicItem(
            topicData: topicDatas[topicIndex],
            isBackgroundColored: topicIndex.isOdd,
          );
        },
      ),
    );
  }
}
