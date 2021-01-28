import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_ar_sample/app_modules/web_ar/bloc/web_ar_bloc.dart';

class SliverAppBarBackground extends StatelessWidget {
  const SliverAppBarBackground({this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final WebArBloc bloc = Provider.of<WebArBloc>(context, listen: false);

    return StreamBuilder<String>(
        stream: bloc.search,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
            Container(
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
                          child: TextField(
                            controller: controller,
                            onSubmitted: (_) =>
                                FocusScope.of(context).unfocus(),
                            onChanged: bloc.searchListener,
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
            )));
  }
}
