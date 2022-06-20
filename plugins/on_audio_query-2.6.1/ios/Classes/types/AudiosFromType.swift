import MediaPlayer

func checkAudiosFrom(type: Int, where: Any) -> MPMediaQuery? {
    var filter: MPMediaPropertyPredicate? = nil
    let query = MPMediaQuery.songs()
    switch type {
    case 0:
        filter = MPMediaPropertyPredicate.init(value: `where`, forProperty: MPMediaItemPropertyAlbumTitle)
    case 1:
        filter = MPMediaPropertyPredicate.init(value: `where`, forProperty: MPMediaItemPropertyAlbumPersistentID)
    case 2:
        filter = MPMediaPropertyPredicate.init(value: `where`, forProperty: MPMediaItemPropertyArtist)
    case 3:
        filter = MPMediaPropertyPredicate.init(value: `where`, forProperty: MPMediaItemPropertyArtistPersistentID)
    case 4:
        filter = MPMediaPropertyPredicate.init(value: `where`, forProperty: MPMediaItemPropertyGenre)
    case 5:
        filter = MPMediaPropertyPredicate.init(value: `where`, forProperty: MPMediaItemPropertyGenrePersistentID)
    default:
        return nil
    }
    if filter == nil {
        return nil
    }
    query.addFilterPredicate(filter!)
    return query
}
