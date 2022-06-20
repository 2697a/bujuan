package com.lucasjosino.on_audio_query.query

import android.annotation.SuppressLint
import android.content.ContentResolver
import android.content.Context
import android.net.Uri
import android.provider.MediaStore
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.lucasjosino.on_audio_query.OnAudioQueryPlugin
import com.lucasjosino.on_audio_query.query.helper.OnAudioHelper
import com.lucasjosino.on_audio_query.types.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class OnWithFiltersQuery : ViewModel() {

    //Main parameters
    private val helper = OnAudioHelper()
    private val uri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
    private var projection: Array<String>? = arrayOf()

    @SuppressLint("StaticFieldLeak")
    // None of this methods can be null.
    private lateinit var context: Context
    private lateinit var resolver: ContentResolver
    private lateinit var withType: Uri
    private lateinit var argsVal: String
    private lateinit var argsKey: String

    //
    fun queryWithFilters(context: Context, result: MethodChannel.Result, call: MethodCall) {
        this.context = context; resolver = context.contentResolver

        // Choose the type.
        //   * [0]: Audios
        //   * [1]: Albums
        //   * [2]: Playlists
        //   * [3]: Artists
        //   * [4]: Genres
        withType = checkWithFiltersType(call.argument<Int>("withType")!!)

        // The [args] are converted to [String] before send to [MethodChannel].
        argsVal = "%" + call.argument<String>("argsVal")!! + "%"

        // A dynamic [projection] to every type of "query".
        projection = checkProjection(withType)

        // Choose the [arg].
        argsKey = when (withType) {
            MediaStore.Audio.Media.EXTERNAL_CONTENT_URI -> checkSongsArgs(call.argument<Int>("args")!!)
            MediaStore.Audio.Albums.EXTERNAL_CONTENT_URI -> checkAlbumsArgs(call.argument<Int>("args")!!)
            MediaStore.Audio.Playlists.EXTERNAL_CONTENT_URI -> checkPlaylistsArgs(
                call.argument<Int>(
                    "args"
                )!!
            )
            MediaStore.Audio.Artists.EXTERNAL_CONTENT_URI -> checkArtistsArgs(call.argument<Int>("args")!!)
            MediaStore.Audio.Genres.EXTERNAL_CONTENT_URI -> checkGenresArgs(call.argument<Int>("args")!!)
            else -> throw Exception("[argsKey] returned null. Report this issue on [on_audio_query] GitHub.")
        }

        // Query everything in background for a better performance.
        viewModelScope.launch {
            // Request permission status from the main method.
            val hasPermission = OnAudioQueryPlugin().onPermissionStatus(context)
            // Empty list.
            var resultWithFilter = ArrayList<MutableMap<String, Any?>>()

            // We cannot "query" without permission so, just return a empty list.
            if (hasPermission) {
                // Start querying
                resultWithFilter = loadWithFilters()
            }

            //Flutter UI will start, but, information still loading
            result.success(resultWithFilter)
        }
    }

    //Loading in Background
    private suspend fun loadWithFilters(): ArrayList<MutableMap<String, Any?>> =
        withContext(Dispatchers.IO) {
            // Setup the cursor with [uri], [projection], [argsKey] and [argsVal].
            val cursor = resolver.query(withType, projection, argsKey, arrayOf(argsVal), null)
            // Empty list.
            val withFiltersList: ArrayList<MutableMap<String, Any?>> = ArrayList()

            // For each item inside this "cursor", take one and "format"
            // into a [Map<String, dynamic>].
            while (cursor != null && cursor.moveToNext()) {
                val tempData: MutableMap<String, Any?> = HashMap()
                for (media in cursor.columnNames) {
                    tempData[media] = helper.chooseWithFilterType(
                        withType,
                        media,
                        cursor
                    )
                }

                // If [withType] is a song media, add the extra information.
                if (withType == MediaStore.Audio.Media.EXTERNAL_CONTENT_URI) {
                    //Get a extra information from audio, e.g: extension, uri, etc..
                    val tempExtraData = helper.loadSongExtraInfo(uri, tempData)
                    tempData.putAll(tempExtraData)
                }

                withFiltersList.add(tempData)
            }

            // Close cursor to avoid memory leaks.
            cursor?.close()
            // After finish the "query", go back to the "main" thread(You can only call flutter
            // inside the main thread).
            return@withContext withFiltersList
        }
}