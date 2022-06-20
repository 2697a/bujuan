import Flutter
import MediaPlayer

class OnPlaylistsQuery {
    var args: [String: Any]
    var result: FlutterResult
    
    init(call: FlutterMethodCall, result: @escaping FlutterResult) {
        // To make life easy, add all arguments inside a map.
        self.args = call.arguments as! [String: Any]
        self.result = result
    }
    
    func queryPlaylists() {
        // Choose the type(To match android side, let's call "cursor").
        let cursor = MPMediaQuery.playlists()
        
        // TODO: Add sort type to [queryPlaylists].
        
        // This filter will avoid audios/songs outside phone library(cloud).
        let cloudFilter = MPMediaPropertyPredicate.init(
            value: false,
            forProperty: MPMediaItemPropertyIsCloudItem
        )
        cursor.addFilterPredicate(cloudFilter)
        
        // We cannot "query" without permission so, just return a empty list.
        let hasPermission = SwiftOnAudioQueryPlugin().checkPermission()
        if hasPermission {
            // Query everything in background for a better performance.
            loadPlaylists(cursor: cursor.collections)
        } else {
            // There's no permission so, return empty to avoid crashes.
            result([])
        }
    }
    
    private func loadPlaylists(cursor: [MPMediaItemCollection]!) {
        DispatchQueue.global(qos: .userInitiated).async {
            var listOfPlaylists: [[String: Any?]] = Array()
            
            // For each item(playlist) inside this "cursor", take one and "format"
            // into a [Map<String, dynamic>], all keys are based on [Android]
            // platforms so, if you change some key, will have to change the [Android] too.
            for playlist in cursor {
                // If the first song file don't has a assetURL, is a Cloud item.
                if !playlist.items[0].isCloudItem && playlist.items[0].assetURL != nil {
                    var playlistData = loadPlaylistItem(playlist: playlist)
                    
                    // Count and add the number of songs for every genre.
                    let tmpMediaCount = getMediaCount(type: 1, id: playlistData["_id"] as! UInt64)
                    playlistData["num_of_songs"] = tmpMediaCount
                    
                    listOfPlaylists.append(playlistData)
                }
            }
            
            // After finish the "query", go back to the "main" thread(You can only call flutter
            // inside the main thread).
            DispatchQueue.main.async {
                // TODO: Add sort type to [queryPlaylists].
                self.result(listOfPlaylists)
            }
        }
    }
}
