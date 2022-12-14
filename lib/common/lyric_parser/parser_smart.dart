//
// import 'lyrics_parse.dart';
// import 'lyrics_reader_model.dart';
//
// ///smart parser
// ///Parser is automatically selected
// class ParserSmart extends LyricsParse {
//   ParserSmart(String lyric) : super(lyric);
//
//   @override
//   List<LyricsLineModel> parseLines({bool isMain: true}) {
//     var qrc = ParserQrc(lyric);
//     if (qrc.isOK()) {
//       return qrc.parseLines(isMain: isMain);
//     }
//     return ParserLrc(lyric).parseLines(isMain: isMain);
//   }
// }
