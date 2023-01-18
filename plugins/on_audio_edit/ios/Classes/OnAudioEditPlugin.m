#import "OnAudioEditPlugin.h"
#if __has_include(<on_audio_edit/on_audio_edit-Swift.h>)
#import <on_audio_edit/on_audio_edit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "on_audio_edit-Swift.h"
#endif

@implementation OnAudioEditPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOnAudioEditPlugin registerWithRegistrar:registrar];
}
@end
