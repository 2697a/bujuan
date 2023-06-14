/* This is free and unencumbered software released into the public domain. */

import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';

import 'package:model_viewer_plus/src/html_builder.dart' show HTMLBuilder;

void main() {
  group('HTMLBuilder', () {
    test('supports the src and backgroundColor attributes', () {
      final html = HTMLBuilder.build(
        src: 'src.glb',
        backgroundColor: const Color(0xABCDEF),
      );
      expect(html,
          '<model-viewer src="src.glb" style="background-color: rgb(171, 205, 239);"></model-viewer>\n');
    });
  });
}
