// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Music _$MusicFromJson(Map<String, dynamic> json) {
  return Music()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..size = json['size'] as int?
    ..extension = json['extension'] as String?
    ..sr = json['sr'] as int?
    ..dfsId = json['dfsId'] as int?
    ..bitrate = json['bitrate'] as int?
    ..playTime = json['playTime'] as int?
    ..volumeDelta = (json['volumeDelta'] as num?)?.toDouble();
}

Map<String, dynamic> _$MusicToJson(Music instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'size': instance.size,
      'extension': instance.extension,
      'sr': instance.sr,
      'dfsId': instance.dfsId,
      'bitrate': instance.bitrate,
      'playTime': instance.playTime,
      'volumeDelta': instance.volumeDelta,
    };

Music2 _$Music2FromJson(Map<String, dynamic> json) {
  return Music2()
    ..br = json['br'] as int?
    ..fid = json['fid'] as int?
    ..size = json['size'] as int?
    ..vd = (json['vd'] as num?)?.toDouble();
}

Map<String, dynamic> _$Music2ToJson(Music2 instance) => <String, dynamic>{
      'br': instance.br,
      'fid': instance.fid,
      'size': instance.size,
      'vd': instance.vd,
    };

Lyrics _$LyricsFromJson(Map<String, dynamic> json) {
  return Lyrics()..txt = json['txt'] as String?;
}

Map<String, dynamic> _$LyricsToJson(Lyrics instance) => <String, dynamic>{
      'txt': instance.txt,
    };

Lyrics2 _$Lyrics2FromJson(Map<String, dynamic> json) {
  return Lyrics2()
    ..lyric = json['lyric'] as String?
    ..version = json['version'] as int?;
}

Map<String, dynamic> _$Lyrics2ToJson(Lyrics2 instance) => <String, dynamic>{
      'lyric': instance.lyric,
      'version': instance.version,
    };

Privilege _$PrivilegeFromJson(Map<String, dynamic> json) {
  return Privilege()
    ..id = dynamicToString(json['id'])
    ..fee = json['fee'] as int?
    ..payed = json['payed'] as int?
    ..st = json['st'] as int?
    ..pl = json['pl'] as int?
    ..dl = json['dl'] as int?
    ..sp = json['sp'] as int?
    ..cp = json['cp'] as int?
    ..subp = json['subp'] as int?
    ..cs = json['cs'] as bool?
    ..maxbr = json['maxbr'] as int?
    ..fl = json['fl'] as int?
    ..toast = json['toast'] as bool?
    ..flag = json['flag'] as int?
    ..preSell = json['preSell'] as bool?;
}

Map<String, dynamic> _$PrivilegeToJson(Privilege instance) => <String, dynamic>{
      'id': instance.id,
      'fee': instance.fee,
      'payed': instance.payed,
      'st': instance.st,
      'pl': instance.pl,
      'dl': instance.dl,
      'sp': instance.sp,
      'cp': instance.cp,
      'subp': instance.subp,
      'cs': instance.cs,
      'maxbr': instance.maxbr,
      'fl': instance.fl,
      'toast': instance.toast,
      'flag': instance.flag,
      'preSell': instance.preSell,
    };

