package com.lucasjosino.on_audio_query.controller

import android.content.Context
import android.util.Log
import com.lucasjosino.on_audio_query.query.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class OnAudioController(
    private val context: Context,
    private val call: MethodCall,
    private val result: MethodChannel.Result
) {

    //
    fun onAudioController() {
        when (call.method) {
            //Query methods
            "querySongs" -> OnAudiosQuery().querySongs(context, result, call)
            "queryAlbums" -> OnAlbumsQuery().queryAlbums(context, result, call)
            "queryArtists" -> OnArtistsQuery().queryArtists(context, result, call)
            "queryPlaylists" -> OnPlaylistQuery().queryPlaylists(context, result, call)
            "queryGenres" -> OnGenresQuery().queryGenres(context, result, call)
            "queryArtwork" -> OnArtworksQuery().queryArtwork(context, result, call)
            "queryAudiosFrom" -> OnAudiosFromQuery().querySongsFrom(context, result, call)
            "queryWithFilters" -> OnWithFiltersQuery().queryWithFilters(context, result, call)
            "queryAllPath" -> OnAllPathQuery().queryAllPath(context, result)
            //Playlists methods
            "createPlaylist" -> OnPlaylistsController().createPlaylist(context, result, call)
            "removePlaylist" -> OnPlaylistsController().removePlaylist(context, result, call)
            "addToPlaylist" -> OnPlaylistsController().addToPlaylist(context, result, call)
            "removeFromPlaylist" -> OnPlaylistsController().removeFromPlaylist(
                context,
                result,
                call
            )
            "renamePlaylist" -> OnPlaylistsController().renamePlaylist(context, result, call)
            "moveItemTo" -> OnPlaylistsController().moveItemTo(context, result, call)
        }
    }
}