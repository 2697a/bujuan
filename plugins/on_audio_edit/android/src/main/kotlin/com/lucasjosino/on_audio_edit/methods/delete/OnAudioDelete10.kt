package com.lucasjosino.on_audio_edit.methods.delete

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.net.Uri
import android.util.Log
import androidx.documentfile.provider.DocumentFile
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.lucasjosino.on_audio_edit.utils.readBytes
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.jaudiotagger.audio.AudioFileIO
import org.jaudiotagger.audio.generic.Utils
import java.io.*

@SuppressLint("StaticFieldLeak")
class OnAudioDelete10(private val context: Context, private val activity: Activity) : ViewModel() {
    // TODO Fix all this mess

    // Main parameters
    private val channelError = "on_audio_error"
    private val onSharedPrefKeyUriCode = "on_audio_edit_uri"
    private lateinit var call: MethodCall

    // Check if plugin already has uri.
    private fun getUri() : String? = activity.getSharedPreferences("on_audio_edit",
            Context.MODE_PRIVATE).getString(onSharedPrefKeyUriCode, "")

    fun deleteArtwork10(result: MethodChannel.Result, call: MethodCall) {
        this.call = call

        // Do everything in background to avoid bad performance.
        viewModelScope.launch {
            // Start editing
            val resultDeleteArtwork = doEverythingInBackground()

            // Flutter UI will start, but, information still loading
            result.success(resultDeleteArtwork)
        }
    }

    @Suppress("BlockingMethodInNonBlockingContext")
    private suspend fun doEverythingInBackground() : Boolean = withContext(Dispatchers.IO) {
        val data = call.argument<String>("data")!!

        //
        val internalData = File(data)

        // Get and check if uri is null.
        val uriFolder = Uri.parse(getUri()) ?: return@withContext false

        // Use DocumentFile to navigate and find specific data inside specific folder.
        // We need this, cuz google blocked some access in Android >= 10/Q
        var pUri: Uri = Uri.parse("") // This can be null but, we use inside try / catch
        val dFile = DocumentFile.fromTreeUri(context, uriFolder)
        // [findFile] will give a slow performance, so, we use Kotlin Coroutines and "doEverythingInBackground"
        val fileList = dFile!!.findFile(internalData.name)
        if (fileList != null) pUri = fileList.uri

        // Temp file just to write(rewrite) file path. Produce the same result as "scan"
        val temp = File.createTempFile("tmp-media", '.' + Utils.getExtension(internalData))
        Utils.copy(internalData, temp)
        temp.deleteOnExit()

        // Setup audio edit
        val audioFile = AudioFileIO.read(File(data))
        val audioTag = audioFile.tag

        // Delete previous artwork
        audioTag.deleteArtworkField()

        audioFile.file = temp

        try {
            AudioFileIO.write(audioFile)
        } catch (e: Exception) { Log.i(channelError, e.toString()) }

        // Start setup to write in folder
        // Until this moment we only write inside audio file, but we need tell android that this file has some change.
        val fis = FileInputStream(temp)
        val audioContent = readBytes(fis)

        // Start writing in folder.
        try {
            context.contentResolver.openFileDescriptor(pUri, "rw")?.use { it ->
                FileOutputStream(it.fileDescriptor).use {
                    it.write(audioContent)
                    temp.delete()
                    return@withContext true
                }
            }
        } catch (e: Exception) {
            Log.i("on_audio_exception", e.toString())
            temp.delete()
            return@withContext false
        } catch (f: FileNotFoundException) {
            Log.i("on_audio_FileNotFound", f.toString())
            temp.delete()
            return@withContext false
        } catch (io: IOException) {
            Log.i("on_audio_IOException", io.toString())
            temp.delete()
            return@withContext false
        }

        // Delete temp folder.
        temp.delete()
        return@withContext false
    }

//    fun audioDelete10(result: MethodChannel.Result, call: MethodCall) {
//        val data = call.argument<String>("data")!!
//
//        //
//        val audioData = File(data)
//
//        if (audioData.exists()) {
//            try {
//
//            } catch (e: Exception) {
//                Log.i(channelError, "[audioDelete10] error trying deleting file -> $e")
//                result.success(false)
//            }
//        } else result.error(channelError, "[$audioData] file don't exist.", null)
//    }
}