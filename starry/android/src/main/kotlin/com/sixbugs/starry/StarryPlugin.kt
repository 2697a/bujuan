package com.sixbugs.starry

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.text.TextUtils
import androidx.annotation.NonNull
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import com.lzx.starrysky.OnPlayProgressListener
import com.lzx.starrysky.OnPlayerEventListener
import com.lzx.starrysky.SongInfo
import com.lzx.starrysky.StarrySky
import com.lzx.starrysky.intercept.AsyncInterceptor
import com.lzx.starrysky.intercept.InterceptorCallback
import com.lzx.starrysky.manager.PlaybackStage
import com.lzx.starrysky.notification.INotification
import com.lzx.starrysky.notification.imageloader.ImageLoaderCallBack
import com.lzx.starrysky.notification.imageloader.ImageLoaderStrategy

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** StarryPlugin */
class StarryPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "starry")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "PLAY_MUSIC" -> {
                val songList = call.argument<String>("PLAY_LIST")!!
                val index = call.argument<Int>("INDEX")!!
                val jsonToList = GsonUtil.jsonToList(songList, SongInfo::class.java)
                StarrySky.with().playMusic(jsonToList.toMutableList(), index)
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "PLAY_BY_ID" -> {
                //根据ID播放
                val playList = StarrySky.with().getPlayList()
                val id = call.argument<String>("ID")
                if (playList.size > 0) {
                    StarrySky.with().playMusicById(id)
                }
            }
            "PLAY_BY_INFO" -> {
                //根据songInfo播放
                val playList = StarrySky.with().getPlayList()
                val songInfo = call.argument<String>("SONG_INFO")
                val songInfoToBean = GsonUtil.GsonToBean(songInfo, SongInfo::class.java)
                if (playList.size > 0) {
                    StarrySky.with().playMusicByInfo(songInfoToBean)
                }
            }
            "PAUSE" -> {
                //暂停
                if (StarrySky.with().isPlaying())
                    StarrySky.with().pauseMusic()
            }
            "RESTORE" -> {
                //播放
                if (StarrySky.with().isPaused())
                    StarrySky.with().restoreMusic()
            }
            "NEXT" -> {
                //下一首
                StarrySky.with().skipToNext()
            }
            "PREVIOUS" -> {
                //上一首
                StarrySky.with().skipToPrevious()
            }

            else -> result.notImplemented()

        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
        StarrySky.with().removePlayerEventListener("MAIN")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        //初始化
        StarrySky.init(binding.activity.application)
                .setOpenCache(false)
                .setDebug(true)
                .setAutoManagerFocus(true)   //使用多实例的时候要关掉，不然会相互抢焦点
                .addInterceptor(SongUrlInterceptor(channel, binding.activity))
                .setImageLoader(ImageLoader())
                .setNotificationSwitch(true)
                .setNotificationType(INotification.SYSTEM_NOTIFICATION)
                .apply()

        //进度监听
        StarrySky.with().setOnPlayProgressListener(object : OnPlayProgressListener {
            @SuppressLint("SetTextI18n")
            override fun onPlayProgress(currPos: Long, duration: Long) {
                channel.invokeMethod("PLAT_PROGRESS", 1)
            }
        })
        //状态监听
        StarrySky.with().addPlayerEventListener(object : OnPlayerEventListener {
            override fun onPlaybackStageChange(stage: PlaybackStage) {
                when (stage.stage) {
                    PlaybackStage.PLAYING -> {
                        channel.invokeMethod("PLAYING_SONG_INFO", GsonUtil.GsonString(stage.songInfo))
                    }
                    PlaybackStage.SWITCH -> { //切歌
                        channel.invokeMethod("SWITCH_SONG_INFO", GsonUtil.GsonString(stage.songInfo))
                    }
                    PlaybackStage.PAUSE,
                    PlaybackStage.IDEA -> {
                        channel.invokeMethod("PAUSE_OR_IDEA_SONG_INFO", GsonUtil.GsonString(stage.songInfo))
                    }
                    PlaybackStage.ERROR -> {//播放错误
                        channel.invokeMethod("PLAT_ERROR", GsonUtil.GsonString(stage.songInfo))
                    }
                }
            }
        }, "MAIN")
    }


    //播放前拦截检测
    class SongUrlInterceptor(private var channel: MethodChannel, private var activity: Activity) : AsyncInterceptor() {
        override fun process(songInfo: SongInfo?, callback: InterceptorCallback) {
            if (TextUtils.isEmpty(songInfo?.songUrl)) {
                activity.runOnUiThread {
                    channel.invokeMethod("GET_SONG_URL", songInfo?.songId, object : Result {
                        override fun notImplemented() {
                        }

                        override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                            //没有获取到，以后走拼接
                        }

                        override fun success(result: Any?) {
                            songInfo?.songUrl = result as String
                            callback.onContinue(songInfo)
                        }

                    })
                };
            } else {
                callback.onContinue(songInfo)
            }

        }

        override fun getTag(): String = "SongUrlInterceptor"

    }

    //图片加载
    class ImageLoader : ImageLoaderStrategy {
        override fun loadImage(context: Context, url: String?, callBack: ImageLoaderCallBack) {
            Glide.with(context).asBitmap().load(url).into(object : CustomTarget<Bitmap?>() {
                override fun onLoadCleared(placeholder: Drawable?) {}

                override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap?>?) {
                    callBack.onBitmapLoaded(resource)
                }

                override fun onLoadFailed(errorDrawable: Drawable?) {
                    super.onLoadFailed(errorDrawable)
                    callBack.onBitmapFailed(errorDrawable)
                }
            })
        }

    }


}
