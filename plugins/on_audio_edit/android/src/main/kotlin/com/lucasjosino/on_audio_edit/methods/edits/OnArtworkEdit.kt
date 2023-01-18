package com.lucasjosino.on_audio_edit.methods.edits

import android.content.Context
import android.media.MediaScannerConnection
import android.net.Uri
import android.provider.MediaStore
import android.util.Log
import com.lucasjosino.on_audio_edit.utils.checkArtworkFormat
import com.lucasjosino.on_audio_edit.utils.convertFileSize
import com.lucasjosino.on_audio_edit.utils.warningSizeCall
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.jaudiotagger.audio.AudioFileIO
import org.jaudiotagger.tag.TagOptionSingleton
import org.jaudiotagger.tag.images.ArtworkFactory
import org.jaudiotagger.tag.reference.PictureTypes
import java.io.File
import kotlin.Exception

class OnArtworkEdit(private val context: Context) {

    // Main parameters
    private val channelError = "on_audio_error"

    //
    fun editArtwork(result: MethodChannel.Result, call: MethodCall, uri: Uri?) {
        // This will write in file removing all unnecessary info.
        TagOptionSingleton.getInstance().isId3v2PaddingWillShorten = true

        // Get all information from Dart.
        val data = call.argument<String>("data")!!
        val type = checkArtworkFormat(call.argument<Int>("type")!!)
        val description = call.argument<String>("description")!!
        val size = call.argument<Int>("size")!!
        val internalUri = uri ?: Uri.parse(call.argument<String>("imagePath")!!)

        // Setup audio edit
        val audioFile = AudioFileIO.read(File(data))
        val audioTag = audioFile.tag

        // Delete previous artwork
        audioTag.deleteArtworkField()

        // Getting image and creating artwork field
        val imageData = File(findImage(internalUri))
        val artwork = ArtworkFactory.createArtworkFromFile(imageData)

        // Setup Image
        artwork.pictureType = PictureTypes.DEFAULT_ID
        artwork.mimeType = type
        artwork.description = description
        artwork.height = size ; artwork.width = size

        //
        audioTag.setField(artwork)

        try {
            AudioFileIO.write(audioFile)
        } catch (e: Exception) { Log.i(channelError, e.toString()) }

        // Warning
        // 3 Types: size >= 6, size >= 10 or size >= 13.
        // I won't block the write but will at least warning.
        // TODO Show a warning after user choose a image, if is bigger than 3 - 4 MB.
        val audioSize = convertFileSize(audioFile.file.length())
        warningSizeCall(audioSize, data)

        // Android < 29/Q needs a scan file to show changes
        onScan(data, result)

        result.success(true)
    }

    @Suppress("DEPRECATION")
    //
    private fun findImage(uri: Uri) : String {
        val projection = arrayOf(MediaStore.Images.Media.DATA)
        val cursor = context.contentResolver.query(uri, projection, null, null, null)

        //
        var imageData = ""
        if (cursor != null) {
            cursor.moveToFirst()
            imageData = cursor.getString(0)
        }
        cursor?.close()
        return imageData
    }

    private fun onScan(audio: String, result: MethodChannel.Result) {
        if (audio.isEmpty()) result.success(false)
        MediaScannerConnection.scanFile(context, arrayOf(audio), null) { _, _ -> }
    }
}