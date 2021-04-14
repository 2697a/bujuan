package com.sixbugs.starry

import android.app.PendingIntent
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import androidx.media.app.NotificationCompat
import snow.player.PlayMode
import snow.player.PlayerService
import kotlin.system.exitProcess

class AppNotificationView() : PlayerService.MediaNotificationView() {
    private val ACTION_TOGGLE_FAVORITE = "stop_play"
    private val ACTION_SWITCH_PLAY_MODE = "switch_play_mode"
    private lateinit var mSwitchPlayMode: PendingIntent
    private var mContentIntent: PendingIntent? = null
    private lateinit var mStopPlay: PendingIntent

    override fun onInit(context: Context?) {
        super.onInit(context)

        mSwitchPlayMode = buildCustomAction(ACTION_SWITCH_PLAY_MODE) { player, _ ->
            when (playMode) {
                PlayMode.PLAYLIST_LOOP -> {
                    player.setPlayMode(PlayMode.LOOP)

                }
                PlayMode.LOOP -> {
                    player.setPlayMode(PlayMode.SHUFFLE)

                }
                PlayMode.SHUFFLE -> {
                    player.setPlayMode(PlayMode.PLAYLIST_LOOP)
                }
            }
        }
        mStopPlay = buildCustomAction(ACTION_TOGGLE_FAVORITE) { player, _ ->
            player.stop()
            exitProcess(0)
        }

        val packageManager = context?.packageManager
        val intent: Intent? = packageManager?.getLaunchIntentForPackage("com.sixbugs.bujuan")
        intent?.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
//        intent?.putExtra(PlayerActivity.KEY_START_BY_PENDING_INTENT, true);
        mContentIntent = PendingIntent.getActivity(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT)

    }

    override fun onPlayModeChanged(playMode: PlayMode) {
        invalidate()
    }

    override fun onRelease() {
        super.onRelease()
    }

    override fun getSmallIconId(): Int {
        if (Build.VERSION.SDK_INT >= 21) {
            return R.drawable.ic_noti_icon
        }
        return super.getSmallIconId()
    }

    override fun onBuildMediaStyle(mediaStyle: NotificationCompat.MediaStyle?) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            mediaStyle?.setShowActionsInCompactView(1, 2, 3)
            return
        }
        mediaStyle?.setShowActionsInCompactView(2, 3)
    }

    override fun onBuildNotification(builder: androidx.core.app.NotificationCompat.Builder?) {
        addToggleFavorite(builder)
        addSkipToPrevious(builder)
        addPlayPause(builder)
        addSkipToNext(builder)
        addSwitchPlayMode(builder)
        builder?.setContentIntent(mContentIntent)
    }

    private fun addToggleFavorite(builder: androidx.core.app.NotificationCompat.Builder?) {
        builder?.addAction(R.drawable.ic_baseline_stop, "stop", mStopPlay)
    }

    private fun addSkipToPrevious(builder: androidx.core.app.NotificationCompat.Builder?) {
        builder?.addAction(R.drawable.ic_baseline_skip_previous, "skip to previous", doSkipToPrevious())
    }

    private fun addPlayPause(builder: androidx.core.app.NotificationCompat.Builder?) {
        var iconId: Int = if (isPlayingState) R.drawable.ic_baseline_pause else R.drawable.ic_baseline_play
        builder?.addAction(iconId, "play pause", doPlayPause())
    }

    private fun addSkipToNext(builder: androidx.core.app.NotificationCompat.Builder?) {
        builder?.addAction(R.drawable.ic_baseline_skip_next, "skip to next", doSkipToNext())
    }

    private fun addSwitchPlayMode(builder: androidx.core.app.NotificationCompat.Builder?) {
        when (playMode) {
            PlayMode.PLAYLIST_LOOP -> builder?.addAction(R.drawable.ic_baseline_repeat, "sequential", mSwitchPlayMode)
            PlayMode.LOOP -> builder?.addAction(R.drawable.ic_baseline_repeat_one, "sequential", mSwitchPlayMode)
            PlayMode.SHUFFLE -> builder?.addAction(R.drawable.ic_baseline_shuffle, "sequential", mSwitchPlayMode)
        }
    }
}