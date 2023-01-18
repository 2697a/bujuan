package com.lucasjosino.on_audio_edit.utils

fun convertFileSize(sizeInBytes: Long): Long {
    val fileSizeInKB = sizeInBytes / 1024
    return fileSizeInKB / 1024
}