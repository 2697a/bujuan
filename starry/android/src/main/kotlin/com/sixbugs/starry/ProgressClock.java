package com.sixbugs.starry;

import android.os.SystemClock;
import android.util.Log;

import androidx.annotation.NonNull;

import com.google.common.base.Preconditions;

import java.util.Locale;
import java.util.concurrent.TimeUnit;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;

/**
 * 进度条时钟，支持倒计时。
 */
public class ProgressClock {
    private static final String TAG = "ProgressClock";

    private final boolean mCountDown;
    private boolean mEnabled;
    private final Callback mCallback;

    private int mProgressSec;       // 单位：秒
    private int mDurationSec;       // 单位：秒

    private Disposable mDisposable;

    /**
     * 创建一个 ProgressClock 对象。
     * <p>
     * 默认处于启用状态，非倒计时。
     *
     * @param callback 回调接口，用于接收 progress 值的更新，不能为 null
     * @see #isEnabled()
     * @see #setEnabled(boolean)
     */
    public ProgressClock(@NonNull Callback callback) {
        this(false, callback);
    }

    /**
     * 创建一个 ProgressClock 对象。
     *
     * @param countDown 是否是倒计时
     * @param callback  回调接口，用于接收 progress 值的更新，不能为 null
     * @see #isEnabled()
     * @see #setEnabled(boolean)
     */
    public ProgressClock(boolean countDown, @NonNull Callback callback) {
        Preconditions.checkNotNull(callback);
        mEnabled = true;
        mCountDown = countDown;
        mCallback = callback;
    }

    /**
     * 判断是否启用了进度条时钟。
     * <p>
     * 如果返回 false，则会忽略对 {@link #start(int, long, int)} 方法的调用
     *
     * @return 是否启用了进度条时钟
     */
    public boolean isEnabled() {
        return mEnabled;
    }

    /**
     * 是否是倒计时时钟。
     *
     * @return 是否是倒计时时钟，如果是则返回 true，否则返回 false
     */
    public boolean isCountDown() {
        return mCountDown;
    }

    /**
     * 设置是否启用进度条时钟。
     * <p>
     * 如果参数为 false，则会忽略对 {@link #start(int, long, int)} 方法的调用。
     *
     * @param enabled 是否启用进度条时钟
     */
    public void setEnabled(boolean enabled) {
        mEnabled = enabled;
        if (!mEnabled) {
            cancel();
        }
    }

    /**
     * 启动定时器。<b>注意！所有时间都是基于 {@code SystemClock.elapsedRealtime()} 的。</b>
     *
     * @param progress   歌曲的播放进度（单位：毫秒）
     * @param updateTime 歌曲播放进度的更新时间（单位：毫秒）
     * @param duration   歌曲的持续时间（单位：毫秒）
     * @throws IllegalArgumentException 在 updateTime 大于当前时间时抛出该异常
     */
    public void start(int progress, long updateTime, int duration) throws IllegalArgumentException {
        cancel();

        if (duration < 1) {
            mCallback.onUpdateProgress(0, 0);
            return;
        }

        long currentTime = SystemClock.elapsedRealtime();
        if (updateTime > currentTime) {
            updateTime = currentTime;
            Log.w(TAG, "updateTime > currentTime. " +
                    "updateTime=" + updateTime + ", " +
                    "currentTime=" + currentTime);
        }

        long realProgress = progress + (currentTime - updateTime);

        if (mCountDown) {
            mProgressSec = (int) Math.ceil((duration - realProgress) / 1000.0);
        } else {
            mProgressSec = (int) (realProgress / 1000);
        }
        mDurationSec = duration / 1000;

        if (!mEnabled) {
            mCallback.onUpdateProgress(mProgressSec, mDurationSec);
            return;
        }

        if (isTimeout()) {
            notifyTimeout();
            return;
        }

        updateProgress(mProgressSec);

        long delay = 1000 - (realProgress % 1000);
        mDisposable = Observable.interval(delay, 1000, TimeUnit.MILLISECONDS)
                .subscribeOn(Schedulers.computation())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<Long>() {
                    @Override
                    public void accept(Long aLong) {
                        if (mCountDown) {
                            decrease();
                        } else {
                            increase();
                        }
                    }
                });
    }

    private boolean isTimeout() {
        if (mCountDown) {
            return mProgressSec <= 0;
        }

        return mProgressSec >= mDurationSec;
    }

    private void notifyTimeout() {
        if (mCountDown) {
            mCallback.onUpdateProgress(0, mDurationSec);
            return;
        }

        mCallback.onUpdateProgress(mDurationSec, mDurationSec);
    }

    public void cancel() {
        if (mDisposable != null && !mDisposable.isDisposed()) {
            mDisposable.dispose();
            mDisposable = null;
        }
    }

    private void increase() {
        int newProgress = mProgressSec + 1;

        if (newProgress >= mDurationSec) {
            cancel();
        }

        updateProgress(newProgress);
    }

    private void decrease() {
        int newProgress = mProgressSec - 1;

        if (newProgress <= 0) {
            cancel();
        }

        updateProgress(newProgress);
    }

    private void updateProgress(int progressSec/*单位：秒*/) {
        mProgressSec = progressSec;
        mCallback.onUpdateProgress(mProgressSec, mDurationSec);
    }

    /**
     * 将歌曲的播放进度格式化成一个形如 “00:00” 的字符串，方便在 UI 上显示。
     * <p>
     * 格式化后的字符串的格式为：[时:分:秒]（例如：01:30:45）。如果 “时” 为 0, 则会忽略, 此时的字符串格式
     * 是：[分:秒]（例如：04:35）。最多支持到 99:59:59, 如果 seconds 参数的值大于等于 359,999(99:59:59) 时，
     * 会直接返回 99:59:59。
     *
     * @param seconds 歌曲的播放进度，单位：秒
     * @return 返回格式化后的字符串
     */
    public static String asText(int seconds) {
        if (seconds <= 0) {
            return "00:00";
        }

        int maxSeconds = (99 * 60 * 60)/*hour*/ + (59 * 60)/*minute*/ + 59/*second*/;

        if (seconds >= maxSeconds) {
            return "99:59:59";
        }

        int second = seconds % 60;
        int minute = (seconds / 60) % 60;
        int hour = (seconds / 3600);

        if (hour <= 0) {
            return String.format(Locale.ENGLISH, "%02d:%02d", minute, second);
        }

        return String.format(Locale.ENGLISH, "%02d:%02d:%02d", hour, minute, second);
    }

    /**
     * 回调接口。
     *
     * @see ProgressClock
     */
    public interface Callback {
        /**
         * 该方法会在 ProgressClock 的进度更新时调用。
         *
         * @param progressSec 当前播放进度（单位：秒）
         * @param durationSec 歌曲的持续时间（单位：秒）
         */
        void onUpdateProgress(int progressSec, int durationSec);
    }
}
