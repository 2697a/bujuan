
import '../lyrics_reader_model.dart';

///all parse extends this file
abstract class LyricsParse {
  String lyric;

  LyricsParse(this.lyric);

  ///call this method parse
  List<LyricsLineModel> parseLines({bool isMain: true});

  ///verify [lyric] is matching
  bool isOK() => true;
}
