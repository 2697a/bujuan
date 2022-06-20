import Flutter
import UIKit
import MediaPlayer

public class SwiftOnAudioQueryPlugin: NSObject, FlutterPlugin {
    
    // Dart <-> Swift communication.
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.lucasjosino.on_audio_query", binaryMessenger: registrar.messenger())
        let instance = SwiftOnAudioQueryPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        // This is a basic permission handler, will return [true] if has permission and
        // [false] if don't.
        //
        // The others status will be ignored and replaced with [false].
        case "permissionsStatus":
            result(checkPermission())
        // The same as [permissionStatus], this is a basic permission handler and will only
        // return [true] or [false].
        //
        // When adding the necessary [permissions] inside [Info.plist], [IOS] will automatically
        // request but, in any case, you can call this method.
        case "permissionsRequest":
            MPMediaLibrary.requestAuthorization { status in
                if (status == .authorized) {
                    result(true)
                } else {
                    result(false)
                }
            }
        // Some basic information about the platform, in this case, [IOS]
        //   * Model (Only return the "type", like: IPhone, MacOs, IPod..)
        //   * Version (IOS version)
        //   * Type (IOS)
        case "queryDeviceInfo":
            queryDeviceInfo(result: result)
        default:
            //
            OnAudioController(call: call, result: result).chooseMethod()
        }
    }
    
    public func checkPermission() -> Bool {
        let permissionStatus = MPMediaLibrary.authorizationStatus()
        if permissionStatus == MPMediaLibraryAuthorizationStatus.authorized {
            return true
        } else {
            return false
        }
    }
}
