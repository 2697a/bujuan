package com.lucasjosino.on_audio_edit.extensions

import org.jaudiotagger.tag.FieldKey

fun String.tryInt(key: Int): Any? {
    return when (key) {
        1,
        6,
        12,
        25,
        36,
        43,
        44,
        45,
        46,
        47,
        49,
        51,
        53,
        54,
        55,
        60,
        61,
        63,
        69,
        72,
        73,
        75,
        78,
        80,
        81 -> this.toIntOrNull()
        else -> this
    }
}

fun List<FieldKey>.checkFlac(data: String): List<FieldKey> {
    if (data.endsWith(".flac")) {
        val mutableList = this.toMutableList();
        mutableList.remove(FieldKey.COVER_ART)
        return mutableList.toList()
    }
    return this
}
