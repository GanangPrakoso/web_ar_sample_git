import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'custom_model_viewer.dart';

class ObjectCard extends StatelessWidget {
  const ObjectCard({this.name, this.assets, this.modelSrc, this.fetched});
  final String name, assets, modelSrc;
  final bool fetched;

  @override
  Widget build(BuildContext context) {
    if (fetched == false) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 17),
                    blurRadius: 17,
                    spreadRadius: -23,
                    color: Color(0xffe6e6e6))
              ]),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    enabled: true,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  )),
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        enabled: true,
                        child: Container(
                          height: 15,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                      ))
                ]),
          ));
    }
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push<MaterialPageRoute>(MaterialPageRoute(
        builder: (BuildContext context) => CustomModalViewer(
          src: modelSrc,
          title: name,
        ),
      )),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 17),
                    blurRadius: 17,
                    spreadRadius: -23,
                    color: Color(0xffe6e6e6))
              ]),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(assets)),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12)),
                  )),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ]),
          )),
    );
  }
}
