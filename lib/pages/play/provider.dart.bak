import 'package:bujuan_music/pages/main/provider.dart';
import 'package:bujuan_music_api/bujuan_music_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../widgets/lyric/mode/lyric_line.dart';

part 'provider.g.dart';


@riverpod
Future<List<LyricLine>> getMediaLyric(Ref ref) async {
  var mediaItem = ref.watch(mediaItemProvider).value;
  var songLyric = await BujuanMusicManager().songLyric(id: mediaItem?.id ?? '');
  return parseLrc(songLyric?.lrc?.lyric ?? '');
}

List<LyricLine> parseLrc(String lrc) {
  final lines = lrc.split('\n');
  final regex = RegExp(r'\[(\d+):(\d+\.\d+)\](.*)');

  return lines
      .map((line) {
        final match = regex.firstMatch(line);
        if (match != null) {
          final min = int.parse(match.group(1)!);
          final sec = double.parse(match.group(2)!);
          var text = match.group(3)!.trim();

          return LyricLine(
            text: text,
            timestamp: Duration(
              minutes: min,
              milliseconds: (sec * 1000).toInt(),
            ),
          );
        }
        return LyricLine(text: '', timestamp: Duration.zero);
      })
      .where((e) => e.text.isNotEmpty)
      .toList();
}
