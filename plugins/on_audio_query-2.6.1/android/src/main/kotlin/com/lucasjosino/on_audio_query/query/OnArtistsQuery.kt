package com.lucasjosino.on_audio_query.query

import android.content.ContentResolver
import android.content.Context
import android.net.Uri
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.lucasjosino.on_audio_query.OnAudioQueryPlugin
import com.lucasjosino.on_audio_query.query.helper.OnAudioHelper
import com.lucasjosino.on_audio_query.types.checkArtistsUriType
import com.lucasjosino.on_audio_query.types.sorttypes.checkArtistSortType
import com.lucasjosino.on_audio_query.utils.artistProjection
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

/** OnArtistsQuery */
class OnArtistsQuery : ViewModel() {

    //Main parameters
    private val helper = OnAudioHelper()

    // None of this methods can be null.
    private lateinit var uri: Uri
    private lateinit var resolver: ContentResolver
    private lateinit var sortType: String

    /**
     * Method to "query" all artists.
     *
     * Parameters:
     *   * [context]
     *   * [result]
     *   * [call]
     */
    fun queryArtists(context: Context, result: MethodChannel.Result, call: MethodCall) {
        resolver = context.contentResolver

        // Sort: Type and Order
        sortType = checkArtistSortType(
            call.argument<Int>("sortType"),
            call.argument<Int>("orderType")!!,
            call.argument<Boolean>("ignoreCase")!!
        )
        // Check uri:
        //   * [0]: External.
        //   * [1]: Internal.
        uri = checkArtistsUriType(call.argument<Int>("uri")!!)

        // Query everything in background for a better performance.
        viewModelScope.launch {
            // Request permission status from the main method.
            val hasPermission = OnAudioQueryPlugin().onPermissionStatus(context)
            // Empty list.
            var resultArtistList = ArrayList<MutableMap<String, Any?>>()

            // We cannot "query" without permission so, just return a empty list.
            if (hasPermission) {
                // Start querying
                resultArtistList = loadArtists()
            }

            //Flutter UI will start, but, information still loading
            result.success(resultArtistList)
        }
    }

    // Loading in Background
    private suspend fun loadArtists(): ArrayList<MutableMap<String, Any?>> =
        withContext(Dispatchers.IO) {
            // Setup the cursor with [uri], [projection] and [sortType].
            val cursor = resolver.query(uri, artistProjection, null, null, sortType)
            // Empty list.
            val artistList: ArrayList<MutableMap<String, Any?>> = ArrayList()

            // For each item(artist) inside this "cursor", take one and "format"
            // into a [Map<String, dynamic>].
            while (cursor != null && cursor.moveToNext()) {
                val tempData: MutableMap<String, Any?> = HashMap()
                for (artistMedia in cursor.columnNames) {
                    tempData[artistMedia] = helper.loadArtistItem(artistMedia, cursor)
                }

                artistList.add(tempData)
            }

            // Close cursor to avoid memory leaks.
            cursor?.close()
            // After finish the "query", go back to the "main" thread(You can only call flutter
            // inside the main thread).
            return@withContext artistList
        }
}

//Extras:

//I/OnArtistCursor[All/Audio]: [
// _id
// artist
// artist_key
// number_of_albums
// number_of_tracks
// ]