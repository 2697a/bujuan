import Flutter
import MediaPlayer

class OnAudiosFromQuery {
    var args: [String: Any]
    var result: FlutterResult
    var type: Int = -1
    
    init(call: FlutterMethodCall, result: @escaping FlutterResult) {
        // To make life easy, add all arguments inside a map.
        self.args = call.arguments as! [String: Any]
        self.result = result
    }
    
    func queryAudiosFrom() {
        //
        self.type = args["type"] as! Int
        let wh3re = args["where"] as Any
        // The sortType.
        let sortType = args["sortType"] as? Int ?? 0
        
        // Choose the type(To match android side, let's call "cursor").
        var cursor: MPMediaQuery? = checkAudiosFrom(type: type, where: wh3re)
        
        // Using native sort from [IOS] you can only use the [Title], [Album] and
        // [Artist]. The others will be sorted "manually" using [formatSongList] before
        // send to Dart.
        cursor?.groupingType = checkSongSortType(sortType: sortType)
        
        // We cannot "query" without permission so, just return a empty list.
        let hasPermission = SwiftOnAudioQueryPlugin().checkPermission()
        if hasPermission {
            // Here we'll check if the request is to [Playlist] or other.
            if self.type != 6 && cursor != nil {
                
                // This filter will avoid audios/songs outside phone library(cloud).
                let cloudFilter = MPMediaPropertyPredicate.init(
                    value: false,
                    forProperty: MPMediaItemPropertyIsCloudItem
                )
                cursor?.addFilterPredicate(cloudFilter)
                
                // Query everything in background for a better performance.
                loadQueryAudiosFrom(cursor: cursor!)
            } else {
                // Query everything in background for a better performance.
                cursor = MPMediaQuery.playlists()
                
                // This filter will avoid audios/songs outside phone library(cloud).
                let cloudFilter = MPMediaPropertyPredicate.init(
                    value: false,
                    forProperty: MPMediaItemPropertyIsCloudItem
                )
                cursor?.addFilterPredicate(cloudFilter)
                
                loadSongsFromPlaylist(cursor: cursor!.collections)
            }
        } else {
            // There's no permission so, return empty to avoid crashes.
            result([])
        }
    }
    
    private func loadQueryAudiosFrom(cursor: MPMediaQuery!) {
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
    
    //Add a better code
    private func loadSongsFromPlaylist(cursor: [MPMediaItemCollection]!) {
        DispatchQueue.global(qos: .userInitiated).async {
            var listOfSongs: [[String: Any?]] = Array()
            
            // Here we need a different approach.
            //
            // First, query all playlists. After check if the argument is a:
            //   * [String]: The playlist [Name].
            //   * [Int]: The playlist [Id].
            //
            // Second, find the specific playlist using/comparing the argument.
            // After, query all item(song) from this playlist.
            for playlist in cursor {
                let iPlaylist = playlist as! MPMediaPlaylist
                let iWhere = self.args["where"] as Any
                //Using this check we can define if [where] is the [Playlist] name or id
                if iWhere is String {
                    //Check if playlist name is equal to defined name
                    if iPlaylist.name == iWhere as? String {
                        //For each song, format and add to the list
                        for song in playlist.items {
                            // If the song file don't has a assetURL, is a Cloud item.
                            if !song.isCloudItem && song.assetURL != nil {
                                let songData = loadSongItem(song: song)
                                listOfSongs.append(songData)
                            }
                        }
                    }
                } else {
                    //Check if playlist id is equal to defined id
                    if iPlaylist.persistentID == iWhere as! Int {
                        //For each song, format and add to the list
                        for song in playlist.items {
                            // If the song file don't has a assetURL, is a Cloud item.
                            if !song.isCloudItem && song.assetURL != nil {
                                let songData = loadSongItem(song: song)
                                listOfSongs.append(songData)
                            }
                        }
                    }
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
