import Flutter
import MediaPlayer

class OnAlbumsQuery {
    var args: [String: Any]
    var result: FlutterResult
    
    init(call: FlutterMethodCall, result: @escaping FlutterResult) {
        // To make life easy, add all arguments inside a map.
        self.args = call.arguments as! [String: Any]
        self.result = result
    }
    
    func queryAlbums() {
        // The sortType, this method will never be will.
        let sortType = args["sortType"] as? Int ?? 0
        
        // Choose the type(To match android side, let's call "cursor").
        let cursor = MPMediaQuery.albums()
        // Using native sort from [IOS] you can only use the [Album] and [Artist].
        // The others will be sorted "manually" using [formatAlbumList] before
        // send to Dart.
        cursor.groupingType = checkAlbumSortType(sortType: sortType)
        
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
            loadAlbums(cursor: cursor.collections)
        } else {
            // There's no permission so, return empty to avoid crashes.
            result([])
        }
    }
    
    private func loadAlbums(cursor: [MPMediaItemCollection]!) {
        DispatchQueue.global(qos: .userInitiated).async {
            var listOfAlbums: [[String: Any?]] = Array()
            
            // For each item(album) inside this "cursor", take one and "format"
            // into a [Map<String, dynamic>], all keys are based on [Android]
            // platforms so, if you change some key, will have to change the [Android] too.
            for album in cursor {
                if !album.items[0].isCloudItem && album.items[0].assetURL != nil {
                    let albumData = loadAlbumItem(album: album)
                    listOfAlbums.append(albumData)
                }
            }
            
            // After finish the "query", go back to the "main" thread(You can only call flutter
            // inside the main thread).
            DispatchQueue.main.async {
                // Here we'll check the "custom" sort and define a order to the list.
                let finalList = formatAlbumList(args: self.args, allAlbums: listOfAlbums)
                self.result(finalList)
            }
        }
    }
}
