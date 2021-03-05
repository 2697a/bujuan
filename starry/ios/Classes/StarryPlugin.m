#import "StarryPlugin.h"
#if __has_include(<starry/starry-Swift.h>)
#import <starry/starry-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "starry-Swift.h"
#endif

@implementation StarryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftStarryPlugin registerWithRegistrar:registrar];
}
@end
