package com.lucasjosino.on_audio_edit.methods.delete

import android.content.Context
import android.media.MediaScannerConnection
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.jaudiotagger.audio.AudioFileIO
import java.io.File

class OnAudioDelete(private val context: Context) {

    private val channelError = "on_audio_error"

    //
    fun deleteArtwork(result: MethodChannel.Result, call: MethodCall) {
        val data = call.argument<String>("data")!!

        // Setup audio edit
        val audioTag = AudioFileIO.read(File(data)).tag

        // Delete previous artwork
        audioTag.deleteArtworkField()

        // Android < 29/Q needs a scan file to show changes
        onScan(data, result)

        // Back to Dart
        result.success(true)
    }

    //
    fun deleteArtworks(result: MethodChannel.Result, call: MethodCall) {
        val data: ArrayList<String> = call.argument("data")!!

        // Looping until get the last path
        for (dataPath in data) {
            // Setup audio edit
            val audioTag = AudioFileIO.read(File(dataPath)).tag

            // Delete previous artwork
            audioTag.deleteArtworkField()

            // Android < 29/Q needs a scan file to show changes
            onScan(dataPath, result)
        }

        // Back to Dart
        result.success(true)
    }

    fun audioDelete(result: MethodChannel.Result, call: MethodCall) {
        val data = call.argument<String>("data")!!

        // Get file
        val audioData = File(data)

        // Check if exists
        if (audioData.exists()) {
            try {
                audioData.delete()
                result.success(true)
                // Android < 29/Q needs a scan file to show changes
                onScan(data, result)
            } catch (e: Exception) {
                Log.i(channelError, "[audioDelete] error trying deleting file -> $e")
                result.success(false)
            }
        } else result.error(channelError, "[$audioData] file don't exist.", null)
    }

    // Android < 29/Q needs a scan file to show changes
    private fun onScan(audio: String, result: MethodChannel.Result) {
        if (audio.isEmpty()) result.success(false)
        MediaScannerConnection.scanFile(context, arrayOf(audio), null) { _, _ -> }
    }
}