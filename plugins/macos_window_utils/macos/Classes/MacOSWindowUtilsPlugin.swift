import Cocoa
import FlutterMacOS

public class MacOSWindowUtilsPlugin: NSObject, FlutterPlugin {
    private var registrar: FlutterPluginRegistrar!;
    private var windowManipulatorChannel: FlutterMethodChannel!
    private var nsWindowDelegateChannel: FlutterMethodChannel!
    
    private static func printUnsupportedMacOSVersionWarning() {
        print("Warning: This feature is not supported on your macOS version.")
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let windowManipulatorChannel = FlutterMethodChannel(name: "macos_window_utils/window_manipulator", binaryMessenger: registrar.messenger)
        let nsWindowDelegateChannel = FlutterMethodChannel(name: "macos_window_utils/ns_window_delegate", binaryMessenger: registrar.messenger)
        
        let instance = MacOSWindowUtilsPlugin(registrar, windowManipulatorChannel: windowManipulatorChannel, nsWindowDelegateChannel: nsWindowDelegateChannel)
        registrar.addMethodCallDelegate(instance, channel: windowManipulatorChannel)
    }
    
    public init(_ registrar: FlutterPluginRegistrar, windowManipulatorChannel: FlutterMethodChannel, nsWindowDelegateChannel: FlutterMethodChannel) {
        super.init()
        self.registrar = registrar
        self.windowManipulatorChannel = windowManipulatorChannel
        self.nsWindowDelegateChannel = nsWindowDelegateChannel
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let methodName: String = call.method
        let args: [String: Any] = call.arguments as? [String: Any] ?? [:]
        
        switch (methodName) {
        case "initialize":
            let enableWindowDelegate = args["enableWindowDelegate"] as! Bool
            if (enableWindowDelegate) {
                MainFlutterWindowManipulator.createFlutterWindowDelegate(methodChannel: nsWindowDelegateChannel)
            }
            result(true)
            break
            
        case "setMaterial":
            if #available(macOS 10.14, *) {
                let materialID = args["material"] as! NSNumber
                let material = MaterialIDToMaterialConverter.getMaterialFromMaterialID(effectID: materialID)
                
                MainFlutterWindowManipulator.setMaterial(material: material)
            } else {
                MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
            }
            result(true)
            break
            
        case "enterFullscreen":
            MainFlutterWindowManipulator.enterFullscreen()
            result(true)
            break
            
        case "exitFullscreen":
            MainFlutterWindowManipulator.exitFullscreen()
            result(true)
            break
            
        case "overrideMacOSBrightness":
            if #available(macOS 10.14, *) {
                let dark = args["dark"] as! Bool
                
                MainFlutterWindowManipulator.setAppearance(dark: dark)
            } else {
                MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
            }
            result(true)
            break
            
        case "setDocumentEdited":
            MainFlutterWindowManipulator.setDocumentEdited()
            result(true)
            break
            
        case "setDocumentUnedited":
            MainFlutterWindowManipulator.setDocumentUnedited()
            result(true)
            break
            
        case "setRepresentedFile":
            let filename = args["filename"] as! String
            
            MainFlutterWindowManipulator.setRepresentedFilename(filename: filename)
            result(true)
            break
            
        case "setRepresentedURL":
            let url = args["url"] as! String
            
            MainFlutterWindowManipulator.setRepresentedFilename(filename: url)
            result(true)
            break
            
        case "getTitlebarHeight":
            let titlebarHeight = MainFlutterWindowManipulator.getTitlebarHeight() as NSNumber
            result(titlebarHeight)
            break
            
        case "hideTitle":
            MainFlutterWindowManipulator.hideTitle()
            result(true)
            break

        case "showTitle":
            MainFlutterWindowManipulator.showTitle()
            result(true)
            break

        case "makeTitlebarTransparent":
            MainFlutterWindowManipulator.makeTitlebarTransparent()
            result(true)
            break

        case "makeTitlebarOpaque":
            MainFlutterWindowManipulator.makeTitlebarOpaque()
            result(true)
            break

        case "enableFullSizeContentView":
            MainFlutterWindowManipulator.enableFullSizeContentView()
            result(true)
            break

