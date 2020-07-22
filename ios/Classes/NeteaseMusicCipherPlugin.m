#import "NeteaseMusicCipherPlugin.h"
#if __has_include(<netease_music_cipher/netease_music_cipher-Swift.h>)
#import <netease_music_cipher/netease_music_cipher-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "netease_music_cipher-Swift.h"
#endif

@implementation NeteaseMusicCipherPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNeteaseMusicCipherPlugin registerWithRegistrar:registrar];
}
@end
