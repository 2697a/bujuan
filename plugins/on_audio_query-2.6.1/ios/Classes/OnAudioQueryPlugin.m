#import "OnAudioQueryPlugin.h"
#if __has_include(<on_audio_query/on_audio_query-Swift.h>)
#import <on_audio_query/on_audio_query-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "on_audio_query-Swift.h"
#endif

@implementation OnAudioQueryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOnAudioQueryPlugin registerWithRegistrar:registrar];
}
@end
