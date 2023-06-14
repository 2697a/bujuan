/* This is free and unencumbered software released into the public domain. */

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Model Viewer")),
        body: ModelViewer(
          backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
          src: 'assets/Astronaut.glb', // a bundled asset file
          alt: "A 3D model of an astronaut",
          ar: true,
          arModes: ['scene-viewer', 'webxr', 'quick-look'],
          autoRotate: true,
          cameraControls: true,
          iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
          disableZoom: true,
        ),
      ),
    );
  }
}
