import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forum_model.dart';
import 'forum_page_model.dart';
import 'forum_page.dart';

// https://flutter.dev/docs/resources/inside-flutter
// https://medium.com/flutter-community/the-layer-cake-widgets-elements-renderobjects-7644c3142401
// https://medium.com/flutter-community/flutter-what-are-widgets-renderobjects-and-elements-630a57d05208

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
          const DrawerHeader(
            child: const Text('Drawer Header'),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
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

  Widget forumPageView;

  @override
  void initState() {
    super.initState();

    final forumPages = <Widget>[];

    for (int idx = 0; idx < 10; ++idx) {
      forumPages.add(
        ChangeNotifierProvider(
          create: (context) => ForumPageModel(
            forum: context.read<ForumModel>(),
            page: idx,
          ),
          child: ForumPage(page: idx),
        ),
      );
    }

    forumPageView = PageView(
      onPageChanged: (int index) {
        setState(() {
          _index = index;
        });
      },
      children: forumPages,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          child: Center(child: Text('$_index')),
        ),
        Expanded(child: forumPageView),
      ],
    );
  }
}
