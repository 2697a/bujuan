import Flutter
import MediaPlayer

class OnArtworkQuery {
    var args: [String: Any]
    var result: FlutterResult
    
    init(call: FlutterMethodCall, result: @escaping FlutterResult) {
        // To make life easy, add all arguments inside a map.
        self.args = call.arguments as! [String: Any]
        self.result = result
    }
    
    // [IOS] has a different artwork system and you can "query" using normal "querySongs, .."
    // [Android] can't "query" artwork at the same time as "querySongs", so we need to "query"
    // using a different method(queryArtwork).
    //
    // To match both [IOS] and [Android], [queryArtwork] is the only way to get artwork.
    //
    // Not the best solution but, at least here we can select differents formats and size.
    func queryArtwork() {
        // None of this arguments can be null.
        // The id of the [Song] or [Album].
        let id = args["id"] as! Int
        // The size of the image.
        let size = args["size"] as! Int
        // The size of the image.
        var quality = args["quality"] as! Int
        if (quality > 100) {
            quality = 100
        }
        // The format [JPEG] or [PNG].
        let format = args["format"] as! Int
        // The uri [0]: Song and [1]: Album.
        let uri = args["type"] as! Int
        
        // (To match android side, let's call "cursor").
        var cursor: MPMediaQuery?
        var filter: MPMediaPropertyPredicate?
        // If [uri] is 0: artwork from [Song]
        // If [uri] is 1: artwork from [Album]
        // If [uri] is 2: artwork from [Playlist]
        // If [uri] is 3: artwork from [Artist]
        switch uri {
        case 0:
            filter = MPMediaPropertyPredicate.init(value: id, forProperty: MPMediaItemPropertyPersistentID)
            cursor = MPMediaQuery.songs()
        case 1:
            filter = MPMediaPropertyPredicate.init(value: id, forProperty: MPMediaItemPropertyAlbumPersistentID)
            cursor = MPMediaQuery.albums()
        case 2:
            filter = MPMediaPropertyPredicate.init(value: id, forProperty: MPMediaPlaylistPropertyPersistentID)
            cursor = MPMediaQuery.playlists()
        case 3:
            filter = MPMediaPropertyPredicate.init(value: id, forProperty: MPMediaItemPropertyArtistPersistentID)
            cursor = MPMediaQuery.artists()
        case 4:
            filter = MPMediaPropertyPredicate.init(value: id, forProperty: MPMediaItemPropertyGenrePersistentID)
            cursor = MPMediaQuery.genres()
        default:
            filter = nil
            cursor = nil
        }
        
        // If [cursor] is "nil" or has no permission, just return to dart.
        let hasPermission = SwiftOnAudioQueryPlugin().checkPermission()
        if cursor != nil && filter != nil && hasPermission {
            cursor?.addFilterPredicate(filter!)
            
            // This filter will avoid audios/songs outside phone library(cloud).
            let cloudFilter = MPMediaPropertyPredicate.init(
                value: false,
                forProperty: MPMediaItemPropertyIsCloudItem
            )
            cursor?.addFilterPredicate(cloudFilter)
            
            // Query everything in background for a better performance.
            loadArtwork(cursor: cursor, size: size, format: format, uri: uri, quality: quality)
        } else {
            // There's no permission so, return null to avoid crashes.
            result(nil)
        }
    }
    
    private func loadArtwork(cursor: MPMediaQuery!, size: Int, format: Int, uri: Int, quality: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            var tempArtwork: Data?
            var tempItem: MPMediaItem?
            let fixedQuality = CGFloat(Double(quality) / 100.0)
            
            // If [uri] is 0: artwork is from [Song]
            // If [uri] is 1, 2 or 3: artwork is from [Album], [Playlist] or [Artist]
            if uri == 0 {
                // Since all id are unique, we can safely call the first item.
                tempItem = cursor!.items?.first
            } else {
                // Since all id are unique, we can safely call the first item.
                tempItem = cursor!.collections?.first?.items[0]
            }
            
            // If [format] is 0: will be [JPEG]
            // If [format] is 1: will be [PNG]
            if format == 0 {
                tempArtwork = tempItem?.artwork?.image(at: CGSize(width: size, height: size))?.jpegData(compressionQuality: fixedQuality)
            } else {
                // [PNG] format will return a high image quality.
                tempArtwork = tempItem?.artwork?.image(at: CGSize(width: size, height: size))?.pngData()
            }
            
            // After finish the "query", go back to the "main" thread(You can only call flutter
            // inside the main thread).
            DispatchQueue.main.async {
                // We don't need a "empty" image so, return null to avoid problems.
                if tempArtwork != nil && tempArtwork!.isEmpty {
                    tempArtwork = nil
                }
                self.result(tempArtwork)
            }
        }
    }
}
