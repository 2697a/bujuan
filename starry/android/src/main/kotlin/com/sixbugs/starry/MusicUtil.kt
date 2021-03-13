package com.sixbugs.starry

import android.annotation.SuppressLint
import android.content.Context
import android.provider.MediaStore
import snow.player.audio.MusicItem

class MusicUtil {
    companion object {
        @SuppressLint("Recycle")
        fun getMusicData(context:Context): ArrayList<MusicItem> {
            var musicList = ArrayList<MusicItem>()
            val cursor = context.contentResolver.query(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI, null, null, null, MediaStore.Audio.Media.IS_MUSIC)
            if(cursor!=null){
                while (cursor.moveToNext()){
                    val musicItem = MusicItem()
                    musicItem.title = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.TITLE))
                    musicItem.artist = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.ARTIST))
                    musicItem.album = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.ALBUM))
                    musicItem.uri = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.DATA))
                    musicItem.duration = cursor.getInt(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.DURATION))
                    musicList.add(musicItem)
                }
            }
            return musicList
        }
    }

}