
import 'lyric_parser/lyrics_parse.dart';
import 'lyric_parser/parser_smart.dart';
import 'lyrics_reader_model.dart';
import 'package:collection/collection.dart';

/// lyric Util
/// support Simple format、Enhanced format
class LyricsModelBuilder {
  ///if line time is null,then use MAX_VALUE replace
  static const defaultLineDuration = 5000;

  var _lyricModel = LyricsReaderModel();

  reset() {
    _lyricModel = LyricsReaderModel();
  }

  List<LyricsLineModel>? mainLines;
  List<LyricsLineModel>? extLines;

  static LyricsModelBuilder create() => LyricsModelBuilder._();

  LyricsModelBuilder bindLyricToMain(String lyric, [LyricsParse? parser]) {
    mainLines = (parser ?? ParserSmart(lyric)).parseLines();
    return this;
  }

  LyricsModelBuilder bindLyricToExt(String lyric, [LyricsParse? parser]) {
    extLines = (parser ?? ParserSmart(lyric)).parseLines(isMain: false).cast<LyricsLineModel>();
    return this;
  }

  _setLyric(List<LyricsLineModel>? lineList, {isMain = true}) {
    if (lineList == null) return;
    //下一行的开始时间则为上一行的结束时间，若无则MAX
    for (int i = 0; i < lineList.length; i++) {
      var currLine = lineList[i];
      try {
        currLine.endTime = lineList[i + 1].startTime;
      } catch (e) {
        var lastSpan = currLine.spanList?.lastOrNull;
        if (lastSpan != null) {
          currLine.endTime = lastSpan.end;
        } else {
          currLine.endTime = (currLine.startTime ?? 0) + defaultLineDuration;
        }
      }
    }
    if (isMain) {
      _lyricModel.lyrics.clear();
      _lyricModel.lyrics.addAll(lineList);
    } else {
      //扩展歌词对应行
      for (var mainLine in _lyricModel.lyrics) {
        var extLine = lineList.firstWhere(
            (extLine) =>
                mainLine.startTime == extLine.startTime &&
                mainLine.endTime == extLine.endTime, orElse: () {
          return LyricsLineModel();
        });
        mainLine.extText = extLine.extText;
      }
    }
  }

  LyricsReaderModel getModel() {
    _setLyric(mainLines, isMain: true);
    _setLyric(extLines, isMain: false);

    return _lyricModel;
  }

  LyricsModelBuilder._();
}
