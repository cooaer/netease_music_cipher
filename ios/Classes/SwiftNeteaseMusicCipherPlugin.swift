import Flutter
import UIKit

public class SwiftNeteaseMusicCipherPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "netease_music_cipher", binaryMessenger: registrar.messenger())
    let instance = SwiftNeteaseMusicCipherPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
