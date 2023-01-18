package com.lucasjosino.on_audio_edit.methods.read

import com.lucasjosino.on_audio_edit.extensions.checkFlac
import com.lucasjosino.on_audio_edit.extensions.tryInt
import com.lucasjosino.on_audio_edit.types.checkTag
import com.lucasjosino.on_audio_edit.utils.checkAndGetExtraInfo
import com.lucasjosino.on_audio_edit.utils.getAllProjection
import com.lucasjosino.on_audio_edit.utils.getExtraInfo
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.jaudiotagger.audio.AudioFileIO
import org.jaudiotagger.tag.FieldKey
import java.io.File

class OnAudioRead {

    //
    fun readAudio(result: MethodChannel.Result, call: MethodCall) {
        // Get all information from Dart.
        val data = call.argument<String>("data")!!

        // Setup
        val audioData = File(data)
        val audioFile = AudioFileIO.read(audioData)
        val audioTag = audioFile.tag

        // Getting all tags
        val tagsData: MutableMap<String, Any?> = HashMap()
        for (tag in getAllProjection().checkFlac(data)) {
            val value = audioTag.getValue(tag, 0)
            if (!value.isNullOrEmpty()) {
                tagsData[tag.name] = value.tryInt(tag.ordinal)
            }
        }

        // Extra information
        tagsData.putAll(checkAndGetExtraInfo(audioFile))

        // Sending to Dart
        result.success(tagsData)
    }

    //
    fun readAudios(result: MethodChannel.Result, call: MethodCall) {
        val separateThread: Boolean = call.argument("separateThread")!!
        if (separateThread) {
            Thread {
                onReadAudios(result, call)
            }.start()
        } else {
            onReadAudios(result, call)
        }
    }

    private fun onReadAudios(result: MethodChannel.Result, call: MethodCall) {
        // Get all information from Dart.
        val data: ArrayList<String> = call.argument("data")!!

        // Getting all path
        val tagsList: ArrayList<MutableMap<String, Any?>> = ArrayList()

        // Looping until get the last path
        for (pathData in data) {
            // Setup
            val audioData = File(pathData)
            val audioFile = AudioFileIO.read(audioData)
            val audioTag = audioFile.tag

            // Getting all tags
            val tagsData: MutableMap<String, Any?> = HashMap()
            for (tag in getAllProjection().checkFlac(pathData)) {
                val value = audioTag.getValue(tag, 0)
                if (!value.isNullOrEmpty()) {
                    tagsData[tag.name] = value.tryInt(tag.ordinal)
                }
            }

            // Extra information
            tagsData.putAll(checkAndGetExtraInfo(audioFile))

            tagsList.add(tagsData)
        }
        // Sending to Dart
        result.success(tagsList)
    }

    //
    fun readSingleAudioTag(result: MethodChannel.Result, call: MethodCall) {
        // Get all information from Dart.
        val data = call.argument<String>("data")!!
        val tag = call.argument<Int>("tag")!!

        // Setup
        val audioData = File(data)
        val audioFile = AudioFileIO.read(audioData)
        val audioTag = audioFile.tag

        // Getting specific tag
        val resultTag = when (tag) {
            82 -> audioFile.audioHeader.bitRate.toInt()
            83 -> audioFile.audioHeader.channels
            84 -> audioTag.firstArtwork.binaryData
            85 -> audioFile.audioHeader.format
            86 -> audioFile.audioHeader.trackLength
            87 -> audioFile.audioHeader.sampleRate.toInt()
            88 -> audioFile.audioHeader.encodingType
            else -> {
                val value = audioTag.getValue(checkTag(tag), 0)
                if (!value.isNullOrEmpty()) {
                    value.tryInt(tag)
                } else null
            }
        }

        // Sending to Dart
        result.success(resultTag)
    }

    //
    fun readSpecificsAudioTags(result: MethodChannel.Result, call: MethodCall) {
        // Get all information from Dart.
        val data = call.argument<String>("data")!!
        val tags: ArrayList<Int> = call.argument("tags")!!

        // Converting int to FieldKey
        val getTags: ArrayList<FieldKey> = ArrayList()
        tags.forEach {
            if (checkTag(it) != null) getTags.add(checkTag(it)!!)
        }

        // Setup
        val audioData = File(data)
        val audioFile = AudioFileIO.read(audioData)
        val audioTag = audioFile.tag

        //
        val tagsData: MutableMap<String, Any> = HashMap()
        for (tag in getTags) tagsData[tag.name] = audioTag.getValue(tag, 0).orEmpty()

        // Adding extra info using the worst method :P
        tags.forEach {
            if (checkTag(it) == null) getExtraInfo(audioFile, it, audioTag)
        }

        // Sending to Dart
        result.success(tagsData)
    }


}