Song _$SongFromJson(Map<String, dynamic> json) {
  return Song()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..copyrightId = json['copyrightId'] as int?
    ..disc = json['disc'] as String?
    ..no = json['no'] as int?
    ..fee = json['fee'] as int?
    ..status = json['status'] as int?
    ..starred = json['starred'] as bool?
    ..starredNum = json['starredNum'] as int?
    ..popularity = (json['popularity'] as num?)?.toDouble()
    ..score = json['score'] as int?
    ..duration = json['duration'] as int?
    ..playedNum = json['playedNum'] as int?
    ..dayPlays = json['dayPlays'] as int?
    ..hearTime = json['hearTime'] as int?
    ..ringtone = json['ringtone'] as String?
    ..copyFrom = json['copyFrom'] as String?
    ..commentThreadId = json['commentThreadId'] as String?
    ..artists = (json['artists'] as List<dynamic>?)?.map((e) => Artists.fromJson(e as Map<String, dynamic>)).toList()
    ..album = json['album'] == null ? null : Album.fromJson(json['album'] as Map<String, dynamic>)
    ..lyrics = json['lyrics']
    ..privilege = json['privilege'] == null ? null : Privilege.fromJson(json['privilege'] as Map<String, dynamic>)
    ..copyright = json['copyright'] as int?
    ..transName = json['transName'] as String?
    ..mark = json['mark'] as int?
    ..rtype = json['rtype'] as int?
    ..mvid = json['mvid'] as int?
    ..alg = json['alg'] as String?
    ..reason = json['reason'] as String?
    ..hMusic = json['hMusic'] == null ? null : Music.fromJson(json['hMusic'] as Map<String, dynamic>)
    ..mMusic = json['mMusic'] == null ? null : Music.fromJson(json['mMusic'] as Map<String, dynamic>)
    ..lMusic = json['lMusic'] == null ? null : Music.fromJson(json['lMusic'] as Map<String, dynamic>)
    ..bMusic = json['bMusic'] == null ? null : Music.fromJson(json['bMusic'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'copyrightId': instance.copyrightId,
      'disc': instance.disc,
      'no': instance.no,
      'fee': instance.fee,
      'status': instance.status,
      'starred': instance.starred,
      'starredNum': instance.starredNum,
      'popularity': instance.popularity,
      'score': instance.score,
      'duration': instance.duration,
      'playedNum': instance.playedNum,
      'dayPlays': instance.dayPlays,
      'hearTime': instance.hearTime,
      'ringtone': instance.ringtone,
      'copyFrom': instance.copyFrom,
      'commentThreadId': instance.commentThreadId,
      'artists': instance.artists,
      'album': instance.album,
      'lyrics': instance.lyrics,
      'privilege': instance.privilege,
      'copyright': instance.copyright,
      'transName': instance.transName,
      'mark': instance.mark,
      'rtype': instance.rtype,
      'mvid': instance.mvid,
      'alg': instance.alg,
      'reason': instance.reason,
      'hMusic': instance.hMusic,
      'mMusic': instance.mMusic,
      'lMusic': instance.lMusic,
      'bMusic': instance.bMusic,
    };

Song2 _$Song2FromJson(Map<String, dynamic> json) {
  return Song2()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..pst = json['pst'] as int?
    ..t = json['t'] as int?
    ..ar = (json['ar'] as List<dynamic>?)?.map((e) => Artists.fromJson(e as Map<String, dynamic>)).toList()
    ..pop = (json['pop'] as num?)?.toDouble()
    ..st = json['st'] as int?
    ..rt = json['rt'] as String?
    ..fee = json['fee'] as int?
    ..v = json['v'] as int?
    ..cf = json['cf'] as String?
    ..al = json['al']!=null?Album.fromJson(json['al'] as Map<String, dynamic>):null
    ..dt = json['dt'] as int?
    ..h = json['h'] == null ? null : Music2.fromJson(json['h'] as Map<String, dynamic>)
    ..m = json['m'] == null ? null : Music2.fromJson(json['m'] as Map<String, dynamic>)
    ..l = json['l'] == null ? null : Music2.fromJson(json['l'] as Map<String, dynamic>)
    ..a = json['a'] == null ? null : Music2.fromJson(json['a'] as Map<String, dynamic>)
    ..mark = json['mark'] as int?
    ..mv = json['mv'] as int?
    ..rtype = json['rtype'] as int?
    ..mst = json['mst'] as int?
    ..cp = json['cp'] as int?
    ..publishTime = json['publishTime'] as int?
    ..reason = json['reason'] as String?
    ..privilege = json['privilege'] == null ? null : Privilege.fromJson(json['privilege'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Song2ToJson(Song2 instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pst': instance.pst,
      't': instance.t,
      'ar': instance.ar,
      'pop': instance.pop,
      'st': instance.st,
      'rt': instance.rt,
      'fee': instance.fee,
      'v': instance.v,
      'cf': instance.cf,
      'al': instance.al,
      'dt': instance.dt,
      'h': instance.h,
      'm': instance.m,
      'l': instance.l,
      'a': instance.a,
      'mark': instance.mark,
      'mv': instance.mv,
      'rtype': instance.rtype,
      'mst': instance.mst,
      'cp': instance.cp,
      'publishTime': instance.publishTime,
      'reason': instance.reason,
      'privilege': instance.privilege,
    };

SongDetailWrap _$SongDetailWrapFromJson(Map<String, dynamic> json) {
  return SongDetailWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..songs = (json['songs'] as List<dynamic>?)?.map((e) => Song2.fromJson(e as Map<String, dynamic>)).toList()
    ..privileges = (json['privileges'] as List<dynamic>?)?.map((e) => Privilege.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$SongDetailWrapToJson(SongDetailWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'songs': instance.songs,
      'privileges': instance.privileges,
    };

SongUrl _$SongUrlFromJson(Map<String, dynamic> json) {
  return SongUrl()
    ..id = dynamicToString(json['id'])
    ..url = json['url'] as String?
    ..br = json['br'] as int?
    ..size = json['size'] as int?
    ..code = json['code'] as int?
    ..expi = json['expi'] as int?
    ..gain = (json['gain'] as num?)?.toDouble()
    ..fee = json['fee'] as int?
    ..payed = json['payed'] as int?
    ..flag = json['flag'] as int?
    ..canExtend = json['canExtend'] as bool?
    ..md5 = json['md5'] as String?;
}

Map<String, dynamic> _$SongUrlToJson(SongUrl instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'br': instance.br,
      'size': instance.size,
      'code': instance.code,
      'expi': instance.expi,
      'gain': instance.gain,
      'fee': instance.fee,
      'payed': instance.payed,
      'flag': instance.flag,
      'canExtend': instance.canExtend,
      'md5': instance.md5,
    };

SongUrlListWrap _$SongUrlListWrapFromJson(Map<String, dynamic> json) {
  return SongUrlListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = (json['data'] as List<dynamic>?)?.map((e) => SongUrl.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$SongUrlListWrapToJson(SongUrlListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

SongLyricWrap _$SongLyricWrapFromJson(Map<String, dynamic> json) {
  return SongLyricWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..sgc = json['sgc'] as bool?
    ..sfy = json['sfy'] as bool?
    ..qfy = json['qfy'] as bool?
    ..lrc = Lyrics2.fromJson(json['lrc'] as Map<String, dynamic>)
    ..klyric = Lyrics2.fromJson(json['klyric']??<String, dynamic>{})
    ..tlyric = Lyrics2.fromJson(json['tlyric']??<String, dynamic>{});
}

Map<String, dynamic> _$SongLyricWrapToJson(SongLyricWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'sgc': instance.sgc,
      'sfy': instance.sfy,
      'qfy': instance.qfy,
      'lrc': instance.lrc,
      'klyric': instance.klyric,
      'tlyric': instance.tlyric,
    };

SongListWrap _$SongListWrapFromJson(Map<String, dynamic> json) {
  return SongListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..songs = (json['songs'] as List<dynamic>?)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$SongListWrapToJson(SongListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'songs': instance.songs,
    };

SongListWrap2 _$SongListWrap2FromJson(Map<String, dynamic> json) {
  return SongListWrap2()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = (json['data'] as List<dynamic>?)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$SongListWrap2ToJson(SongListWrap2 instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

PersonalizedSongItem _$PersonalizedSongItemFromJson(Map<String, dynamic> json) {
  return PersonalizedSongItem()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..picUrl = json['picUrl'] as String?
    ..copywriter = json['copywriter'] as String?
    ..canDislike = json['canDislike'] as bool?
    ..alg = json['alg'] as String?
    ..type = json['type'] as int?
    ..song = Song.fromJson(json['song'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PersonalizedSongItemToJson(PersonalizedSongItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'copywriter': instance.copywriter,
      'canDislike': instance.canDislike,
      'alg': instance.alg,
      'type': instance.type,
      'song': instance.song,
    };

PersonalizedSongListWrap _$PersonalizedSongListWrapFromJson(Map<String, dynamic> json) {
  return PersonalizedSongListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..result = (json['result'] as List<dynamic>?)?.map((e) => PersonalizedSongItem.fromJson(e as Map<String, dynamic>)).toList()
    ..category = json['category'] as int?;
}

Map<String, dynamic> _$PersonalizedSongListWrapToJson(PersonalizedSongListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
      'category': instance.category,
    };

LikeSongListWrap _$LikeSongListWrapFromJson(Map<String, dynamic> json) {
  return LikeSongListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..checkPoint = json['checkPoint'] as int?
    ..ids = (json['ids'] as List<dynamic>).map((e) => e as int).toList();
}

Map<String, dynamic> _$LikeSongListWrapToJson(LikeSongListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'checkPoint': instance.checkPoint,
      'ids': instance.ids,
    };

CloudSongItem _$CloudSongItemFromJson(Map<String, dynamic> json) {
  return CloudSongItem()
    ..simpleSong = Song2.fromJson(json['simpleSong'] as Map<String, dynamic>)
    ..songId = dynamicToString(json['songId'])
    ..songName = json['songName'] as String?
    ..fileName = json['fileName'] as String?
    ..cover = json['cover'] as int?
    ..fileSize = json['fileSize'] as int?
    ..addTime = json['addTime'] as int
    ..version = json['version'] as int?
    ..coverId = json['coverId'] as String?
    ..lyricId = json['lyricId'] as String?
    ..album = json['album'] as String?
    ..artist = json['artist'] as String?
    ..bitrate = json['bitrate'] as int?;
}

Map<String, dynamic> _$CloudSongItemToJson(CloudSongItem instance) => <String, dynamic>{
      'simpleSong': instance.simpleSong,
      'songId': instance.songId,
      'songName': instance.songName,
      'fileName': instance.fileName,
      'cover': instance.cover,
      'fileSize': instance.fileSize,
      'addTime': instance.addTime,
      'version': instance.version,
      'coverId': instance.coverId,
      'lyricId': instance.lyricId,
      'album': instance.album,
      'artist': instance.artist,
      'bitrate': instance.bitrate,
    };

CloudSongListWrap _$CloudSongListWrapFromJson(Map<String, dynamic> json) {
  return CloudSongListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..size = json['size'] as String?
    ..maxSize = json['maxSize'] as String?
    ..upgradeSign = json['upgradeSign'] as int?
    ..data = (json['data'] as List<dynamic>?)?.map((e) => CloudSongItem.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$CloudSongListWrapToJson(CloudSongListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'size': instance.size,
      'maxSize': instance.maxSize,
      'upgradeSign': instance.upgradeSign,
      'data': instance.data,
    };

RecommendSongReason _$RecommendSongReasonFromJson(Map<String, dynamic> json) {
  return RecommendSongReason()
    ..songId = dynamicToString(json['songId'])
    ..reason = json['reason'] as String?;
}

Map<String, dynamic> _$RecommendSongReasonToJson(RecommendSongReason instance) => <String, dynamic>{
      'songId': instance.songId,
      'reason': instance.reason,
    };

RecommendSongListWrap _$RecommendSongListWrapFromJson(Map<String, dynamic> json) {
  return RecommendSongListWrap()
    ..dailySongs = (json['dailySongs'] as List<dynamic>?)?.map((e) => Song2.fromJson(e as Map<String, dynamic>)).toList()
    ..orderSongs = (json['orderSongs'] as List<dynamic>?)?.map((e) => Song2.fromJson(e as Map<String, dynamic>)).toList()
    ..recommendReasons = (json['recommendReasons'] as List<dynamic>?)?.map((e) => RecommendSongReason.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$RecommendSongListWrapToJson(RecommendSongListWrap instance) => <String, dynamic>{
      'dailySongs': instance.dailySongs,
      'orderSongs': instance.orderSongs,
      'recommendReasons': instance.recommendReasons,
    };

RecommendSongListWrapX _$RecommendSongListWrapXFromJson(Map<String, dynamic> json) {
  return RecommendSongListWrapX()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = RecommendSongListWrap.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RecommendSongListWrapXToJson(RecommendSongListWrapX instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

RecommendSongListHistoryWrap _$RecommendSongListHistoryWrapFromJson(Map<String, dynamic> json) {
  return RecommendSongListHistoryWrap()
    ..dates = (json['dates'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..purchaseUrl = json['purchaseUrl'] as String?
    ..description = json['description'] as String?
    ..noHistoryMessage = json['noHistoryMessage'] as String?
    ..songs = (json['songs'] as List<dynamic>?)?.map((e) => Song2.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$RecommendSongListHistoryWrapToJson(RecommendSongListHistoryWrap instance) => <String, dynamic>{
      'dates': instance.dates,
      'purchaseUrl': instance.purchaseUrl,
      'description': instance.description,
      'noHistoryMessage': instance.noHistoryMessage,
      'songs': instance.songs,
    };

RecommendSongListHistoryWrapX _$RecommendSongListHistoryWrapXFromJson(Map<String, dynamic> json) {
  return RecommendSongListHistoryWrapX()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = RecommendSongListHistoryWrap.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RecommendSongListHistoryWrapXToJson(RecommendSongListHistoryWrapX instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

ArtistSongListWrap _$ArtistSongListWrapFromJson(Map<String, dynamic> json) {
  return ArtistSongListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..songs = (json['songs'] as List<dynamic>?)?.map((e) => Song2.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$ArtistSongListWrapToJson(ArtistSongListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'songs': instance.songs,
    };

ArtistNewSongListData _$ArtistNewSongListDataFromJson(Map<String, dynamic> json) {
  return ArtistNewSongListData()
    ..hasMore = json['hasMore'] as bool?
    ..newSongCount = json['newSongCount'] as int?
    ..newWorks = (json['newWorks'] as List<dynamic>?)?.map((e) => Song2.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$ArtistNewSongListDataToJson(ArtistNewSongListData instance) => <String, dynamic>{
      'hasMore': instance.hasMore,
      'newSongCount': instance.newSongCount,
      'newWorks': instance.newWorks,
    };

ArtistNewSongListWrap _$ArtistNewSongListWrapFromJson(Map<String, dynamic> json) {
  return ArtistNewSongListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = ArtistNewSongListData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArtistNewSongListWrapToJson(ArtistNewSongListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

ArtistDetailAndSongListWrap _$ArtistDetailAndSongListWrapFromJson(Map<String, dynamic> json) {
  return ArtistDetailAndSongListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..hotSongs = (json['hotSongs'] as List<dynamic>?)?.map((e) => Song2.fromJson(e as Map<String, dynamic>)).toList()
    ..artist = Artists.fromJson(json['artist'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArtistDetailAndSongListWrapToJson(ArtistDetailAndSongListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'hotSongs': instance.hotSongs,
      'artist': instance.artist,
    };

Play _$PlayFromJson(Map<String, dynamic> json) {
  return Play()
    ..id = dynamicToString(json['id'])
    ..userId = dynamicToString(json['userId'])
    ..name = json['name'] as String?
    ..description = json['description'] as String?
    ..coverImgUrl = json['coverImgUrl'] as String?
    ..picUrl = json['picUrl'] as String?
    ..tag = json['tag'] as String?
    ..subscribed = json['subscribed'] as bool?
    ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..copywriter = json['copywriter'] as String?
    ..createTime = json['createTime'] as int?
    ..updateTime = json['updateTime'] as int?
    ..playCount = dynamicToInt(json['playCount'])
    ..subscribedCount = json['subscribedCount'] as int?
    ..shareCount = json['shareCount'] as int?
    ..commentCount = json['commentCount'] as int?
    ..trackCount = json['trackCount'] as int?
    ..trackNumberUpdateTime = json['trackNumberUpdateTime'] as int?
    ..commentThreadId = json['commentThreadId'] as String?
    ..alg = json['alg'] as String?
    ..specialType = json['specialType'] as int?
    ..creator = json['creator'] == null ? null : NeteaseUserInfo.fromJson(json['creator'] as Map<String, dynamic>)
    ..subscribers = (json['subscribers'] as List<dynamic>?)?.map((e) => NeteaseUserInfo.fromJson(e as Map<String, dynamic>)).toList()
    ..tracks = (json['tracks'] as List<dynamic>?)?.map((e) => PlayTrack.fromJson(e as Map<String, dynamic>)).toList()
    ..trackIds = (json['trackIds'] as List<dynamic>?)?.map((e) => PlayTrackId.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$PlayToJson(Play instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'coverImgUrl': instance.coverImgUrl,
      'picUrl': instance.picUrl,
      'tag': instance.tag,
      'tags': instance.tags,
      'subscribed':instance.subscribed,
      'copywriter': instance.copywriter,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'playCount': instance.playCount,
      'subscribedCount': instance.subscribedCount,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
      'trackCount': instance.trackCount,
      'trackNumberUpdateTime': instance.trackNumberUpdateTime,
      'commentThreadId': instance.commentThreadId,
      'alg': instance.alg,
      'specialType': instance.specialType,
      'creator': instance.creator,
      'subscribers': instance.subscribers,
      'tracks': instance.tracks,
      'trackIds': instance.trackIds,
    };

PlayTrack _$PlayTrackFromJson(Map<String, dynamic> json) {
  return PlayTrack()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..pst = json['pst'] as int?
    ..t = json['t'] as int?
    ..ar = (json['ar'] as List<dynamic>?)?.map((e) => Artists.fromJson(e as Map<String, dynamic>)).toList()
    ..pop = (json['pop'] as num?)?.toDouble()
    ..st = json['st'] as int?
    ..rt = json['rt'] as String?
    ..fee = json['fee'] as int?
    ..v = json['v'] as int?
    ..cf = json['cf'] as String?
    ..al = Album.fromJson(json['al'] as Map<String, dynamic>)
    ..dt = json['dt'] as int?
    ..h = json['h'] == null ? null : Music2.fromJson(json['h'] as Map<String, dynamic>)
    ..m = json['m'] == null ? null : Music2.fromJson(json['m'] as Map<String, dynamic>)
    ..l = json['l'] == null ? null : Music2.fromJson(json['l'] as Map<String, dynamic>)
    ..a = json['a'] == null ? null : Music2.fromJson(json['a'] as Map<String, dynamic>)
    ..cd = json['cd'] as String?
    ..no = json['no'] as int?
    ..ftype = json['ftype'] as int?
    ..rtUrls = json['rtUrls'] as List<dynamic>?
    ..djId = json['djId'] as int?
    ..copyright = json['copyright'] as int?
    ..s_id = json['s_id'] as int?
    ..mark = json['mark'] as int?
    ..originCoverType = json['originCoverType'] as int?
    ..single = json['single'] as int?
    ..rtype = json['rtype'] as int?
    ..mst = json['mst'] as int?
    ..cp = json['cp'] as int?
    ..mv = json['mv'] as int?
    ..publishTime = json['publishTime'] as int?;
}

Map<String, dynamic> _$PlayTrackToJson(PlayTrack instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pst': instance.pst,
      't': instance.t,
      'ar': instance.ar,
      'pop': instance.pop,
      'st': instance.st,
      'rt': instance.rt,
      'fee': instance.fee,
      'v': instance.v,
      'cf': instance.cf,
      'al': instance.al,
      'dt': instance.dt,
      'h': instance.h,
      'm': instance.m,
      'l': instance.l,
      'a': instance.a,
      'cd': instance.cd,
      'no': instance.no,
      'ftype': instance.ftype,
      'rtUrls': instance.rtUrls,
      'djId': instance.djId,
      'copyright': instance.copyright,
      's_id': instance.s_id,
      'mark': instance.mark,
      'originCoverType': instance.originCoverType,
      'single': instance.single,
      'rtype': instance.rtype,
      'mst': instance.mst,
      'cp': instance.cp,
      'mv': instance.mv,
      'publishTime': instance.publishTime,
    };

PlayTrackId _$PlayTrackIdFromJson(Map<String, dynamic> json) {
  return PlayTrackId()
    ..id = dynamicToString(json['id'])
    ..v = json['v'] as int?
    ..t = json['t'] as int?
    ..at = json['at'] as int?
    ..lr = json['lr'] as int?;
}

Map<String, dynamic> _$PlayTrackIdToJson(PlayTrackId instance) => <String, dynamic>{
      'id': instance.id,
      'v': instance.v,
      't': instance.t,
      'at': instance.at,
      'lr': instance.lr,
    };

MultiPlayListWrap _$MultiPlayListWrapFromJson(Map<String, dynamic> json) {
  return MultiPlayListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..playlists = (json['playlists'] as List<dynamic>?)?.map((e) => Play.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$MultiPlayListWrapToJson(MultiPlayListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'playlists': instance.playlists,
    };

MultiPlayListWrap2 _$MultiPlayListWrap2FromJson(Map<String, dynamic> json) {
  return MultiPlayListWrap2()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..playlist = (json['playlist'] as List<dynamic>?)?.map((e) => Play.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$MultiPlayListWrap2ToJson(MultiPlayListWrap2 instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'playlist': instance.playlist,
    };

RecommendPlayListWrap _$RecommendPlayListWrapFromJson(Map<String, dynamic> json) {
  return RecommendPlayListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..recommend = (json['recommend'] as List<dynamic>?)?.map((e) => Play.fromJson(e as Map<String, dynamic>)).toList()
    ..featureFirst = json['featureFirst'] as bool?
    ..haveRcmdSongs = json['haveRcmdSongs'] as bool?;
}

Map<String, dynamic> _$RecommendPlayListWrapToJson(RecommendPlayListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'recommend': instance.recommend,
      'featureFirst': instance.featureFirst,
      'haveRcmdSongs': instance.haveRcmdSongs,
    };

PersonalizedPlayListWrap _$PersonalizedPlayListWrapFromJson(Map<String, dynamic> json) {
  return PersonalizedPlayListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..result = (json['result'] as List<dynamic>?)?.map((e) => Play.fromJson(e as Map<String, dynamic>)).toList()
    ..hasTaste = json['hasTaste'] as bool?
    ..category = json['category'] as int?;
}

Map<String, dynamic> _$PersonalizedPlayListWrapToJson(PersonalizedPlayListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
      'hasTaste': instance.hasTaste,
      'category': instance.category,
    };

PlaylistCatalogueItem _$PlaylistCatalogueItemFromJson(Map<String, dynamic> json) {
  return PlaylistCatalogueItem()
    ..name = json['name'] as String?
    ..resourceCount = json['resourceCount'] as int?
    ..imgUrl = json['imgUrl'] as String?
    ..type = json['type'] as int?
    ..category = json['category'] as int?
    ..resourceType = json['resourceType'] as int?
    ..hot = json['hot'] as bool?
    ..activity = json['activity'] as bool?;
}

Map<String, dynamic> _$PlaylistCatalogueItemToJson(PlaylistCatalogueItem instance) => <String, dynamic>{
      'name': instance.name,
      'resourceCount': instance.resourceCount,
      'imgUrl': instance.imgUrl,
      'type': instance.type,
      'category': instance.category,
      'resourceType': instance.resourceType,
      'hot': instance.hot,
      'activity': instance.activity,
    };

PlaylistCatalogueWrap _$PlaylistCatalogueWrapFromJson(Map<String, dynamic> json) {
  return PlaylistCatalogueWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..all = json['all'] == null ? null : PlaylistCatalogueItem.fromJson(json['all'] as Map<String, dynamic>)
    ..sub = (json['sub'] as List<dynamic>?)?.map((e) => PlaylistCatalogueItem.fromJson(e as Map<String, dynamic>)).toList()
    ..categories = (json['categories'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(int.parse(k), e as String),
    );
}

Map<String, dynamic> _$PlaylistCatalogueWrapToJson(PlaylistCatalogueWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'all': instance.all,
      'sub': instance.sub,
      'categories': instance.categories?.map((k, e) => MapEntry(k.toString(), e)),
    };

PlaylistHotTag _$PlaylistHotTagFromJson(Map<String, dynamic> json) {
  return PlaylistHotTag()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..category = json['category'] as int?
    ..usedCount = json['usedCount'] as int?
    ..type = json['type'] as int?
    ..position = json['position'] as int?
    ..highQuality = json['highQuality'] as int?
    ..highQualityPos = json['highQualityPos'] as int?
    ..officialPos = json['officialPos'] as int?
    ..createTime = json['createTime'] as int?;
}

Map<String, dynamic> _$PlaylistHotTagToJson(PlaylistHotTag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'usedCount': instance.usedCount,
      'type': instance.type,
      'position': instance.position,
      'highQuality': instance.highQuality,
      'highQualityPos': instance.highQualityPos,
      'officialPos': instance.officialPos,
      'createTime': instance.createTime,
    };

PlaylistHotTagsItem _$PlaylistHotTagsItemFromJson(Map<String, dynamic> json) {
  return PlaylistHotTagsItem()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..activity = json['activity'] as bool?
    ..hot = json['hot'] as bool?
    ..position = json['position'] as int?
    ..category = json['category'] as int?
    ..createTime = json['createTime'] as int?
    ..type = json['type'] as int?
    ..playlistTag = json['playlistTag'] == null ? null : PlaylistHotTag.fromJson(json['playlistTag'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PlaylistHotTagsItemToJson(PlaylistHotTagsItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'activity': instance.activity,
      'hot': instance.hot,
      'position': instance.position,
      'category': instance.category,
      'createTime': instance.createTime,
      'type': instance.type,
      'playlistTag': instance.playlistTag,
    };

PlaylistHotTagsWrap _$PlaylistHotTagsWrapFromJson(Map<String, dynamic> json) {
  return PlaylistHotTagsWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..tags = (json['tags'] as List<dynamic>?)?.map((e) => PlaylistHotTagsItem.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$PlaylistHotTagsWrapToJson(PlaylistHotTagsWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'tags': instance.tags,
    };

SinglePlayListWrap _$SinglePlayListWrapFromJson(Map<String, dynamic> json) {
  return SinglePlayListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..playlist = json['playlist'] == null ? null : Play.fromJson(json['playlist'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SinglePlayListWrapToJson(SinglePlayListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'playlist': instance.playlist,
    };

PlayListDetailDynamicWrap _$PlayListDetailDynamicWrapFromJson(Map<String, dynamic> json) {
  return PlayListDetailDynamicWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..commentCount = json['commentCount'] as int?
    ..shareCount = json['shareCount'] as int?
    ..playCount = json['playCount'] as int?
    ..bookedCount = json['bookedCount'] as int?
    ..subscribed = json['subscribed'] as bool?
    ..remarkName = json['remarkName'] as String?
    ..followed = json['followed'] as bool?;
}

Map<String, dynamic> _$PlayListDetailDynamicWrapToJson(PlayListDetailDynamicWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'playCount': instance.playCount,
      'bookedCount': instance.bookedCount,
      'subscribed': instance.subscribed,
      'remarkName': instance.remarkName,
      'followed': instance.followed,
    };

PlaymodeIntelligenceItem _$PlaymodeIntelligenceItemFromJson(Map<String, dynamic> json) {
  return PlaymodeIntelligenceItem()
    ..id = dynamicToString(json['id'])
    ..recommended = json['recommended'] as bool?
    ..alg = json['alg'] as String?
    ..songInfo = json['songInfo'] == null ? null : Song.fromJson(json['songInfo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PlaymodeIntelligenceItemToJson(PlaymodeIntelligenceItem instance) => <String, dynamic>{
      'id': instance.id,
      'recommended': instance.recommended,
      'alg': instance.alg,
      'songInfo': instance.songInfo,
    };

PlaymodeIntelligenceListWrap _$PlaymodeIntelligenceListWrapFromJson(Map<String, dynamic> json) {
  return PlaymodeIntelligenceListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = (json['data'] as List<dynamic>?)?.map((e) => PlaymodeIntelligenceItem.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$PlaymodeIntelligenceListWrapToJson(PlaymodeIntelligenceListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

Artists _$ArtistsFromJson(Map<String, dynamic> json) {
  return Artists()
    ..id = dynamicToString(json['id'])
    ..accountId = dynamicToString(json['accountId'])
    ..name = json['name'] as String?
    ..picUrl = json['picUrl'] as String?
    ..img1v1Id = json['img1v1Id'] as int?
    ..img1v1Url = json['img1v1Url'] as String?
    ..cover = json['cover'] as String?
    ..albumSize = json['albumSize'] as int?
    ..musicSize = json['musicSize'] as int?
    ..mvSize = json['mvSize'] as int?
    ..topicPerson = json['topicPerson'] as int?
    ..trans = json['trans'] as String?
    ..briefDesc = json['briefDesc'] as String?
    ..followed = json['followed'] as bool?
    ..publishTime = json['publishTime'] as int?;
}

Map<String, dynamic> _$ArtistsToJson(Artists instance) => <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'img1v1Id': instance.img1v1Id,
      'img1v1Url': instance.img1v1Url,
      'cover': instance.cover,
      'albumSize': instance.albumSize,
      'musicSize': instance.musicSize,
      'mvSize': instance.mvSize,
      'topicPerson': instance.topicPerson,
      'trans': instance.trans,
      'briefDesc': instance.briefDesc,
      'followed': instance.followed,
      'publishTime': instance.publishTime,
    };

ArtistsListWrap _$ArtistsListWrapFromJson(Map<String, dynamic> json) {
  return ArtistsListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..artists = (json['artists'] as List<dynamic>?)?.map((e) => Artists.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$ArtistsListWrapToJson(ArtistsListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'artists': instance.artists,
    };

ArtistsTopListWrap _$ArtistsTopListWrapFromJson(Map<String, dynamic> json) {
  return ArtistsTopListWrap()
    ..artists = (json['artists'] as List<dynamic>?)?.map((e) => Artists.fromJson(e as Map<String, dynamic>)).toList()
    ..type = json['type'] as int?
    ..updateTime = json['updateTime'] as int?;
}

Map<String, dynamic> _$ArtistsTopListWrapToJson(ArtistsTopListWrap instance) => <String, dynamic>{
      'artists': instance.artists,
      'type': instance.type,
      'updateTime': instance.updateTime,
    };

ArtistsTopListWrapX _$ArtistsTopListWrapXFromJson(Map<String, dynamic> json) {
  return ArtistsTopListWrapX()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..list = json['list'] == null ? null : ArtistsTopListWrap.fromJson(json['list'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArtistsTopListWrapXToJson(ArtistsTopListWrapX instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'list': instance.list,
    };

ArtistIntroduction _$ArtistIntroductionFromJson(Map<String, dynamic> json) {
  return ArtistIntroduction()
    ..ti = json['ti'] as String?
    ..txt = json['txt'] as String?;
}

Map<String, dynamic> _$ArtistIntroductionToJson(ArtistIntroduction instance) => <String, dynamic>{
      'ti': instance.ti,
      'txt': instance.txt,
    };

ArtistDescWrap _$ArtistDescWrapFromJson(Map<String, dynamic> json) {
  return ArtistDescWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..introduction = (json['introduction'] as List<dynamic>?)?.map((e) => ArtistIntroduction.fromJson(e as Map<String, dynamic>)).toList()
    ..briefDesc = json['briefDesc'] as String?
    ..count = json['count'] as int?
    ..topicData = (json['topicData'] as List<dynamic>?)?.map((e) => TopicItem2.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$ArtistDescWrapToJson(ArtistDescWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'introduction': instance.introduction,
      'briefDesc': instance.briefDesc,
      'count': instance.count,
      'topicData': instance.topicData,
    };

ArtistDetailData _$ArtistDetailDataFromJson(Map<String, dynamic> json) {
  return ArtistDetailData()
    ..blacklist = json['blacklist'] as bool?
    ..showPriMsg = json['showPriMsg'] as bool?
    ..videoCount = json['videoCount'] as int?
    ..artist = json['artist'] == null ? null : Artists.fromJson(json['artist'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArtistDetailDataToJson(ArtistDetailData instance) => <String, dynamic>{
      'blacklist': instance.blacklist,
      'showPriMsg': instance.showPriMsg,
      'videoCount': instance.videoCount,
      'artist': instance.artist,
    };

ArtistDetailWrap _$ArtistDetailWrapFromJson(Map<String, dynamic> json) {
  return ArtistDetailWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = json['data'] == null ? null : ArtistDetailData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArtistDetailWrapToJson(ArtistDetailWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return Album()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..type = json['type'] as String?
    ..subType = json['subType'] as String?
    ..mark = json['mark'] as int?
    ..size = json['size'] as int?
    ..publishTime = json['publishTime'] as int?
    ..picUrl = json['picUrl'] as String?
    ..tags = json['tags'] as String?
    ..copyrightId = json['copyrightId'] as int?
    ..companyId = json['companyId'] as int?
    ..company = json['company'] as String?
    ..description = json['description'] as String?
    ..briefDesc = json['briefDesc'] as String?
    ..artist = json['artist'] == null ? null : Artists.fromJson(json['artist'] as Map<String, dynamic>)
    ..artists = (json['artists'] as List<dynamic>?)?.map((e) => Artists.fromJson(e as Map<String, dynamic>)).toList()
    ..isSub = json['isSub'] as bool?
    ..paid = json['paid'] as bool?
    ..onSale = json['onSale'] as bool?;
}

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'subType': instance.subType,
      'mark': instance.mark,
      'size': instance.size,
      'publishTime': instance.publishTime,
      'picUrl': instance.picUrl,
      'tags': instance.tags,
      'copyrightId': instance.copyrightId,
      'companyId': instance.companyId,
      'company': instance.company,
      'description': instance.description,
      'briefDesc': instance.briefDesc,
      'artist': instance.artist,
      'artists': instance.artists,
      'isSub': instance.isSub,
      'paid': instance.paid,
      'onSale': instance.onSale,
    };

AlbumDetailWrap _$AlbumDetailWrapFromJson(Map<String, dynamic> json) {
  return AlbumDetailWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..songs = (json['songs'] as List<dynamic>?)?.map((e) => Song2.fromJson(e as Map<String, dynamic>)).toList()
    ..album = json['album'] == null ? null : Album.fromJson(json['album'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AlbumDetailWrapToJson(AlbumDetailWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'songs': instance.songs,
      'album': instance.album,
    };

AlbumDetailDynamicWrap _$AlbumDetailDynamicWrapFromJson(Map<String, dynamic> json) {
  return AlbumDetailDynamicWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..onSale = json['onSale'] as bool?
    ..isSub = json['isSub'] as bool?
    ..subTime = json['subTime'] as int?
    ..commentCount = json['commentCount'] as int?
    ..likedCount = json['likedCount'] as int?
    ..shareCount = json['shareCount'] as int?
    ..subCount = json['subCount'] as int?;
}

Map<String, dynamic> _$AlbumDetailDynamicWrapToJson(AlbumDetailDynamicWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'onSale': instance.onSale,
      'isSub': instance.isSub,
      'subTime': instance.subTime,
      'commentCount': instance.commentCount,
      'likedCount': instance.likedCount,
      'shareCount': instance.shareCount,
      'subCount': instance.subCount,
    };

AlbumListWrap _$AlbumListWrapFromJson(Map<String, dynamic> json) {
  return AlbumListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..albums = (json['albums'] as List<dynamic>?)?.map((e) => Album.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$AlbumListWrapToJson(AlbumListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'albums': instance.albums,
    };

ArtistAlbumListWrap _$ArtistAlbumListWrapFromJson(Map<String, dynamic> json) {
  return ArtistAlbumListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..time = json['time'] as int?
    ..hotAlbums = (json['hotAlbums'] as List<dynamic>?)?.map((e) => Album.fromJson(e as Map<String, dynamic>)).toList()
    ..artist = Artists.fromJson(json['artist'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArtistAlbumListWrapToJson(ArtistAlbumListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'time': instance.time,
      'hotAlbums': instance.hotAlbums,
      'artist': instance.artist,
    };

MvCreator _$MvCreatorFromJson(Map<String, dynamic> json) {
  return MvCreator()
    ..userId = dynamicToString(json['userId'])
    ..userName = json['userName'] as String?;
}

Map<String, dynamic> _$MvCreatorToJson(MvCreator instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
    };

Mv _$MvFromJson(Map<String, dynamic> json) {
  return Mv()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..cover = json['cover'] as String?
    ..playCount = json['playCount'] as int?
    ..briefDesc = json['briefDesc'] as String?
    ..desc = json['desc'] as String?
    ..arTransName = json['arTransName'] as String?
    ..artisAlias = json['artisAlias'] as String?
    ..artisTransName = json['artisTransName'] as String?
    ..artistName = json['artistName'] as String?
    ..artistImgUrl = json['artistImgUrl'] as String?
    ..artistId = json['artistId'] as int?
    ..mvId = json['mvId'] as int?
    ..mvName = json['mvName'] as String?
    ..mvCoverUrl = json['mvCoverUrl'] as String?
    ..duration = json['duration'] as int?
    ..publishTime = dynamicToString(json['publishTime'])
    ..publishDate = json['publishDate'] as String?
    ..mark = json['mark'] as int?
    ..alg = json['alg'] as String?
    ..artists = (json['artists'] as List<dynamic>?)?.map((e) => Artists.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$MvToJson(Mv instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cover': instance.cover,
      'playCount': instance.playCount,
      'briefDesc': instance.briefDesc,
      'desc': instance.desc,
      'arTransName': instance.arTransName,
      'artisAlias': instance.artisAlias,
      'artisTransName': instance.artisTransName,
      'artistName': instance.artistName,
      'artistImgUrl': instance.artistImgUrl,
      'artistId': instance.artistId,
      'mvId': instance.mvId,
      'mvName': instance.mvName,
      'mvCoverUrl': instance.mvCoverUrl,
      'duration': instance.duration,
      'publishTime': instance.publishTime,
      'publishDate': instance.publishDate,
      'mark': instance.mark,
      'alg': instance.alg,
      'artists': instance.artists,
    };

Mv2 _$Mv2FromJson(Map<String, dynamic> json) {
  return Mv2()
    ..type = json['type'] as int?
    ..title = json['title'] as String?
    ..durationms = json['durationms'] as int?
    ..playTime = json['playTime'] as int?
    ..vid = json['vid'] as String?
    ..coverUrl = json['coverUrl'] as String?
    ..aliaName = json['aliaName'] as String?
    ..transName = json['transName'] as String?
    ..creator = (json['creator'] as List<dynamic>?)?.map((e) => MvCreator.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$Mv2ToJson(Mv2 instance) => <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'durationms': instance.durationms,
      'playTime': instance.playTime,
      'vid': instance.vid,
      'coverUrl': instance.coverUrl,
      'aliaName': instance.aliaName,
      'transName': instance.transName,
      'creator': instance.creator,
    };

Mv3 _$Mv3FromJson(Map<String, dynamic> json) {
  return Mv3()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..artistName = json['artistName'] as String?
    ..imgurl = json['imgurl'] as String
    ..imgurl16v9 = json['imgurl16v9'] as String
    ..status = json['status'] as int?
    ..artist = Artists.fromJson(json['artist'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Mv3ToJson(Mv3 instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artistName': instance.artistName,
      'imgurl': instance.imgurl,
      'imgurl16v9': instance.imgurl16v9,
      'status': instance.status,
      'artist': instance.artist,
    };

MvListWrap _$MvListWrapFromJson(Map<String, dynamic> json) {
  return MvListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..mvs = (json['mvs'] as List<dynamic>?)?.map((e) => Mv.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$MvListWrapToJson(MvListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'mvs': instance.mvs,
    };

MvListWrap2 _$MvListWrap2FromJson(Map<String, dynamic> json) {
  return MvListWrap2()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..data = (json['data'] as List<dynamic>?)?.map((e) => Mv.fromJson(e as Map<String, dynamic>)).toList()
    ..updateTime = json['updateTime'] as int?;
}

Map<String, dynamic> _$MvListWrap2ToJson(MvListWrap2 instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'data': instance.data,
      'updateTime': instance.updateTime,
    };

PersonalizedMvListWrap _$PersonalizedMvListWrapFromJson(Map<String, dynamic> json) {
  return PersonalizedMvListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..result = (json['result'] as List<dynamic>?)?.map((e) => Mv.fromJson(e as Map<String, dynamic>)).toList()
    ..category = json['category'] as int?;
}

Map<String, dynamic> _$PersonalizedMvListWrapToJson(PersonalizedMvListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
      'category': instance.category,
    };

ArtistMvListWrap _$ArtistMvListWrapFromJson(Map<String, dynamic> json) {
  return ArtistMvListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..mvs = (json['mvs'] as List<dynamic>?)?.map((e) => Mv.fromJson(e as Map<String, dynamic>)).toList()
    ..time = json['time'] as int?;
}

Map<String, dynamic> _$ArtistMvListWrapToJson(ArtistMvListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'mvs': instance.mvs,
      'time': instance.time,
    };

ArtistNewMvListData _$ArtistNewMvListDataFromJson(Map<String, dynamic> json) {
  return ArtistNewMvListData()
    ..hasMore = json['hasMore'] as bool?
    ..newWorks = (json['newWorks'] as List<dynamic>?)?.map((e) => Mv.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$ArtistNewMvListDataToJson(ArtistNewMvListData instance) => <String, dynamic>{
      'hasMore': instance.hasMore,
      'newWorks': instance.newWorks,
    };

ArtistNewMvListWrap _$ArtistNewMvListWrapFromJson(Map<String, dynamic> json) {
  return ArtistNewMvListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = ArtistNewMvListData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArtistNewMvListWrapToJson(ArtistNewMvListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

MvDetailWrap _$MvDetailWrapFromJson(Map<String, dynamic> json) {
  return MvDetailWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..loadingPic = json['loadingPic'] as String?
    ..bufferPic = json['bufferPic'] as String?
    ..loadingPicFS = json['loadingPicFS'] as String?
    ..bufferPicFS = json['bufferPicFS'] as String?
    ..subed = json['subed'] as bool?
    ..data = json['data'] == null ? null : Mv.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MvDetailWrapToJson(MvDetailWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'loadingPic': instance.loadingPic,
      'bufferPic': instance.bufferPic,
      'loadingPicFS': instance.loadingPicFS,
      'bufferPicFS': instance.bufferPicFS,
      'subed': instance.subed,
      'data': instance.data,
    };

MvDetailInfoWrap _$MvDetailInfoWrapFromJson(Map<String, dynamic> json) {
  return MvDetailInfoWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..likedCount = json['likedCount'] as int?
    ..shareCount = json['shareCount'] as int?
    ..commentCount = json['commentCount'] as int?
    ..liked = json['liked'] as bool?;
}

Map<String, dynamic> _$MvDetailInfoWrapToJson(MvDetailInfoWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'likedCount': instance.likedCount,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
      'liked': instance.liked,
    };

MvUrl _$MvUrlFromJson(Map<String, dynamic> json) {
  return MvUrl()
    ..id = dynamicToString(json['id'])
    ..url = json['url'] as String?
    ..md5 = json['md5'] as String?
    ..msg = json['msg'] as String?
    ..r = json['r'] as int?
    ..size = json['size'] as int?
    ..expi = json['expi'] as int?
    ..fee = json['fee'] as int?
    ..mvFee = json['mvFee'] as int?
    ..st = json['st'] as int?;
}

Map<String, dynamic> _$MvUrlToJson(MvUrl instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'md5': instance.md5,
      'msg': instance.msg,
      'r': instance.r,
      'size': instance.size,
      'expi': instance.expi,
      'fee': instance.fee,
      'mvFee': instance.mvFee,
      'st': instance.st,
    };

MvUrlWrap _$MvUrlWrapFromJson(Map<String, dynamic> json) {
  return MvUrlWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = MvUrl.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MvUrlWrapToJson(MvUrlWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

VideoResolution _$VideoResolutionFromJson(Map<String, dynamic> json) {
  return VideoResolution()
    ..resolution = json['resolution'] as int?
    ..size = json['size'] as int?;
}

Map<String, dynamic> _$VideoResolutionToJson(VideoResolution instance) => <String, dynamic>{
      'resolution': instance.resolution,
      'size': instance.size,
    };

VideoUrlInfo _$VideoUrlInfoFromJson(Map<String, dynamic> json) {
  return VideoUrlInfo()
    ..id = json['id'] as String
    ..url = json['url'] as String?
    ..size = json['size'] as int?
    ..validityTime = json['validityTime'] as int?
    ..needPay = json['needPay'] as bool?
    ..r = json['r'] as int?;
}

Map<String, dynamic> _$VideoUrlInfoToJson(VideoUrlInfo instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'size': instance.size,
      'validityTime': instance.validityTime,
      'needPay': instance.needPay,
      'r': instance.r,
    };

VideoBase _$VideoBaseFromJson(Map<String, dynamic> json) {
  return VideoBase()
    ..vid = json['vid'] as String?
    ..title = json['title'] as String?
    ..description = json['description'] as String?
    ..scm = json['scm'] as String?
    ..alg = json['alg'] as String?
    ..threadId = json['threadId'] as String?
    ..coverUrl = json['coverUrl'] as String?
    ..previewUrl = json['previewUrl'] as String?
    ..width = json['width'] as int?
    ..height = json['height'] as int?
    ..praisedCount = json['praisedCount'] as int?
    ..playTime = json['playTime'] as int?
    ..durationms = json['durationms'] as int?
    ..previewDurationms = json['previewDurationms'] as int?
    ..commentCount = json['commentCount'] as int?
    ..shareCount = json['shareCount'] as int?
    ..praised = json['praised'] as bool?
    ..subscribed = json['subscribed'] as bool?
    ..hasRelatedGameAd = json['hasRelatedGameAd'] as bool?
    ..resolutions = (json['resolutions'] as List<dynamic>?)?.map((e) => VideoResolution.fromJson(e as Map<String, dynamic>)).toList()
    ..urlInfo = json['urlInfo'] == null ? null : VideoUrlInfo.fromJson(json['urlInfo'] as Map<String, dynamic>)
    ..videoGroup = (json['videoGroup'] as List<dynamic>?)?.map((e) => VideoMetaItem.fromJson(e as Map<String, dynamic>)).toList()
    ..relateSong = (json['relateSong'] as List<dynamic>?)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$VideoBaseToJson(VideoBase instance) => <String, dynamic>{
      'vid': instance.vid,
      'title': instance.title,
      'description': instance.description,
      'scm': instance.scm,
      'alg': instance.alg,
      'threadId': instance.threadId,
      'coverUrl': instance.coverUrl,
      'previewUrl': instance.previewUrl,
      'width': instance.width,
      'height': instance.height,
      'praisedCount': instance.praisedCount,
      'playTime': instance.playTime,
      'durationms': instance.durationms,
      'previewDurationms': instance.previewDurationms,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'praised': instance.praised,
      'subscribed': instance.subscribed,
      'hasRelatedGameAd': instance.hasRelatedGameAd,
      'resolutions': instance.resolutions,
      'urlInfo': instance.urlInfo,
      'videoGroup': instance.videoGroup,
      'relateSong': instance.relateSong,
    };

Video _$VideoFromJson(Map<String, dynamic> json) {
  return Video()
    ..vid = json['vid'] as String?
    ..title = json['title'] as String?
    ..description = json['description'] as String?
    ..scm = json['scm'] as String?
    ..alg = json['alg'] as String?
    ..threadId = json['threadId'] as String?
    ..coverUrl = json['coverUrl'] as String?
    ..previewUrl = json['previewUrl'] as String?
    ..width = json['width'] as int?
    ..height = json['height'] as int?
    ..praisedCount = json['praisedCount'] as int?
    ..playTime = json['playTime'] as int?
    ..durationms = json['durationms'] as int?
    ..previewDurationms = json['previewDurationms'] as int?
    ..commentCount = json['commentCount'] as int?
    ..shareCount = json['shareCount'] as int?
    ..praised = json['praised'] as bool?
    ..subscribed = json['subscribed'] as bool?
    ..hasRelatedGameAd = json['hasRelatedGameAd'] as bool?
    ..resolutions = (json['resolutions'] as List<dynamic>?)?.map((e) => VideoResolution.fromJson(e as Map<String, dynamic>)).toList()
    ..urlInfo = json['urlInfo'] == null ? null : VideoUrlInfo.fromJson(json['urlInfo'] as Map<String, dynamic>)
    ..videoGroup = (json['videoGroup'] as List<dynamic>?)?.map((e) => VideoMetaItem.fromJson(e as Map<String, dynamic>)).toList()
    ..relateSong = (json['relateSong'] as List<dynamic>?)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList()
    ..creator = NeteaseUserInfo.fromJson(json['creator'] as Map<String, dynamic>);
}

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'vid': instance.vid,
      'title': instance.title,
      'description': instance.description,
      'scm': instance.scm,
      'alg': instance.alg,
      'threadId': instance.threadId,
      'coverUrl': instance.coverUrl,
      'previewUrl': instance.previewUrl,
      'width': instance.width,
      'height': instance.height,
      'praisedCount': instance.praisedCount,
      'playTime': instance.playTime,
      'durationms': instance.durationms,
      'previewDurationms': instance.previewDurationms,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'praised': instance.praised,
      'subscribed': instance.subscribed,
      'hasRelatedGameAd': instance.hasRelatedGameAd,
      'resolutions': instance.resolutions,
      'urlInfo': instance.urlInfo,
      'videoGroup': instance.videoGroup,
      'relateSong': instance.relateSong,
      'creator': instance.creator,
    };

Video2 _$Video2FromJson(Map<String, dynamic> json) {
  return Video2()
    ..vid = json['vid'] as String?
    ..title = json['title'] as String?
    ..description = json['description'] as String?
    ..scm = json['scm'] as String?
    ..alg = json['alg'] as String?
    ..threadId = json['threadId'] as String?
    ..coverUrl = json['coverUrl'] as String?
    ..previewUrl = json['previewUrl'] as String?
    ..width = json['width'] as int?
    ..height = json['height'] as int?
    ..praisedCount = json['praisedCount'] as int?
    ..playTime = json['playTime'] as int?
    ..durationms = json['durationms'] as int?
    ..previewDurationms = json['previewDurationms'] as int?
    ..commentCount = json['commentCount'] as int?
    ..shareCount = json['shareCount'] as int?
    ..praised = json['praised'] as bool?
    ..subscribed = json['subscribed'] as bool?
    ..hasRelatedGameAd = json['hasRelatedGameAd'] as bool?
    ..resolutions = (json['resolutions'] as List<dynamic>?)?.map((e) => VideoResolution.fromJson(e as Map<String, dynamic>)).toList()
    ..urlInfo = json['urlInfo'] == null ? null : VideoUrlInfo.fromJson(json['urlInfo'] as Map<String, dynamic>)
    ..videoGroup = (json['videoGroup'] as List<dynamic>?)?.map((e) => VideoMetaItem.fromJson(e as Map<String, dynamic>)).toList()
    ..relateSong = (json['relateSong'] as List<dynamic>?)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList()
    ..creator = (json['creator'] as List<dynamic>?)?.map((e) => NeteaseUserInfo.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$Video2ToJson(Video2 instance) => <String, dynamic>{
      'vid': instance.vid,
      'title': instance.title,
      'description': instance.description,
      'scm': instance.scm,
      'alg': instance.alg,
      'threadId': instance.threadId,
      'coverUrl': instance.coverUrl,
      'previewUrl': instance.previewUrl,
      'width': instance.width,
      'height': instance.height,
      'praisedCount': instance.praisedCount,
      'playTime': instance.playTime,
      'durationms': instance.durationms,
      'previewDurationms': instance.previewDurationms,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'praised': instance.praised,
      'subscribed': instance.subscribed,
      'hasRelatedGameAd': instance.hasRelatedGameAd,
      'resolutions': instance.resolutions,
      'urlInfo': instance.urlInfo,
      'videoGroup': instance.videoGroup,
      'relateSong': instance.relateSong,
      'creator': instance.creator,
    };

VideoMetaItem _$VideoMetaItemFromJson(Map<String, dynamic> json) {
  return VideoMetaItem()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..url = json['url'] as String?
    ..relatedVideoType = json['relatedVideoType'] as String?
    ..selectTab = json['selectTab'] as bool?;
}

Map<String, dynamic> _$VideoMetaItemToJson(VideoMetaItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'relatedVideoType': instance.relatedVideoType,
      'selectTab': instance.selectTab,
    };

VideoMetaListWrap _$VideoMetaListWrapFromJson(Map<String, dynamic> json) {
  return VideoMetaListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = (json['data'] as List<dynamic>?)?.map((e) => VideoMetaItem.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$VideoMetaListWrapToJson(VideoMetaListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

VideoWrap _$VideoWrapFromJson(Map<String, dynamic> json) {
  return VideoWrap()
    ..type = json['type'] as int?
    ..displayed = json['displayed'] as bool?
    ..alg = json['alg'] as String?
    ..extAlg = json['extAlg'] as String?
    ..data = Video.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$VideoWrapToJson(VideoWrap instance) => <String, dynamic>{
      'type': instance.type,
      'displayed': instance.displayed,
      'alg': instance.alg,
      'extAlg': instance.extAlg,
      'data': instance.data,
    };

VideoListWrapX _$VideoListWrapXFromJson(Map<String, dynamic> json) {
  return VideoListWrapX()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..datas = (json['datas'] as List<dynamic>?)?.map((e) => VideoWrap.fromJson(e as Map<String, dynamic>)).toList()
    ..rcmdLimit = json['rcmdLimit'] as int?;
}

Map<String, dynamic> _$VideoListWrapXToJson(VideoListWrapX instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'datas': instance.datas,
      'rcmdLimit': instance.rcmdLimit,
    };

VideoListWrap _$VideoListWrapFromJson(Map<String, dynamic> json) {
  return VideoListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = (json['data'] as List<dynamic>?)?.map((e) => Video2.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$VideoListWrapToJson(VideoListWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

VideoDetailWrap _$VideoDetailWrapFromJson(Map<String, dynamic> json) {
  return VideoDetailWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = Video.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$VideoDetailWrapToJson(VideoDetailWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

VideoDetailInfoWrap _$VideoDetailInfoWrapFromJson(Map<String, dynamic> json) {
  return VideoDetailInfoWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..likedCount = json['likedCount'] as int?
    ..shareCount = json['shareCount'] as int?
    ..commentCount = json['commentCount'] as int?
    ..liked = json['liked'] as bool?;
}

Map<String, dynamic> _$VideoDetailInfoWrapToJson(VideoDetailInfoWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'likedCount': instance.likedCount,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
      'liked': instance.liked,
    };

VideoUrl _$VideoUrlFromJson(Map<String, dynamic> json) {
  return VideoUrl()
    ..id = dynamicToString(json['id'])
    ..url = json['url'] as String?
    ..size = json['size'] as int?
    ..validityTime = json['validityTime'] as int?
    ..needPay = json['needPay'] as bool?
    ..r = json['r'] as int?;
}

Map<String, dynamic> _$VideoUrlToJson(VideoUrl instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'size': instance.size,
      'validityTime': instance.validityTime,
      'needPay': instance.needPay,
      'r': instance.r,
    };

VideoUrlWrap _$VideoUrlWrapFromJson(Map<String, dynamic> json) {
  return VideoUrlWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..urls = (json['urls'] as List<dynamic>?)?.map((e) => VideoUrl.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$VideoUrlWrapToJson(VideoUrlWrap instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'urls': instance.urls,
    };
