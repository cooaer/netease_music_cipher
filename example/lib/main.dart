import 'package:flutter/material.dart';
import 'dart:async';

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
  String _platformVersion = 'Unknown';
  Map _cipherText = {'params':'init'};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    Map cipherText;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await NeteaseMusicCipher.platformVersion;
      cipherText = await NeteaseMusicCipher.encrypt("content");
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      _cipherText = {'params':"error"};
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
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
