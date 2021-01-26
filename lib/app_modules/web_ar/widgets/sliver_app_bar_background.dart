import 'package:flutter/material.dart';

class SliverAppBarBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: 'Search AR',
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.search,
                          color: Color(0xff534B52),
                        )),
                  )),
            )
          ]),
    ));
  }
}
