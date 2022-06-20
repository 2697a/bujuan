package com.lucasjosino.on_audio_query.utils

import android.os.Build
import io.flutter.plugin.common.MethodChannel

fun queryDeviceInfo(result: MethodChannel.Result) {
    val deviceData: MutableMap<String, Any> = HashMap()
    deviceData["device_model"] = Build.MODEL
    deviceData["device_sys_version"] = Build.VERSION.SDK_INT
    deviceData["device_sys_type"] = "Android"
    result.success(deviceData)
}