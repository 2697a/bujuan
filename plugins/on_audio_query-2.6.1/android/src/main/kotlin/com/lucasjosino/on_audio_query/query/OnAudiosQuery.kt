package com.lucasjosino.on_audio_query.query

import android.annotation.SuppressLint
import android.content.ContentResolver
import android.content.Context
import android.net.Uri
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.lucasjosino.on_audio_query.OnAudioQueryPlugin
import com.lucasjosino.on_audio_query.query.helper.OnAudioHelper
import com.lucasjosino.on_audio_query.types.checkAudiosUriType
import com.lucasjosino.on_audio_query.types.sorttypes.checkSongSortType
import com.lucasjosino.on_audio_query.utils.songProjection
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

/** OnAudiosQuery */
class OnAudiosQuery : ViewModel() {

    // Main parameters
    private val helper = OnAudioHelper()
    private var selection: String? = null

    // None of this methods can be null.
    private lateinit var uri: Uri
    private lateinit var resolver: ContentResolver
    private lateinit var sortType: String

    @SuppressLint("StaticFieldLeak")
    private lateinit var context: Context


    /**
     * Method to "query" all songs.
     *
     * Parameters:
     *   * [context]
     *   * [result]
     *   * [call]
     */
    // Ignore the [Data] deprecation because this plugin support older versions.
    @Suppress("DEPRECATION")
    fun querySongs(
        context: Context,
        result: MethodChannel.Result,
        call: MethodCall
    ) {
        this.context = context; resolver = context.contentResolver

        // Sort: Type and Order.
        sortType = checkSongSortType(
            call.argument<Int>("sortType"),
            call.argument<Int>("orderType")!!,
            call.argument<Boolean>("ignoreCase")!!
        )
        // Check uri:
        //   * [0]: External.
        //   * [1]: Internal.
        uri = checkAudiosUriType(call.argument<Int>("uri")!!)
        // Here we provide a custom 'path'.
        if (call.argument<String>("path") != null) {
            val projection = songProjection()
            selection = projection[0] + " like " + "'%" + call.argument<String>("path") + "/%'"
        }

        // Query everything in background for a better performance.
        viewModelScope.launch {
            // Request permission status from the main method.
            val hasPermission = OnAudioQueryPlugin().onPermissionStatus(context)
            // Empty list.
            var resultSongList = ArrayList<MutableMap<String, Any?>>()

            // We cannot "query" without permission so, just return a empty list.
            if (hasPermission) {
                // Start querying
                resultSongList = loadSongs()
            }

            //Flutter UI will start, but, information still loading
            result.success(resultSongList)
        }
    }

    //Loading in Background
    private suspend fun loadSongs(): ArrayList<MutableMap<String, Any?>> =
        withContext(Dispatchers.IO) {

            // Setup the cursor with [uri], [projection] and [sortType].
            val cursor = resolver.query(uri, songProjection(), selection, null, sortType)
            // Empty list.
            val songList: ArrayList<MutableMap<String, Any?>> = ArrayList()

            // For each item(song) inside this "cursor", take one and "format"
            // into a [Map<String, dynamic>].
            while (cursor != null && cursor.moveToNext()) {
                val tempData: MutableMap<String, Any?> = HashMap()
                for (audioMedia in cursor.columnNames) {
                    tempData[audioMedia] = helper.loadSongItem(audioMedia, cursor)
                }

                //Get a extra information from audio, e.g: extension, uri, etc..
                val tempExtraData = helper.loadSongExtraInfo(uri, tempData)
                tempData.putAll(tempExtraData)

                songList.add(tempData)
            }

            // Close cursor to avoid memory leaks.
            cursor?.close()
            // After finish the "query", go back to the "main" thread(You can only call flutter
            // inside the main thread).
            return@withContext songList
        }
}

//Extras:

// * Query only audio > 60000 ms [1 minute]
// Obs: I don't think is a good idea, some audio "Non music" have more than 1 minute
//query(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI, projection, MediaStore.Audio.Media.DURATION +
// ">= 60000", null, checkSongSortType(sortType!!))

// * Query audio with limit, used for better performance in tests
//MediaStore.Audio.Media.TITLE + " LIMIT 4"

// * All projection types in android [Audio]
//I/AudioCursor[All]: [
// title_key,
// instance_id,
// duration,
// is_ringtone,
// album_artist,
// orientation,
// artist,
// height,
// is_drm,
// bucket_display_name,
// is_audiobook,
// owner_package_name,
// volume_name,
// title_resource_uri,
// date_modified,
// date_expires,
// composer,
// _display_name,
// datetaken,
// mime_type,
// is_notification,
// _id,
// year,
// _data,
// _hash,
// _size,
// album,
// is_alarm,
// title,
// track,
// width,
// is_music,
// album_key,
// is_trashed,
// group_id,
// document_id,
// artist_id,
// artist_key,
// is_pending,
// date_added,
// is_podcast,
// album_id,
// primary_directory,
// secondary_directory,
// original_document_id,
// bucket_id,
// bookmark,
// relative_path
// ]