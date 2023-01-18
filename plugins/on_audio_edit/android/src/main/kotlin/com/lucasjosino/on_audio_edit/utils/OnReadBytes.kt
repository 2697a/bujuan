package com.lucasjosino.on_audio_edit.utils

import java.io.ByteArrayOutputStream
import java.io.IOException
import java.io.InputStream

fun readBytes(stream: InputStream): ByteArray? {
    val byOS = ByteArrayOutputStream()
    val buffer = ByteArray(4096)
    var count: Int
    while (stream.read(buffer).also { count = it } != -1) {
        byOS.write(buffer, 0, count)
    }
    stream.close()
    return byOS.toByteArray()
}