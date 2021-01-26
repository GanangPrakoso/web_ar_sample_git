import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/web_ar_bloc.dart';
import '../components/object_card.dart';
import '../widgets/home_page_app_bar.dart';

class WebArScreen extends StatelessWidget {
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
                                const ObjectCard(
                                  fetched: false,
                                ),
                            childCount: 6)),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 20.0,
                          childAspectRatio: .85,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) => ObjectCard(
                              assets: snapshot.data[index] + '.png',
                              modelSrc: snapshot.data[index] + '.glb',
                              name: _nameConverter(snapshot.data[index]),
                              fetched: true),
                          childCount: snapshot.data.length,
                        )),
                  )
              ]),
            );
          }),
    );
  }
}
