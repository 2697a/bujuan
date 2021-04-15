
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtworkWidget extends StatelessWidget {
  final int id;
  final ArtworkType type;
  final ArtworkFormat format;
  final int size;
  final bool requestPermission;
  final BorderRadius artworkBorder;
  final FilterQuality artworkQuality;
  final double artworkWidth;
  final double artworkHeight;
  final BoxFit artworkFit;
  final Widget nullArtworkWidget;

  const ArtworkWidget(
      {Key key,
        @required this.id,
        @required this.type,
        this.format,
        this.size,
        this.requestPermission,
        this.artworkQuality,
        this.artworkBorder,
        this.artworkWidth,
        this.artworkHeight,
        this.artworkFit,
        this.nullArtworkWidget});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnAudioQuery().queryArtworks(
          id,
          type,
          format ?? ArtworkFormat.JPEG,
          size ?? 200,
          requestPermission ?? false),
      builder: (context, AsyncSnapshot<Uint8List> item) {
        if (item.data != null) {
          return ClipRRect(
            borderRadius: artworkBorder ?? BorderRadius.circular(50),
            child: Image.memory(
              item.data,
              width: artworkWidth ?? 50,
              height: artworkHeight ?? 50,
              fit: artworkFit ?? BoxFit.cover,
              filterQuality: artworkQuality ?? FilterQuality.low,
            ),
          );
        }
        return nullArtworkWidget ??
            Icon(
              Icons.image_not_supported,
              size: artworkWidth,
            );
      },
    );
  }
}
