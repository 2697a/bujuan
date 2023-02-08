#import "MediaCacheManagerPlugin.h"
#if __has_include(<media_cache_manager/media_cache_manager-Swift.h>)
#import <media_cache_manager/media_cache_manager-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "media_cache_manager-Swift.h"
#endif

@implementation MediaCacheManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMediaCacheManagerPlugin registerWithRegistrar:registrar];
}
@end
