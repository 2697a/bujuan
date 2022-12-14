
import 'lyrics_reader_model.dart';

class LyricHelper {

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



}
