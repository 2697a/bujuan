package com.sixbugs.starry

import android.net.Uri
import io.flutter.plugin.common.MethodChannel
import snow.player.PlayerService
import snow.player.SoundQuality
import snow.player.annotation.PersistenceId
import snow.player.audio.MusicItem
import snow.player.util.AsyncResult

@PersistenceId("MyPlayerService")
class MyPlayerService : PlayerService() {


    override fun onCreateNotificationView(): NotificationView? {
        return AppNotificationView()
    }

//    override fun onRetrieveMusicItemUri(musicItem: MusicItem, soundQuality: SoundQuality): Uri {
//        if (musicItem.uri == musicItem.musicId) {
//            val countDownLatch = CountDownLatch(1)
//            var url = ""
//            val function = {
//                StarryPlugin.channel.invokeMethod("GET_SONG_URL", musicItem.musicId)
//                StarryPlugin.channel.invokeMethod("GET_SONG_URL", musicItem.musicId, object : MethodChannel.Result {
//                    override fun notImplemented() {
//                    }
//
//                    override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
//                        //没有获取到，以后走拼接
//                        countDownLatch.countDown()
//                    }
//
//                    override fun success(result: Any?) {
//                        url = result as String
//                        countDownLatch.countDown()
//                    }
//
//                })
//            }
//            StarryPlugin.activity.runOnUiThread(function)
//            countDownLatch.await()
//            return Uri.parse(url)
//        } else {
//            return Uri.parse(musicItem.uri)
//        }
//    }

    override fun onRetrieveMusicItemUri(musicItem: MusicItem, soundQuality: SoundQuality, result: AsyncResult<Uri>) {
        try {
            if (musicItem.uri == musicItem.musicId) {
                val function = {
                    StarryPlugin.channel.invokeMethod("GET_SONG_URL", musicItem.musicId)
                    StarryPlugin.channel.invokeMethod("GET_SONG_URL", musicItem.musicId, object : MethodChannel.Result {
                        override fun notImplemented() {
                            result.onSuccess(Uri.parse("http://music.163.com/song/media/outer/url?id" + musicItem.musicId))
                        }

                        override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                            result.onSuccess(Uri.parse("http://music.163.com/song/media/outer/url?id" + musicItem.musicId))
                            //没有获取到，以后走拼接
                        }

                        override fun success(result1: Any?) {
                            if (result1 == null) {
                                result.onSuccess(Uri.parse("http://music.163.com/song/media/outer/url?id" + musicItem.musicId))
                            } else {
                                result.onSuccess(Uri.parse(result1 as String?))
                            }
                        }

                    })
                }
                StarryPlugin.activity.runOnUiThread(function)

            } else {
                result.onSuccess(Uri.parse(musicItem.uri))
            }
        } catch (e: Exception) {
            result.onError(e.fillInStackTrace())
        }
    }
}