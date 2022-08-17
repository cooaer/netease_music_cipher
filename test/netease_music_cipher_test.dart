import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netease_music_cipher/netease_music_cipher.dart';

void main() {
  const MethodChannel channel = MethodChannel('netease_music_cipher');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('encryptWeapi', () async {
    expect(await NeteaseMusicCipher.encryptWeapi, '42');
  });
}
