import 'dart:async';

import 'package:flutter/services.dart';

class NeteaseMusicCipher {
  static const MethodChannel _channel =
      const MethodChannel('netease_music_cipher');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Map> encrypt(String content) async{
    final Map params =  await _channel.invokeMethod("encrypt", content);
    return params;
  }

}
