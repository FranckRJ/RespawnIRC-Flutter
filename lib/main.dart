import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forum_model.dart';
import 'topic_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RespawnIRC',
      initialRoute: '/',
      routes: {
        '/': (context) => ForumScreen(),
        '/topic': (context) => Scaffold(
              appBar: AppBar(
                title: Text('RespawnIRC Topic'),
              ),
              body: Center(child: Text('Lol flemme')),
            ),
      },
    );
  }
}

class ForumScreen extends StatelessWidget {
  Drawer _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForumModel(
        url: 'https://www.jeuxvideo.com/forums/0-1000005-0-1-0-1-0-android.htm',
      ),
      child: Scaffold(
        drawer: _drawer(context),
        appBar: AppBar(
          title: Consumer<ForumModel>(
            builder: (BuildContext context, ForumModel value, Widget child) =>
                Text(value.name.isEmpty ? 'RespawnIRC' : value.name),
          ),
        ),
        body: ForumPageList(),
      ),
    );
  }
}

class ForumPageList extends StatefulWidget {
  @override
  _ForumPageListState createState() => _ForumPageListState();
}

class _ForumPageListState extends State<ForumPageList> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    context.read<ForumModel>().fetchForum();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Colors.white,
            width: double.infinity,
            child: Center(child: Text('$_index'))),
        Expanded(
          child: PageView.builder(
            onPageChanged: (int index) {
              setState(() {
                _index = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return TopicList();
            },
            itemCount: 10,
            controller: PageController(initialPage: _index),
          ),
        )
      ],
    );
  }
}
