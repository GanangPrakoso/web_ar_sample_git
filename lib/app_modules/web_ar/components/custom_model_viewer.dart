import 'package:flutter/material.dart';
import 'package:model_viewer/model_viewer.dart';

class CustomModalViewer extends StatelessWidget {
  const CustomModalViewer({this.src, this.title});
  final String src, title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ModelViewer(
        src: src,
        title: title,
        ar: true,
        autoRotate: true,
        cameraControls: true,
        backgroundColor: Colors.white,
        autoPlay: true,
        autoRotateDelay: 1500,
        arScale: 'auto',
      )),
    );
  }
}
