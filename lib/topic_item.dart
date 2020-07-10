import 'package:flutter/material.dart';

import 'topic_data.dart';

export 'topic_data.dart';

class TopicItem extends StatelessWidget {
  TopicItem({@required this.topicData, this.isBackgroundColored = false});

  final TopicData topicData;
  final bool isBackgroundColored;

  String _topicTypeToAssetName(TopicType type) {
    switch (type) {
      case TopicType.SinglePage:
        return 'assets/icon_topic_dossier1.png';
      case TopicType.MultiPage:
        return 'assets/icon_topic_dossier2.png';
      case TopicType.Locked:
        return 'assets/icon_topic_lock_light.png';
      case TopicType.Pinned:
        return 'assets/icon_topic_marque_on.png';
      case TopicType.PinnedAndLocked:
        return 'assets/icon_topic_marque_off.png';
      case TopicType.Solved:
        return 'assets/icon_topic_resolu.png';
      case TopicType.Deleted:
        return 'assets/icon_topic_ghost.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: (isBackgroundColored ? Colors.cyan[50] : Colors.white),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/topic');
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: Image.asset(
                  _topicTypeToAssetName(topicData.type),
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: topicData.title,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: '(${topicData.messageCount})',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DefaultTextStyle.merge(
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(topicData.author),
                          Text(topicData.date),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
