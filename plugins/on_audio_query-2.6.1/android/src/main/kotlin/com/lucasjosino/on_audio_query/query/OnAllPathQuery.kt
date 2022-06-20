package com.lucasjosino.on_audio_query.query

import android.content.ContentResolver
import android.content.Context
import android.net.Uri
import android.provider.MediaStore
import com.lucasjosino.on_audio_query.OnAudioQueryPlugin
import io.flutter.plugin.common.MethodChannel
import java.io.File

/** OnAllPathQuery */
class OnAllPathQuery {

    // Main parameters, none of this methods can be null.
    private val uri: Uri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
    private lateinit var resolver: ContentResolver

    /**
     * Method to "query" all paths.
     *
     * Parameters:
     *   * [context]
     *   * [result]
     */
    fun queryAllPath(context: Context, result: MethodChannel.Result) {
        this.resolver = context.contentResolver

        // Request permission status from the main method.
        val hasPermission = OnAudioQueryPlugin().onPermissionStatus(context)
        // Empty list.
        var resultAllPath = ArrayList<String>()

        // We cannot "query" without permission so, just return a empty list.
        if (hasPermission) {
            // Start querying
            resultAllPath = loadAllPath()
        }

        // Send to Dart.
        result.success(resultAllPath)
    }

    // Ignore the [Data] deprecation because this plugin support older versions.
    @Suppress("DEPRECATION")
    private fun loadAllPath(): ArrayList<String> {
        // Setup the cursor with [uri].
        val cursor = resolver.query(uri, null, null, null, null)
        // Empty list.
        val songPathList: ArrayList<String> = ArrayList()

        // For each item(path) inside this "cursor", take one and add to the list.
        while (cursor != null && cursor.moveToNext()) {
            val content = cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DATA))
            val path = File(content).parent
            // Check if path is null or if already exist inside list.
            if (path != null && !songPathList.contains(path)) songPathList.add(path)
        }

        // Close cursor to avoid memory leaks.
        cursor?.close()
        // After finish the "query", go back to the "main" thread(You can only call flutter
        // inside the main thread).
        return songPathList
    }
}