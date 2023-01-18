package com.lucasjosino.on_audio_edit.utils

import android.util.Log

fun warningSizeCall(sizeValue: Long, data: String) {
    when (true) {
        sizeValue >= 13 -> {
            Log.e("on_audio_warning","-------------------------------------------------------------------------------------")
            Log.e("on_audio_wn_size", "[$data] size is bigger than 13 MB - [$sizeValue MB]")
            Log.e("on_audio_warning","-------------------------------------------------------------------------------------")
        }
        sizeValue >= 10 -> {
            Log.e("on_audio_warning", "[$data] size is bigger than 10 MB - [$sizeValue MB]")
        }
        sizeValue >= 6 -> {
            Log.i("on_audio_warning", "[$data] size is bigger than 6 MB - [$sizeValue MB]")
        }
        else -> {
            Log.i("unknow","unknow")
        }
    }
}