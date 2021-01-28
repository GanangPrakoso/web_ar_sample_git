import 'package:flutter/material.dart';
import 'sliver_app_bar_background.dart';

class HomePageAppBar extends StatefulWidget {
  @override
  _HomePageAppBarState createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        floating: false,
        snap: false,
        pinned: true,
        forceElevated: true,
        backgroundColor: const Color(0xff2162a9),
        expandedHeight: 210,
        title: const Text('Mandaya Plaza AR'),
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/app_bar_bg.jpg'))),
              child: SliverAppBarBackground()),
        ));
  }
}
