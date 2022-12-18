package com.ryanheise.just_audio;

import android.os.Handler;

import com.google.android.exoplayer2.MediaItem;
import com.google.android.exoplayer2.Timeline;
import com.google.android.exoplayer2.analytics.PlayerId;
import com.google.android.exoplayer2.drm.DrmSessionEventListener;
import com.google.android.exoplayer2.source.MediaPeriod;
import com.google.android.exoplayer2.source.MediaSource;
import com.google.android.exoplayer2.source.MediaSourceEventListener;
import com.google.android.exoplayer2.source.SilenceMediaSource;
import com.google.android.exoplayer2.upstream.Allocator;
import com.google.android.exoplayer2.upstream.TransferListener;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * A {@link MediaSource} that lazily defers to another {@link MediaSource} when it is required.
 * <p>
 * This {@link MediaSource} must be used with a {@link com.google.android.exoplayer2.source.MaskingMediaSource}.
 */
class LazyMediaSource implements MediaSource {
    private final LazyMediaSourceProvider mediaSourceProvider;
    public final String id;
    public final MediaItem placeholderMediaItem;

    private final Map<MediaSourceEventListener, Handler> pendingEventListeners = new HashMap<>();
    private final Map<DrmSessionEventListener, Handler> pendingDrmEventListeners = new HashMap<>();

    private MediaSource mediaSource;

    LazyMediaSource(LazyMediaSourceProvider mediaSourceProvider, String id, MediaItem placeholderMediaItem) {
        this.mediaSourceProvider = mediaSourceProvider;
        this.id = id;
        this.placeholderMediaItem = placeholderMediaItem;
    }

    @Override
    public void addEventListener(Handler handler, MediaSourceEventListener eventListener) {
        if (mediaSource == null) {
            pendingEventListeners.put(eventListener, handler);
        } else {
            mediaSource.addEventListener(handler, eventListener);
        }
    }

    @Override
    public void removeEventListener(MediaSourceEventListener eventListener) {
        if (mediaSource == null) {
            pendingEventListeners.remove(eventListener);
        } else {
            mediaSource.removeEventListener(eventListener);
        }
    }

    @Override
    public void addDrmEventListener(Handler handler, DrmSessionEventListener eventListener) {
        if (mediaSource == null) {
            pendingDrmEventListeners.put(eventListener, handler);
        } else {
            mediaSource.addDrmEventListener(handler, eventListener);
        }
    }

    @Override
    public void removeDrmEventListener(DrmSessionEventListener eventListener) {
        if (mediaSource == null) {
            pendingDrmEventListeners.remove(eventListener);
        } else {
            mediaSource.removeDrmEventListener(eventListener);
        }
    }

    @Override
    public Timeline getInitialTimeline() {
        if (mediaSource == null) return null;
        return mediaSource.getInitialTimeline();
    }

    @Override
    public boolean isSingleWindow() {
        if (mediaSource == null) return false;
        return mediaSource.isSingleWindow();
    }

    @Override
    public MediaItem getMediaItem() {
        if (mediaSource == null) {
            return placeholderMediaItem;
        } else {
            return mediaSource.getMediaItem();
        }
    }

    @Override
    public void prepareSource(
            MediaSourceCaller caller,
            TransferListener mediaTransferListener,
            PlayerId playerId
    ) {
        mediaSourceProvider.createMediaSource(id, (mediaSource) -> {
            if (mediaSource == null) {
                this.mediaSource = new SilenceMediaSource(0);
            } else {
                this.mediaSource = mediaSource;
            }

            for (Map.Entry<MediaSourceEventListener, Handler> entry : pendingEventListeners.entrySet()) {
                this.mediaSource.addEventListener(entry.getValue(), entry.getKey());
            }
            pendingEventListeners.clear();
            for (Map.Entry<DrmSessionEventListener, Handler> entry : pendingDrmEventListeners.entrySet()) {
                this.mediaSource.addDrmEventListener(entry.getValue(), entry.getKey());
            }
            pendingDrmEventListeners.clear();
            this.mediaSource.prepareSource(caller, mediaTransferListener, playerId);
        });
    }

    @Override
    public void maybeThrowSourceInfoRefreshError() throws IOException {
        if (mediaSource == null) return;
        mediaSource.maybeThrowSourceInfoRefreshError();
    }

    @Override
    public void enable(MediaSourceCaller caller) {
        if (mediaSource == null) throw new IllegalStateException();
        mediaSource.enable(caller);
    }

    @Override
    public MediaPeriod createPeriod(MediaPeriodId id, Allocator allocator, long startPositionUs) {
        if (mediaSource == null) throw new IllegalStateException();
        return mediaSource.createPeriod(id, allocator, startPositionUs);
    }

    @Override
    public void releasePeriod(MediaPeriod mediaPeriod) {
        if (mediaSource == null) throw new IllegalStateException();
        mediaSource.releasePeriod(mediaPeriod);
    }

    @Override
    public void disable(MediaSourceCaller caller) {
        if (mediaSource == null) throw new IllegalStateException();
        mediaSource.disable(caller);
    }

    @Override
    public void releaseSource(MediaSourceCaller caller) {
        if (mediaSource == null) return;
        mediaSource.releaseSource(caller);
    }
}

interface LazyMediaSourceReceiver {
    void onMediaSourceCreated(MediaSource mediaSource);
}

interface LazyMediaSourceProvider {
    void createMediaSource(String id, LazyMediaSourceReceiver receiver);
}