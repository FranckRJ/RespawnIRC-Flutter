enum TopicType {
  SinglePage,
  MultiPage,
  Locked,
  Pinned,
  PinnedAndLocked,
  Solved,
  Deleted,
}

class TopicData {
  TopicData(
      {this.url = '',
      this.title = '',
      this.author = '',
      this.date = '',
      this.messageCount = 0,
      this.type = TopicType.SinglePage});

  final String url;
  final String title;
  final String author;
  final String date;
  final int messageCount;
  final TopicType type;
}
