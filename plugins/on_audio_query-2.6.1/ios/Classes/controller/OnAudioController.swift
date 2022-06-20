import Flutter

public class OnAudioController {
    var call: FlutterMethodCall
    var result: FlutterResult
    
    init(call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.call = call
        self.result = result
    }
    
    
    //This method will sort call according to request.
    public func chooseMethod() {
        // All necessary method to this plugin support both platforms, only playlists
        // are limited when using [IOS].
        switch call.method {
        case "querySongs":
            OnAudioQuery(call: call, result: result).querySongs()
        case "queryAlbums":
            OnAlbumsQuery(call: call, result: result).queryAlbums()
        case "queryArtists":
            OnArtistsQuery(call: call, result: result).queryArtists()
        case "queryGenres":
            OnGenresQuery(call: call, result: result).queryGenres()
        case "queryPlaylists":
            OnPlaylistsQuery(call: call, result: result).queryPlaylists()
        case "queryAudiosFrom":
            OnAudiosFromQuery(call: call, result: result).queryAudiosFrom()
        case "queryWithFilters":
            OnWithFiltersQuery(call: call, result: result).queryWithFilters()
        case "queryArtwork":
            OnArtworkQuery(call: call, result: result).queryArtwork()
        // The playlist for [IOS] is completely limited, the developer can only:
        //   * Create playlist
        //   * Add item to playlist (Unsuported, for now)
        //
        // Missing methods:
        //   * Rename playlist
        //   * Remove playlist
        //   * Remove item from playlist
        //   * Move item inside playlist
        case "createPlaylist":
            OnPlaylistsController(call: call, result: result).createPlaylist()
        case "addToPlaylist":
            OnPlaylistsController(call: call, result: result).addToPlaylist()
        default:
            // All non suported methods will throw this error.
            result(FlutterMethodNotImplemented)
        }
    }
}
