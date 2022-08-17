import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netease_music_cipher/netease_music_cipher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map _cipherText = {'params': 'init'};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    Map cipherText;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      cipherText = await NeteaseMusicCipher.encryptEapi(
          "https://github.com/cooaer/netease_music_cipher", "content");
    } on PlatformException catch (e) {
      cipherText = {'params': "error"};
      debugPrint(
          "encrypt error, code = ${e.code}, details = ${e.details}, message = ${e.message}, stack = ${e.stacktrace}");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _cipherText = cipherText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('cipher :' + _cipherText['params']),
        ),
      ),
    );
  }
}