        case "disableFullSizeContentView":
            MainFlutterWindowManipulator.disableFullSizeContentView()
            result(true)
            break

        case "zoomWindow":
            MainFlutterWindowManipulator.zoomWindow()
            result(true)
            break

        case "unzoomWindow":
            MainFlutterWindowManipulator.unzoomWindow()
            result(true)
            break

        case "isWindowZoomed":
            let isWindowZoomed = MainFlutterWindowManipulator.isWindowZoomed()
            result(isWindowZoomed)
            break

        case "isWindowFullscreened":
            let isWindowFullscreened = MainFlutterWindowManipulator.isWindowFullscreened()
            result(isWindowFullscreened)
            break

        case "hideZoomButton":
            MainFlutterWindowManipulator.hideZoomButton()
            result(true)
            break

        case "showZoomButton":
            MainFlutterWindowManipulator.showZoomButton()
            result(true)
            break

        case "hideMiniaturizeButton":
            MainFlutterWindowManipulator.hideMiniaturizeButton()
            result(true)
            break

        case "showMiniaturizeButton":
            MainFlutterWindowManipulator.showMiniaturizeButton()
            result(true)
            break

        case "hideCloseButton":
            MainFlutterWindowManipulator.hideCloseButton()
            result(true)
            break

        case "showCloseButton":
            MainFlutterWindowManipulator.showCloseButton()
            result(true)
            break

        case "enableZoomButton":
            MainFlutterWindowManipulator.enableZoomButton()
            result(true)
            break

        case "disableZoomButton":
            MainFlutterWindowManipulator.disableZoomButton()
            result(true)
            break

        case "enableMiniaturizeButton":
            MainFlutterWindowManipulator.enableMiniaturizeButton()
            result(true)
            break

        case "disableMiniaturizeButton":
            MainFlutterWindowManipulator.disableMiniaturizeButton()
            result(true)
            break

        case "enableCloseButton":
            MainFlutterWindowManipulator.enableCloseButton()
            result(true)
            break

        case "disableCloseButton":
            MainFlutterWindowManipulator.disableCloseButton()
            result(true)
            break

        case "isWindowInLiveResize":
            let isWindowInLiveResize = MainFlutterWindowManipulator.isWindowInLiveResize()
            result(isWindowInLiveResize)
            break

        case "setWindowAlphaValue":
            let alphaValue = args["value"] as! NSNumber
            MainFlutterWindowManipulator.setWindowAlphaValue(alphaValue: alphaValue as! CGFloat)
            result(true)
            break

        case "isWindowVisible":
            let isWindowVisible = MainFlutterWindowManipulator.isWindowVisible()
            result(isWindowVisible)
            break
            
        case "setWindowBackgroundColorToDefaultColor":
            MainFlutterWindowManipulator.setWindowBackgroundColorToDefaultColor()
            result(true)
            break
            
        case "setWindowBackgroundColorToClear":
            MainFlutterWindowManipulator.setWindowBackgroundColorToClear()
            result(true)
            break
            
        case "setNSVisualEffectViewState":
            let nsVisualEffectViewStateString = args["state"] as! String
            let state = nsVisualEffectViewStateString == "active"   ? NSVisualEffectView.State.active :
                        nsVisualEffectViewStateString == "inactive" ? NSVisualEffectView.State.inactive :
                                                                      NSVisualEffectView.State.followsWindowActiveState
            MainFlutterWindowManipulator.setNSVisualEffectViewState(state: state)
            result(true)
            break
            
        case "addVisualEffectSubview":
            let visualEffectSubview = VisualEffectSubview()
            let visualEffectSubviewId = MainFlutterWindowManipulator.addVisualEffectSubview(visualEffectSubview)
            
