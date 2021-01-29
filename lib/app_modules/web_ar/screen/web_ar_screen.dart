import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:web_ar_sample/app_modules/web_ar/widgets/empty_list.dart';

import '../bloc/web_ar_bloc.dart';
import '../components/object_card.dart';
import '../widgets/home_page_app_bar.dart';

class WebArScreen extends StatelessWidget {
  final scrollController = ScrollController();

  String _nameConverter(String value) {
    final List<String> temp = value.split('/');
    return temp[4].replaceAll('_', ' ');
  }

  @override
  Widget build(BuildContext context) {
    final WebArBloc bloc = Provider.of<WebArBloc>(context, listen: false);

    return Scaffold(
      body: StreamBuilder<List<String>>(
          stream: bloc.objectList,
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            return RefreshIndicator(
              onRefresh: () async {
                await bloc.refreshList();
                return Future.value(false);
              },
              child: CustomScrollView(slivers: <Widget>[
                HomePageAppBar(),
                if (!snapshot.hasData)
                  SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20.0,
                                crossAxisSpacing: 20.0,
                                childAspectRatio: .85),
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) =>
                                const ObjectCard(fetched: false),
                            childCount: 6)),
                  )
                else if (snapshot.data.length < 1)
                  // fill the empty list UI here
                  SliverFillRemaining(child: EmptyList())
                else
                  SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: LiveSliverGrid(
                        controller: scrollController,
                        itemCount: snapshot.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 20.0,
                          childAspectRatio: .85,
                        ),
                        itemBuilder: (
                          BuildContext context,
                          int index,
                          Animation<double> animation,
                        ) =>
                            // For example wrap with fade transition
                            FadeTransition(
                                opacity: Tween<double>(
                                  begin: 0,
                                  end: 1,
                                ).animate(animation),
                                // And slide transition
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(0, -0.1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: ObjectCard(
                                      assets: snapshot.data[index] + '.png',
                                      modelSrc: snapshot.data[index] + '.glb',
                                      name:
                                          _nameConverter(snapshot.data[index]),
                                      fetched: true),
                                )),
                      )),
              ]),
            );
          }),
    );
  }
}
