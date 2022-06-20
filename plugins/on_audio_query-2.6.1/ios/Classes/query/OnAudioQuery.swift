import Flutter
import MediaPlayer

class OnAudioQuery {
    var args: [String: Any]
    var result: FlutterResult
    
    init(call: FlutterMethodCall, result: @escaping FlutterResult) {
        // To make life easy, add all arguments inside a map.
        self.args = call.arguments as! [String: Any]
        self.result = result
    }
    
    func querySongs() {
        // The sortType.
        let sortType = args["sortType"] as? Int ?? 0
        
        // Choose the type(To match android side, let's call "cursor").
        let cursor = MPMediaQuery.songs()
        // Using native sort from [IOS] you can only use the [Title], [Album] and
        // [Artist]. The others will be sorted "manually" using [formatSongList] before
        // send to Dart.
        cursor.groupingType = checkSongSortType(sortType: sortType)
        
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
            loadSongs(cursor: cursor)
        } else {
            // There's no permission so, return empty to avoid crashes.
            result([])
        }
    }
    
    private func loadSongs(cursor: MPMediaQuery!) {
        DispatchQueue.global(qos: .userInitiated).async {
            var listOfSongs: [[String: Any?]] = Array()
            
            // For each item(song) inside this "cursor", take one and "format"
            // into a [Map<String, dynamic>], all keys are based on [Android]
            // platforms so, if you change some key, will have to change the [Android] too.
            for song in cursor.items! {
                // If the song file don't has a assetURL, is a Cloud item.
                if !song.isCloudItem && song.assetURL != nil {
                    let songData = loadSongItem(song: song)
                    listOfSongs.append(songData)
                }
            }
            
            // After finish the "query", go back to the "main" thread(You can only call flutter
            // inside the main thread).
            DispatchQueue.main.async {
                // Here we'll check the "custom" sort and define a order to the list.
                let finalList = formatSongList(args: self.args, allSongs: listOfSongs)
                self.result(finalList)
            }
        }
    }
}
