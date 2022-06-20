package com.lucasjosino.on_audio_query.interfaces

import android.content.Context

/** OnPermissionManagerInterface */
interface OnPermissionManagerInterface {
    fun onPermissionStatus(context: Context? = null) : Boolean
    fun onRequestPermission()
    fun onRetryRequestPermission()
}