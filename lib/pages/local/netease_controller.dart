import 'dart:convert';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/constants/enmu.dart';

class Netease extends GetxController {
  final String appPath = '/Android/data/com.sixbugs.bujuan/files';
  final String neteasePath = '/netease/cloudmusic/Cache/Music1';
  late BuildContext context;
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;
  RxBool loading = true.obs;

  @override
  void onReady() async {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Directory? directoryApp = await getExternalStorageDirectory();
      List<CacheDate> items = await compute(getCache, rootIsolateToken);
      NeteaseMusicApi().songDetail(items.map((e) => e.id).toList()).then((value) {
        mediaItems
          ..clear()
          ..addAll((value.songs ?? [])
              .map((e) => MediaItem(
                  id: e.id,
                  duration: Duration(milliseconds: e.dt ?? 0),
                  artUri: Uri.parse('${e.al?.picUrl ?? ''}?param=500y500'),
                  extras: {
                    'type': MediaType.neteaseCache.name,
                    'url': items.firstWhere((element) => element.id == e.id, orElse: () => CacheDate('', '')).path,
                    'image': e.al?.picUrl ?? '',
                    'liked': false,
                    'artist': (e.ar ?? []).map((e) => jsonEncode(e.toJson())).toList().join(' / '),
                    'album': jsonEncode(e.al?.toJson()),
                    'mv': e.mv
                  },
                  title: e.name ?? "",
                  album: e.al?.name,
                  artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
              .toList());
        loading.value = false;
      });
    });
  }
}

Future<List<CacheDate>> getCache(RootIsolateToken rootIsolateToken) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  Directory? directoryApp = await getExternalStorageDirectory();
  if (directoryApp != null) {
    String replacePath = directoryApp.path.replaceAll('/Android/data/com.sixbugs.bujuan/files', '');
    Directory directoryNetease = Directory('$replacePath/netease/cloudmusic/Cache/Music1');
    List<FileSystemEntity> files = directoryNetease.listSync().where((element) => element.path.contains('.uc')).toList();
    List<CacheDate> ids = [];
    for (var element in files) {
      File songInfo = File(element.path.replaceAll('uc!', 'idx!'));
      if (songInfo.existsSync()) {
        String songInfoStr = songInfo.readAsStringSync();
        int songId = jsonDecode(songInfoStr)['musicId'];
        int size = jsonDecode(songInfoStr)['filesize'];
        if (File(element.path).readAsBytesSync().length >= size) {
          print('object=====$size');
          ids.add(CacheDate('$songId', element.path));
        }
        // File mp3 = File('${directoryApp.path}/$songId.mp3');
        // if (!mp3.existsSync()) {
        //   File file = File(element.path);
        //   Uint8List mp3Data = Uint8List.fromList(file.readAsBytesSync().map((e) => e ^ 0xa3).toList());
        //   await mp3.create();
        //   await mp3.writeAsBytes(mp3Data);
        // }
      }
    }
    if (ids.isNotEmpty) {
      return ids;
    }
  }
  return [];
}

class CacheDate {
  String id;
  String path;

  CacheDate(this.id, this.path);
}
