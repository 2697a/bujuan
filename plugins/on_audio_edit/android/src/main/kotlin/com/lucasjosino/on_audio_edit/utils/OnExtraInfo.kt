package com.lucasjosino.on_audio_edit.utils

import org.jaudiotagger.audio.AudioFile
import org.jaudiotagger.tag.Tag

fun checkAndGetExtraInfo(audioFile: AudioFile) : MutableMap<String, Any?> {
    val extraInfo: MutableMap<String, Any?> = HashMap()
    extraInfo["BITRATE"] = audioFile.audioHeader.bitRate.toInt()
    extraInfo["FORMAT"] = audioFile.audioHeader.format
    extraInfo["SAMPLE_RATE"] = audioFile.audioHeader.sampleRate.toInt()
    extraInfo["CHANNELS"] = audioFile.audioHeader.channels
    extraInfo["TYPE"] = audioFile.audioHeader.encodingType
    extraInfo["LENGTH"] = audioFile.file.length()
    extraInfo["FIRST_ARTWORK"] = audioFile.tag?.firstArtwork?.binaryData
    return extraInfo
}

fun getExtraInfo(audioFile: AudioFile, value: Int, audioTag: Tag) : Any? {
    return when (value) {
        82 -> audioFile.audioHeader.bitRate.toInt()
        83 -> audioFile.audioHeader.channels
        84 -> audioTag.firstArtwork.binaryData
        85 -> audioFile.audioHeader.format
        86 -> audioFile.audioHeader.trackLength
        87 -> audioFile.audioHeader.sampleRate.toInt()
        88 -> audioFile.audioHeader.encodingType
        else -> throw Exception("[getExtraInfo] gave a value that don't exist!")
    }
}