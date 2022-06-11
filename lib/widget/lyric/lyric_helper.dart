
import 'lyric_ui/lyric_ui.dart';
import 'lyrics_reader_model.dart';

class LyricHelper {
  static double getTotalHeight(
      List<LyricsLineModel>? lyrics, int playingIndex, LyricUI ui) {
    return getLyricHeight(lyrics, playingIndex) + getSpaceHeight(lyrics, ui);
  }

  ///获取歌词整体高度
  static double getLyricHeight(
      List<LyricsLineModel>? lyrics, int playingIndex) {
    if (lyrics == null) {
      return 0;
    }
    double sum = lyrics.fold(0.0, (previousValue, element) {
          var isPlayLine = lyrics.indexOf(element) == playingIndex;
          double mainTextHeight = 0;
          if (element.hasMain) {
            if (isPlayLine) {
              mainTextHeight = (element.drawInfo?.playingMainTextHeight ?? 0);
            } else {
              mainTextHeight = (element.drawInfo?.otherMainTextHeight ?? 0);
            }
          }
          double extTextHeight = 0;
          if (element.hasExt) {
            if (isPlayLine) {
              extTextHeight = (element.drawInfo?.playingExtTextHeight ?? 0);
            } else {
              extTextHeight = (element.drawInfo?.otherExtTextHeight ?? 0);
            }
          }
          return (previousValue ?? 0) + mainTextHeight + extTextHeight;
        }) ??
        0;
    return sum;
  }

  ///获取间距高度
  static double getSpaceHeight(List<LyricsLineModel>? lyrics, LyricUI ui) {
    if (lyrics == null) {
      return 0;
    }
    double sum = lyrics.fold(0.0, (previousValue, element) {
          return (previousValue ?? 0) + getLineSpaceHeight(element, ui);
        }) ??
        0;
    //第一行不用加行间距
    if (sum > 0) {
      sum -= ui.getLineSpace();
    }
    return sum;
  }

  /// 获取行间距
  static double getLineSpaceHeight(LyricsLineModel element, LyricUI ui,
      {bool excludeInline = false}) {
    double spaceHeight = 0;
    if (element.hasExt || element.hasMain) {
      spaceHeight += ui.getLineSpace();
    }
    if (element.hasExt && element.hasMain && !excludeInline) {
      spaceHeight += ui.getInlineSpace();
    }
    if (!element.hasExt && !element.hasMain) {
      spaceHeight += ui.getBlankLineHeight();
    }
    return spaceHeight;
  }

  static double centerOffset(
      LyricsLineModel? lyric, bool isCurr, LyricUI lyricUI, int playIndex) {
    var baseLine = lyricUI.getBiasBaseLine();
    return _realCenterOffset(lyric, isCurr, baseLine, lyricUI, playIndex);
  }

  static double _realCenterOffset(LyricsLineModel? lyric, bool isCurr,
      LyricBaseLine baseLine, LyricUI lyricUI, int playIndex) {
    if (lyric == null) return 0;
    switch (baseLine) {
      case LyricBaseLine.MAIN_CENTER:
        return ((isCurr
                    ? lyric.drawInfo?.playingMainTextHeight
                    : lyric.drawInfo?.otherMainTextHeight) ??
                0) /
            2;
      case LyricBaseLine.EXT_CENTER:
        if (!lyric.hasExt) {
          return _realCenterOffset(
              lyric, isCurr, LyricBaseLine.MAIN_CENTER, lyricUI, playIndex);
        }
        return ((isCurr
                    ? lyric.drawInfo?.playingMainTextHeight
                    : lyric.drawInfo?.otherMainTextHeight) ??
                0) +
            lyricUI.getInlineSpace() +
            ((isCurr
                        ? lyric.drawInfo?.playingExtTextHeight
                        : lyric.drawInfo?.otherExtTextHeight) ??
                    0) /
                2;
      case LyricBaseLine.CENTER:
        if (!lyric.hasExt) {
          return _realCenterOffset(
              lyric, isCurr, LyricBaseLine.MAIN_CENTER, lyricUI, playIndex);
        }
        return ((isCurr
                    ? lyric.drawInfo?.playingMainTextHeight
                    : lyric.drawInfo?.otherMainTextHeight) ??
                0) +
            lyricUI.getInlineSpace() / 2;
    }
  }
}
