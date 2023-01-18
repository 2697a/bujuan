package com.lucasjosino.on_audio_edit.utils

import android.graphics.Bitmap
import org.jaudiotagger.tag.id3.valuepair.ImageFormats
import java.lang.Exception

fun checkArtworkFormat(value: Int) : String {
    return when (value) {
        0 -> ImageFormats.MIME_TYPE_JPEG
        1 -> ImageFormats.MIME_TYPE_PNG
        else -> throw Exception("[ImageFormats] don't exist")
    }
}
fun checkArtworkFormatBitmap(format: Int) : Bitmap.CompressFormat {
    return when (format) {
        0 -> Bitmap.CompressFormat.JPEG
        1 -> Bitmap.CompressFormat.PNG
        else -> throw Exception("[checkArtworkFormat] value don't exist!")
    }
}
