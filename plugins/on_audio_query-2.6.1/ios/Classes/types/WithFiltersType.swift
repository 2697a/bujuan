import MediaPlayer

func checkSongsArgs(args: Int, argsVal: String) -> MPMediaPropertyPredicate {
    var filter: MPMediaPropertyPredicate? = nil
    switch args {
    case 0:
        filter = MPMediaPropertyPredicate.init(value: argsVal, forProperty: MPMediaItemPropertyTitle, comparisonType: .contains)
    case 1:
        print("[on_audio_warning] - IOS don't support [DISPLAY_NAME] type. Will be used the [TITLE]")
        filter = MPMediaPropertyPredicate.init(value: argsVal, forProperty: MPMediaItemPropertyTitle, comparisonType: .contains)
    case 2:
        filter = MPMediaPropertyPredicate.init(value: argsVal, forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: .contains)
    case 3:
        filter = MPMediaPropertyPredicate.init(value: argsVal, forProperty: MPMediaItemPropertyArtist, comparisonType: .contains)
    default:
        break
    }
    return filter!
}

func checkAlbumsArgs(args: Int, argsVal: String) -> MPMediaPropertyPredicate {
    var filter: MPMediaPropertyPredicate? = nil
    switch args {
    case 0:
        filter = MPMediaPropertyPredicate.init(value: argsVal, forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: .contains)
    case 1:
        filter = MPMediaPropertyPredicate.init(value: argsVal, forProperty: MPMediaItemPropertyAlbumArtist, comparisonType: .contains)
    default:
        break
    }
    return filter!
}

//Playlist

func checkArtistsArgs(args: Int, argsVal: String) -> MPMediaPropertyPredicate {
    var filter: MPMediaPropertyPredicate? = nil
    switch args {
    case 0:
        filter = MPMediaPropertyPredicate.init(value: argsVal, forProperty: MPMediaItemPropertyArtist, comparisonType: .contains)
    default:
        break
    }
    return filter!
}

func checkGenresArgs(args: Int, argsVal: String) -> MPMediaPropertyPredicate {
    var filter: MPMediaPropertyPredicate? = nil
    switch args {
    case 0:
        filter = MPMediaPropertyPredicate.init(value: argsVal, forProperty: MPMediaItemPropertyGenre, comparisonType: .contains)
    default:
        break
    }
    return filter!
}
