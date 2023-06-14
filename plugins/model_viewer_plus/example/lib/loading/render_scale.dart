import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  String js = r'''
  const reportedDpr = document.querySelector('#reportedDpr');
  const renderedDpr = document.querySelector('#renderedDpr');
  const minimumDpr = document.querySelector('#minimumDpr');
  const pixelWidth = document.querySelector('#pixelWidth');
  const pixelHeight = document.querySelector('#pixelHeight');
  const reason = document.querySelector('#reason');

  // This must be registered before the element loads to catch the initial event.
  document.querySelector('#scale').addEventListener('render-scale', (event) => {
    reportedDpr.textContent = event.detail.reportedDpr;
    renderedDpr.textContent = event.detail.renderedDpr;
    minimumDpr.textContent = event.detail.minimumDpr;
    pixelWidth.textContent = event.detail.pixelWidth;
    pixelHeight.textContent = event.detail.pixelHeight;
    reason.textContent = event.detail.reason;
  });

  const setup = () => {
    const minScale = document.querySelector('#min-scale-value');
    // The static API must be queried after the element loads. Note that static properties affect all the <model-vieweer> elements on the page.
    const ModelViewerStatic = customElements.get('model-viewer');

    document.querySelector('#min-scale').addEventListener('input', (event) => {
      ModelViewerStatic.minimumRenderScale = event.target.value;
      minScale.textContent = event.target.value;
    });
  };

  customElements.whenDefined('model-viewer').then(setup);
''';

  String innerHtml = '''
  Reported DPR: <span id="reportedDpr"></span><br>
  Rendered DPR: <span id="renderedDpr"></span><br>
  Minimum DPR: <span id="minimumDpr"></span><br>
  Rendered width (pixels): <span id="pixelWidth"></span><br>
  Rendered height (pixels): <span id="pixelHeight"></span><br>
  Reason for scaling: <span id="reason"></span><br>
  Minimum scale: <span id="min-scale-value">0.5</span><br>
  <input id="min-scale" type="range" min="0.25" max="1" step="0.01" value="0.5">
''';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("Model Viewer")),
          body: ModelViewer(
            id: "scale",
            src:
                "https://modelviewer.dev/shared-assets/models/glTF-Sample-Models/2.0/ToyCar/glTF-Binary/ToyCar.glb",
            alt: "A 3D model of a toy car",
            cameraControls: true,
            touchAction: TouchAction.panY,
            ar: true,
            relatedJs: js,
            innerModelViewerHtml: innerHtml,
          )),
    );
  }
}
