import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() => runApp(MyApp());

String js = '''
  const modelViewer = document.querySelector('#change-speed-demo');
  const speeds = [1, 2, 0.5, -1];

  let i = 0;
  const play = () => {
    modelViewer.timeScale = speeds[i++%speeds.length];
    modelViewer.play({repetitions: 1});
  };
  modelViewer.addEventListener('load', play);
  modelViewer.addEventListener('finished', play);
''';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Model Viewer")),
        body: ModelViewer(
          id: "change-speed-demo",
          cameraControls: true,
          animationName: "Dance",
          ar: true,
          shadowIntensity: 1,
          src:
              "https://modelviewer.dev/shared-assets/models/RobotExpressive.glb",
          alt: "An animate 3D model of a robot",
          backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
          relatedJs: js,
        ),
      ),
    );
  }
}
