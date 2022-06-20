import Flutter

// TODO: Add more specific return to [Model].
// This method will get some basic information about platform.
public func queryDeviceInfo(result: FlutterResult) {
    let device = UIDevice.current
    let deviceData: [String: Any] = [
        "device_model": device.model,
        "device_sys_type": device.systemName,
        "device_sys_version": device.systemVersion,
    ]
    result(deviceData)
}

