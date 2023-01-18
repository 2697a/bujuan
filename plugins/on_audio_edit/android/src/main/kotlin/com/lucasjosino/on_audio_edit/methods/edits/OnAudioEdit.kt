package com.lucasjosino.on_audio_edit.methods.edits

import android.content.Context
import android.media.MediaScannerConnection
import android.util.Log
import com.lucasjosino.on_audio_edit.types.checkTag
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.jaudiotagger.audio.AudioFileIO
import org.jaudiotagger.tag.FieldKey
import org.jaudiotagger.tag.TagOptionSingleton
import java.io.File
import java.util.*

class OnAudioEdit(private val context: Context) {

    // Main parameters
    private val channelError = "on_audio_error"
    private lateinit var getTagsAndInfo: MutableMap<FieldKey, Any>

    //
    fun editAudio(result: MethodChannel.Result, call: MethodCall) {
        // This will write in file removing all unnecessary info.
        TagOptionSingleton.getInstance().isId3v2PaddingWillShorten = true

        // Get all information from Dart.
        val data = call.argument<String>("data")!!
        val mapTagsAndInfo: MutableMap<Int, Any> = call.argument("tags")!!

        // Converting int to FieldKey
        val getTagsAndInfo: MutableMap<FieldKey, Any> = EnumMap(org.jaudiotagger.tag.FieldKey::class.java)
        mapTagsAndInfo.forEach { keyOrValue ->
            if (checkTag(keyOrValue.key) != null) getTagsAndInfo[checkTag(keyOrValue.key)!!] = keyOrValue.value
        }

        // Setup
        val audioData = File(data)
        val audioFile = AudioFileIO.read(audioData)
        val audioTag = audioFile.tag

        // Changing tags
        for (info in getTagsAndInfo) {
            // If value is null, ignore.
            val value = info.value.toString()
            if (value.isNotEmpty()) audioTag.setField(info.key, value)
        }

        // Try / Catch to avoid errors
        try {
            AudioFileIO.write(audioFile)
        } catch (e: Exception) { Log.i(channelError, e.toString()) ; result.success(false) }

        // Android < 29/Q needs a scan file to show changes
        onScan(data, result)

        // Sending to Dart
        result.success(true)
    }

    // Android < 29/Q needs a scan file to show changes
    private fun onScan(audio: String, result: MethodChannel.Result) {
        if (audio.isEmpty()) result.success(false)
        MediaScannerConnection.scanFile(context, arrayOf(audio), null) { _, _ -> }
    }

    // Edit Multiples Audios

    //
    fun editAudios(result: MethodChannel.Result, call: MethodCall) {
        // This will write in file removing all unnecessary info.
        TagOptionSingleton.getInstance().isId3v2PaddingWillShorten = true

        // Get all information from Dart.
        val data: ArrayList<String> = call.argument("data")!!
        val mapTagsAndInfo: ArrayList<MutableMap<Int, Any>> = call.argument("tags")!!

        // Get each map inside list
        mapTagsAndInfo.forEach { it1 ->
            this.getTagsAndInfo = EnumMap(org.jaudiotagger.tag.FieldKey::class.java)

            // Get each info inside map
            it1.forEach { it2 ->
                if (checkTag(it2.key) != null) getTagsAndInfo[checkTag(it2.key)!!] = it2.value
            }

            // Looping until get the last path
            for (pathData in data) {
                // Setup
                val audioData = File(pathData)
                val audioFile = AudioFileIO.read(audioData)
                val audioTag = audioFile.tag

                // Changing tags
                for (info in getTagsAndInfo) {
                    audioTag.setField(info.key, info.value.toString())
                }

                // Try / Catch to avoid errors
                try {
                    AudioFileIO.write(audioFile)
                } catch (e: Exception) { Log.i(channelError, e.toString()) ; result.success(false) }

                // Android < 29/Q needs a scan file to show changes
                onScan(pathData, result)
            }

            // Sending to Dart
            result.success(true)
        }
    }
}