import 'dart:async';

import 'package:flutter/services.dart';

class NeteaseMusicCipher {
  static const MethodChannel _channel =
      const MethodChannel('netease_music_cipher');

  static Future<Map> encryptWeapi(String text) async {
    final Map params = await _channel.invokeMethod("encryptWeapi", text);
    return params;
  }

  static Future<Map> encryptEapi(String url, String text) async {
    final Map params = await _channel.invokeMethod("encryptEapi", [url, text]);
    return params;
  }
}
