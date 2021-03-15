package com.sixbugs.starry

import android.annotation.SuppressLint
import android.app.Activity
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import snow.player.Player
import snow.player.PlayerClient
import snow.player.audio.MusicItem
import snow.player.playlist.Playlist
import snow.player.playlist.PlaylistManager
import snow.player.ui.equalizer.EqualizerActivity


/** StarryPlugin */
class StarryPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var playerClient: PlayerClient
    private lateinit var changeListener: (MusicItem?, Int, Int) -> Unit
    private lateinit var playlistChangeListener: (PlaylistManager, Int) -> Unit
    private lateinit var starryPlaybackStateChangeListener: StarryPlaybackStateChangeListener
    private lateinit var liveProgress: LiveProgress
    private lateinit var eventChannel: EventChannel
    var eventSink: EventChannel.EventSink? = null

    companion object {
        lateinit var channel: MethodChannel

        @SuppressLint("StaticFieldLeak")
        lateinit var activity: Activity
    }


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "starry")
        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "starry/event")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "INIT" -> {
                //监听歌曲播放状态
                starryPlaybackStateChangeListener = StarryPlaybackStateChangeListener()
                playerClient.addOnPlaybackStateChangeListener(starryPlaybackStateChangeListener)
                //播放歌曲发生变化
                changeListener = { musicItem, _, _ -> channel.invokeMethod("SWITCH_SONG_INFO", GsonUtil.GsonString(musicItem)) }
                playerClient.addOnPlayingMusicItemChangeListener(changeListener)
                //监听歌曲播放进度
                liveProgress = LiveProgress(playerClient) { progressSec, _, _, _ -> eventSink?.success(progressSec) }
                liveProgress.subscribe()
                //播放列表发生变化
                playlistChangeListener = { playlistManager, _ ->
                    playlistManager.getPlaylist { playlist ->
                        val listStr = GsonUtil.GsonString(playlist.allMusicItem.toList())
                        channel.invokeMethod("PLAY_LIST_CHANGE", listStr)
                    }
                }
                playerClient.addOnPlaylistChangeListener(playlistChangeListener)
                result.success("success")
            }
            "PLAY_MUSIC" -> {
                val songList = call.argument<String>("PLAY_LIST")!!
                val index = call.argument<Int>("INDEX")!!
                val jsonToList = GsonUtil.jsonToList(songList, MusicItem::class.java)
                val appendAll = Playlist.Builder().appendAll(jsonToList.toMutableList()).build()
                playerClient.setPlaylist(appendAll, index, true)
                result.success("success")
            }
            "PLAY_BY_INDEX" -> {
                //根据INDEX播放
                val index = call.argument<Int>("INDEX")!!
                playerClient.getPlaylist { data ->
                    if (data.allMusicItem.size > index) {
                        playerClient.skipToPosition(index)
                    }
                }
                result.success("success")
            }
            "NOW_PLAYING" -> {
                //获取当前播放的歌曲
                val playingMusicItem = playerClient.playingMusicItem
                val playingSongStr = GsonUtil.GsonString(playingMusicItem)
                result.success(playingSongStr)
            }
            "PAUSE" -> {
                //暂停
                if (playerClient.isPlaying) {
                    playerClient.pause()
                }
                result.success("success")
            }
            "RESTORE" -> {
                //播放
                if (playerClient.isConnected)
                    playerClient.play()
                result.success("success")
            }
            "NEXT" -> {
                //下一首
                playerClient.skipToNext()
                result.success("success")
            }
            "PREVIOUS" -> {
                //上一首
                playerClient.skipToPrevious()
                result.success("success")
            }
            "PLAY_LIST" -> {
                //上一首
                playerClient.getPlaylist { playlist ->
                    val listStr = GsonUtil.GsonString(playlist.allMusicItem.toList())
                    result.success(listStr)
                }
            }
            "CHANGE_SEEK" -> {
                //改变播放进度
                val seek = call.argument<Int>("SEEK")!!
                playerClient.seekTo(seek)
            }
            "TOGGLE_AUDIO_EFFECT" -> {
                //开启/关闭音效
            }
            "UPDATE_AUDIO_EFFECT_CONFIG" -> {
                //更新音效
            }
            "TOGGLE_IGNORE_AUDIO_FOCUS" -> {
                //忽略/不忽略音频焦点
                val isIgnore = call.argument<Boolean>("IS_IGNORE")!!
                playerClient.isIgnoreAudioFocus = isIgnore
                if (playerClient.isConnected)
                    result.success(1)
                else
                    result.success(0)
            }

            else -> result.notImplemented()

        }

    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        playerClient.removeOnPlayingMusicItemChangeListener(changeListener)
        playerClient.removeOnPlaybackStateChangeListener(starryPlaybackStateChangeListener)
        playerClient.removeOnPlaylistChangeListener(playlistChangeListener)
        liveProgress.unsubscribe()
        playerClient.shutdown()
//        exitProcess(0)
    }

    override fun onDetachedFromActivity() {
//        playerClient.removeOnPlayingMusicItemChangeListener(changeListener)
//        playerClient.removeOnPlaybackStateChangeListener(starryPlaybackStateChangeListener)
//        liveProgress.unsubscribe()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        // 创建一个 PlayerClient 对象
        playerClient = PlayerClient.newInstance(binding.activity.applicationContext, MyPlayerService::class.java)
        if (!playerClient.isConnected) {
            playerClient.connect { success -> Log.d("App", "connect: $success"); }
        }
        eventChannel.setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                        eventSink = events
                        Log.d("Android", "EventChannel onListen called")
                    }

                    override fun onCancel(arguments: Any?) {
                        liveProgress.unsubscribe()
                        Log.w("Android", "EventChannel onCancel called")
                    }
                })

    }


    class StarryPlaybackStateChangeListener : Player.OnPlaybackStateChangeListener {
        override fun onPlay(stalled: Boolean, playProgress: Int, playProgressUpdateTime: Long) {
            channel.invokeMethod("PLAYING_SONG_INFO", null)
        }

        override fun onPause(playProgress: Int, updateTime: Long) {
            channel.invokeMethod("PAUSE_OR_IDEA_SONG_INFO", null)
        }

        override fun onStop() {
            channel.invokeMethod("STOP_SONG_INFO", null)
        }

        override fun onError(errorCode: Int, errorMessage: String?) {
            channel.invokeMethod("PLAY_ERROR", null)
        }

    }
}