            if #available(macOS 10.14, *) {
                let properties = VisualEffectSubviewProperties.fromArgs(args)
                properties.applyToVisualEffectSubview(visualEffectSubview)
            } else {
                MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
            }
            
            result(visualEffectSubviewId)
            break
            
        case "updateVisualEffectSubviewProperties":
            let visualEffectSubviewId = args["visualEffectSubviewId"] as! UInt
            let visualEffectSubview = MainFlutterWindowManipulator.getVisualEffectSubview(visualEffectSubviewId)
            
            if (visualEffectSubview != nil) {
                if #available(macOS 10.14, *) {
                    let properties = VisualEffectSubviewProperties.fromArgs(args)
                    properties.applyToVisualEffectSubview(visualEffectSubview!)
                } else {
                    MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
                }
            }
            
            result(visualEffectSubview != nil)
            break
            
        case "removeVisualEffectSubview":
            let visualEffectSubviewId = args["visualEffectSubviewId"] as! UInt
            MainFlutterWindowManipulator.removeVisualEffectSubview(visualEffectSubviewId)
            
            result(true)
            break
            
        case "addToolbar":
            MainFlutterWindowManipulator.addToolbar()
            
            result(true)
            break
            
        case "removeToolbar":
            MainFlutterWindowManipulator.removeToolbar()
            
            result(true)
            break
            
        case "setToolbarStyle":
            let toolbarStyleName = args["toolbarStyle"] as! String
            
            if #available(macOS 11.0, *) {
                let toolbarStyle = ToolbarStyleNameToEnumConverter.getToolbarStyleFromName(name: toolbarStyleName)
                
                if toolbarStyle != nil {
                    MainFlutterWindowManipulator.setToolbarStyle(toolbarStyle: toolbarStyle!)
                }
            } else {
                MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
            }
            
            result(true)
            break
            
        case "enableShadow":
            MainFlutterWindowManipulator.enableShadow()

            result(true)
            break

        case "disableShadow":
            MainFlutterWindowManipulator.disableShadow()

            result(true)
            break

        case "invalidateShadows":
            MainFlutterWindowManipulator.invalidateShadows()

            result(true)
            break

        case "addEmptyMaskImage":
            MainFlutterWindowManipulator.addEmptyMaskImage()

            result(true)
            break

        case "removeMaskImage":
            MainFlutterWindowManipulator.removeMaskImage()

            result(true)
            break
            
        case "ignoreMouseEvents":
            MainFlutterWindowManipulator.ignoreMouseEvents()

            result(true)
            break
            
        case "acknowledgeMouseEvents":
            MainFlutterWindowManipulator.acknowledgeMouseEvents()

            result(true)
            break
            
        case "setSubtitle":
            let subtitle = args["subtitle"] as! String
            if #available(macOS 11.0, *) {
                MainFlutterWindowManipulator.setSubtitle(subtitle)
            } else {
                MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
            }

            result(true)
            break
            
        case "setLevel":
            let baseName = args["base"] as! String
            let offset = args["offset"] as! Int
            
            let baseLevel = LevelNameToLevelConverter.getLevelFromName(baseName)
            let level = NSWindow.Level(baseLevel.rawValue + offset)
            
            MainFlutterWindowManipulator.setLevel(level)
            
            result(true)
            
        case "orderOut":
            MainFlutterWindowManipulator.orderOut()
            result(true)
            
        case "orderBack":
            MainFlutterWindowManipulator.orderBack()
            result(true)
            
        case "orderFront":
            MainFlutterWindowManipulator.orderFront()
            result(true)
            
        case "orderFrontRegardless":
            MainFlutterWindowManipulator.orderFrontRegardless()
            result(true)
            
        case "insertIntoStyleMask":
            let styleMaskName = args["styleMask"] as! String
            let styleMask = StyleMaskNameToStyleMaskConverter.getStyleMaskFromName(styleMaskName)
            
            MainFlutterWindowManipulator.insertIntoStyleMask(styleMask)
            result(true)
            
        case "removeFromStyleMask":
            let styleMaskName = args["styleMask"] as! String
            let styleMask = StyleMaskNameToStyleMaskConverter.getStyleMaskFromName(styleMaskName)
            
            MainFlutterWindowManipulator.removeFromStyleMask(styleMask)
            result(true)
            
        case "removeFullScreenPresentationOptions":
            result(MainFlutterWindowManipulator.removeFullScreenPresentationOptions())
            
        case "addFullScreenPresentationOption":
            let presentationOptionName = args["presentationOption"] as! String
            let presentationOptions = PresentationOptionNameToPresentationOptionsConverter.getPresentationOptionsFromName(name: presentationOptionName)
            
            result(MainFlutterWindowManipulator.addFullScreenPresentationOptions(presentationOptions!))
            
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
}
