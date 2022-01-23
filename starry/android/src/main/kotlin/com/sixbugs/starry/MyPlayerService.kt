package com.sixbugs.starry

import android.content.Context
import android.net.Uri
import android.text.TextUtils
import io.flutter.plugin.common.MethodChannel
import io.reactivex.Observable
import io.reactivex.ObservableEmitter
import io.reactivex.ObservableOnSubscribe
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import snow.player.PlayerService
import snow.player.SoundQuality
import snow.player.annotation.PersistenceId
import snow.player.audio.MusicItem
import snow.player.audio.MusicPlayer
import snow.player.effect.AudioEffectManager
import snow.player.exo.ExoMusicPlayer
import snow.player.ui.equalizer.AndroidAudioEffectManager
import snow.player.util.AsyncResult

@PersistenceId("MyPlayerService")
class MyPlayerService : PlayerService() {
    private lateinit var subscribe: Disposable

    override fun onCreate() {
        super.onCreate()
//        setMaxIDLETime(30)
    }


    override fun onCreateMusicPlayer(context: Context, musicItem: MusicItem, uri: Uri): MusicPlayer {
        return ExoMusicPlayer(context, uri)
    }

    override fun onCreateAudioEffectManager(): AudioEffectManager {
        return AndroidAudioEffectManager()
    }

    override fun onCreateNotificationView(): NotificationView {
        return AppNotificationView()
    }


    override fun onRetrieveMusicItemUri(musicItem: MusicItem, soundQuality: SoundQuality, result: AsyncResult<Uri>) {
        try {
            if (musicItem.uri == musicItem.musicId) {
                subscribe = Observable.create(ObservableOnSubscribe<String> {
                    StarryPlugin.channel.invokeMethod("GET_SONG_URL", musicItem.musicId, object : MethodChannel.Result {
                        override fun notImplemented() {
                            result.onSuccess(Uri.parse("http://music.163.com/song/media/outer/url?id=" + musicItem.musicId))
                        }

                        override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                            result.onSuccess(Uri.parse("http://music.163.com/song/media/outer/url?id=" + musicItem.musicId))
                            //没有获取到，以后走拼接
                        }

                        override fun success(result1: Any?) {
                            if (result1 == null || TextUtils.isEmpty(result1 as String)) {
                                result.onSuccess(Uri.parse("http://music.163.com/song/media/outer/url?id=" + musicItem.musicId))
                            } else {
                                result.onSuccess(Uri.parse(result1 as String?))
                            }
                        }

                    })
                }).subscribeOn(AndroidSchedulers.mainThread()).subscribe()

            } else {
                result.onSuccess(Uri.parse(musicItem.uri))
            }
        } catch (e: Exception) {
            result.onError(e.fillInStackTrace())
        }
    }

    override fun onDestroy() {
        subscribe.dispose()
        super.onDestroy()
    }

}
