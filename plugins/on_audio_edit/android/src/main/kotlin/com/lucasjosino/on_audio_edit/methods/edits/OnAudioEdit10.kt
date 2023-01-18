package com.lucasjosino.on_audio_edit.methods.edits

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.net.Uri
import android.util.Log
import androidx.documentfile.provider.DocumentFile
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.lucasjosino.on_audio_edit.types.checkTag
import com.lucasjosino.on_audio_edit.utils.readBytes
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.jaudiotagger.audio.AudioFileIO
import org.jaudiotagger.audio.generic.Utils
import org.jaudiotagger.tag.FieldKey
import org.jaudiotagger.tag.TagOptionSingleton
import java.io.*
import java.util.*

@SuppressLint("StaticFieldLeak")
class OnAudioEdit10(private val context: Context, private val activity: Activity) : ViewModel() {

    // Main parameters
    private val channelError = "on_audio_error"
    private val onSharedPrefKeyUriCode = "on_audio_edit_uri"
    private var searchInsideFolders: Boolean = false
    private lateinit var data: String
    private lateinit var getTagsAndInfo: MutableMap<FieldKey, Any>

    // Edit File to Android >= 29/Q/10

    // Check if plugin already has uri.
    private fun getUri(): String? = activity.getSharedPreferences(
        "on_audio_edit",
        Context.MODE_PRIVATE
    ).getString(onSharedPrefKeyUriCode, "")

    // Android 10 has a bug on Storage system, to edit some audio we need ask user permission on specific folder.
    // This extra permission has already been accepted (OnAudioEditPlugin.kt -> openTree()) at this moment and uri it's already saved.
    // Every time we need to edit some audio file, will use this uri with android DocumentFile.
    fun editAudio10(result: MethodChannel.Result, call: MethodCall) {
        // This will write in file removing all unnecessary info.
        TagOptionSingleton.getInstance().isId3v2PaddingWillShorten = true

        // Get all information from Dart.
        this.data = call.argument<String>("data")!!
        this.searchInsideFolders = call.argument<Boolean>("searchInsideFolders")!!
        val mapTagsAndInfo: MutableMap<Int, Any> = call.argument("tags")!!

        // Converting int to FieldKey
        this.getTagsAndInfo = EnumMap(FieldKey::class.java)
        mapTagsAndInfo.forEach { keyOrValue ->
            if (checkTag(keyOrValue.key) != null) getTagsAndInfo[checkTag(keyOrValue.key)!!] =
                keyOrValue.value
        }

        // Do everything in background to avoid bad performance.
        viewModelScope.launch {
            // Start editing
            val resultBackground = doEverythingInBackground()

            //Flutter UI will start, but, UI is available
            result.success(resultBackground)
        }
    }

    @Suppress("BlockingMethodInNonBlockingContext")
    private suspend fun doEverythingInBackground(): Boolean = withContext(Dispatchers.IO) {
        val internalData = File(data)

        // At this point, we already requested the 'special' path to user folder.
        // If not, return false and a warn.
        if (getUri() == null) {
            Log.w("on_audio_exception", "Uri to folder path doesn't exist!")
            return@withContext false
        }

        // Get the 'extra' uri.
        val uriFolder: Uri = Uri.parse(getUri())

        // Use DocumentFile to navigate and find specific data inside specific folder.
        // We need this, cuz google blocked some access in Android >= 10/Q
        val pUri: Uri
        val dFile = DocumentFile.fromTreeUri(context, uriFolder) ?: return@withContext false
        // [getFile] will give a slow performance, so, we use Kotlin Coroutines and "doEverythingInBackground"
        val file = getFile(dFile, internalData)?.uri

        //
        if (file == null) {
            Log.w(
                "on_audio_exception",
                "File: $data not found!\n " +
                        "Call [resetComplexPermission] and let the user choose the \"Root\" folder."
            )
            return@withContext false
        }

        // After checking that [file] is valid, keep the editing.
        pUri = file

        // Temp file just to write(rewrite) file path. Produce the same result as "scan"
        val temp = File.createTempFile("tmp-media", '.' + Utils.getExtension(internalData))
        Utils.copy(internalData, temp)
        temp.deleteOnExit()

        // Setup audio edit
        val audioFile = AudioFileIO.read(internalData)
        val audioTag = audioFile.tag
        // Setting tags
        for (info in getTagsAndInfo) {
            // If value is null, ignore.
            val value = "${info.value}"
            if (value.isNotEmpty()) audioTag.setField(info.key, value)
        }
        audioFile.file = temp

        try {
            AudioFileIO.write(audioFile)
        } catch (e: Exception) {
            Log.i(channelError, "$e")
        }

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
            Log.i("on_audio_exception", "$e")
        } catch (f: FileNotFoundException) {
            Log.i("on_audio_FileNotFound", "$f")
        } catch (io: IOException) {
            Log.i("on_audio_IOException", "$io")
        }

