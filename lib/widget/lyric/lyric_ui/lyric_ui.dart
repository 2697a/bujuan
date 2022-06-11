import 'package:flutter/material.dart';

///lyric UI base
///all lyric UI should be extends this file
abstract class LyricUI {
  ///主歌词样式（播放行）
  TextStyle getPlayingMainTextStyle();

  ///扩展歌词样式（播放行）
  TextStyle getPlayingExtTextStyle();

  ///主歌词样式（其他行）
  TextStyle getOtherMainTextStyle();

  ///扩展歌词样式（其他行）
  TextStyle getOtherExtTextStyle();

  ///空白行默认高度
  double getBlankLineHeight() => 0;

  ///行高
  double getLineSpace();

  ///行内间距
  double getInlineSpace();

  ///播放行偏移
  ///由上而下偏移，范围：0~1；
  ///eg:0.4
  double getPlayingLineBias();

  ///ending在比一半尺寸还小的位置时太丑
  ///true 最少也会偏移到bias0.5的位置，不会比0.5再小了
  ///false 无限制 将会偏移到bias0.5
  bool halfSizeLimit() => getPlayingLineBias() < 0.5;

  ///歌词对齐方向
  ///支持左中右对齐
  LyricAlign getLyricHorizontalAlign();

  LyricBaseLine getBiasBaseLine() => LyricBaseLine.CENTER;

  ///单行铺满后的居中方式
  TextAlign getLyricTextAligin() {
    switch (getLyricHorizontalAlign()) {
      case LyricAlign.LEFT:
        return TextAlign.left;
      case LyricAlign.RIGHT:
        return TextAlign.right;
      case LyricAlign.CENTER:
        return TextAlign.center;
    }
  }

  ///启用行动画
  bool enableLineAnimation() => true;

  bool enableHighlight() => true;

  Color getLyricHightlightColor() => Colors.amber;

  @override
  String toString() {
    return '${getPlayingMainTextStyle()}'
        '${getPlayingExtTextStyle()}'
        '${getOtherMainTextStyle()}'
        '${getOtherExtTextStyle()}'
        '${getBlankLineHeight()}'
        '${getLineSpace()}'
        '${getInlineSpace()}'
        '${getPlayingLineBias()}'
        '${getLyricHorizontalAlign()}'
        '${getLyricTextAligin()}'
        '${getBiasBaseLine()}';
  }
}

///lyric align enum
enum LyricAlign { LEFT, CENTER, RIGHT }

///lyric base line enum
enum LyricBaseLine { MAIN_CENTER, CENTER, EXT_CENTER }
