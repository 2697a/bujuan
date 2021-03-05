package com.sixbugs.starry

import android.content.Context
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.text.TextUtils
import androidx.annotation.NonNull
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import com.lzx.starrysky.SongInfo
import com.lzx.starrysky.StarrySky
import com.lzx.starrysky.intercept.AsyncInterceptor
import com.lzx.starrysky.intercept.InterceptorCallback
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
            }
            "PLAY_BY_INFO" -> {
                //根据songInfo播放
            }
            "PAUSE" -> {
                //暂停
            }
            "PLAY" -> {
                //播放
            }
            "NEXT" -> {
                //下一首
            }
            "PREVIOUS" -> {
                //上一首
            }

            else -> result.notImplemented()

        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        StarrySky.init(binding.activity.application)
                .setOpenCache(false)
                .setDebug(true)
                .setAutoManagerFocus(true)   //使用多实例的时候要关掉，不然会相互抢焦点
                .addInterceptor(SongUrlInterceptor(channel))
                .setImageLoader(ImageLoader())
                .setNotificationSwitch(true)
                .setNotificationType(INotification.SYSTEM_NOTIFICATION)
                .apply()
    }


    //播放前拦截检测
    class SongUrlInterceptor(private var channel: MethodChannel) : AsyncInterceptor() {
        override fun process(songInfo: SongInfo?, callback: InterceptorCallback) {
            if (TextUtils.isEmpty(songInfo?.songUrl)) {
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
