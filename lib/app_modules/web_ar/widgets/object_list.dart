import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_ar_sample/app_modules/web_ar/bloc/web_ar_bloc.dart';
import 'package:web_ar_sample/app_modules/web_ar/components/object_card.dart';

class ObjectList extends StatelessWidget {
  String _nameGetter(String value) {
    final List<String> temp = value.split('/');
    return temp[4].replaceAll('_', ' ');
  }

  @override
  Widget build(BuildContext context) {
    final WebArBloc bloc = Provider.of<WebArBloc>(context, listen: false);

    return StreamBuilder<List<String>>(
        stream: bloc.objectList,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) => ObjectCard(
                    assets: snapshot.data[index] + '.png',
                    modelSrc: snapshot.data[index] + '.glb',
                    name: _nameGetter(snapshot.data[index]),
                  ));
        });
  }
}
