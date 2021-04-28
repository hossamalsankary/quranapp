import 'package:quranv1/quran_screen/compinents/surah.dart';
import 'package:quranv1/quran_screen/plain_screen/plain.dart';
import 'package:flutter/material.dart';

class QuranHome extends StatefulWidget {
  @override
  _QuranHomeState createState() => _QuranHomeState();
}

class _QuranHomeState extends State<QuranHome>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        title: Text("Qurany"),
        centerTitle: true,
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
              icon: Icon(Icons.featured_play_list_rounded),
            ),
            Tab(
              icon: Icon(Icons.local_fire_department_outlined),
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        controller: _controller,
        children: [
          SurahsScreen(),
          PlainScreen(),
        ],
      ),
    );
  }
}
