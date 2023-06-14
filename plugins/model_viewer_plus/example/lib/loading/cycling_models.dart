import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  String js = r'''
const models = ['shishkebab.glb', 'Astronaut.glb'];
const toggleModel = document.querySelector('#toggle-model');
let j = 0;
setInterval(() => toggleModel.setAttribute('src', `https://modelviewer.dev/shared-assets/models/${models[j++ % 2]}`), 2000);
''';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("Model Viewer")),
          body: ModelViewer(
            id: "toggle-model",
            src: "https://modelviewer.dev/shared-assets/models/shishkebab.glb",
            alt: "A 3D model of a shishkebab",
            shadowIntensity: 1,
            cameraControls: true,
            autoRotate: true,
            relatedJs: js,
          )),
    );
  }
}
