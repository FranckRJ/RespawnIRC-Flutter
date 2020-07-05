import 'package:flutter/material.dart';

import 'topic_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RespawnIRC',
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
              drawer: Drawer(
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
              ),
              appBar: AppBar(
                title: Text('RespawnIRC'),
              ),
              body: ForumPageList(),
            ),
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

class ForumPageList extends StatefulWidget {
  @override
  _ForumPageListState createState() => _ForumPageListState();
}

class _ForumPageListState extends State<ForumPageList> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(color: Colors.white, width: double.infinity, child: Center(child: Text('$_index'))),
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