        // Delete temp folder.
        temp.delete()
        return@withContext false
    }

    private fun getFile(directory: DocumentFile, specificFile: File): DocumentFile? {
        val files = directory.listFiles()
        for (file in files) {
            val data: DocumentFile? = if (file.isDirectory) {
                // If [searchInsideFolders] is true, we keep searching, if not, no file was found.
                if (searchInsideFolders) getFile(file, specificFile) else return null
            } else {
                if (file.name == specificFile.name) file else null
            }
            if (data != null) return data
        }
        return null
    }

    // TODO Edit Multiples Audios on Android >= 29/Q/10

//    fun editAudios10(result: MethodChannel.Result, call: MethodCall) {
//        val data: ArrayList<String> = call.argument("data")!!
//        val mapTagsAndInfo: ArrayList<MutableMap<Int, Any>> = call.argument("tags")!!
//
//        //
//        mapTagsAndInfo.forEach { it1 ->
//            val getTagsAndInfo: MutableMap<FieldKey, Any> = EnumMap(org.jaudiotagger.tag.FieldKey::class.java)
//            it1.forEach { it2 ->
//                getTagsAndInfo[checkTag(it2.key)] = it2.value
//            }
//
//            for (pathData in data) {
//                val pathDataFile = File(pathData)
//                //
//                val uriFolder = Uri.parse(getUri())
//                if (uriFolder == null) result.error(channelError, "Uri is null", null)
//
//                var pUri: Uri = Uri.parse("")
//                val dFile = DocumentFile.fromTreeUri(context, uriFolder)
//                val fileList = dFile!!.listFiles()
//                for (i in fileList) {
//                    if (pathData == i.name) {
//                        pUri = i.uri
//                    }
//                }
//
////                if (pUri.path?.isEmpty() == true) throw Exception("File path not found") ; result.success(false)
//
//                //
//                val temp = File.createTempFile("tmp-media", '.' + Utils.getExtension(pathDataFile))
//                Utils.copy(pathDataFile, temp)
//                temp.deleteOnExit()
//
//                // Setup
//                val audioData = File(pathData)
//                val audioFile = AudioFileIO.read(audioData)
//                val audioTag = audioFile.tag
//                // Changing tags
//                for (info in getTagsAndInfo) {
//                    audioTag.setField(info.key, info.value.toString())
//                }
//                audioFile.file = temp
//
//                // Try/Catch to avoid big errors
//                try {
//                    AudioFileIO.write(audioFile)
//                } catch (e: Exception) { Log.i(channelError, e.toString()) ; result.success(false) }
//
//                //
//                val fis = FileInputStream(temp)
//                val audioContent = readBytes(fis)
//
//                //
//                try {
//                    context.contentResolver.openFileDescriptor(pUri, "rw")?.use { it ->
//                        FileOutputStream(it.fileDescriptor).use {
//                            it.write(audioContent)
//                        }
//                    }
//                } catch (e: Exception) {
//                    Log.i("on_audio_exception", e.toString())
//                } catch (f: FileNotFoundException) {
//                    Log.i("on_audio_FileNotFound", f.toString())
//                } catch (io: IOException) {
//                    Log.i("on_audio_IOException", io.toString())
//                }
//
//                temp.delete()
//            }
//            // Sending to Dart
//            result.success(true)
//        }
//    }
}