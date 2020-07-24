# netease_music_cipher

一个对网易云音乐API参数进行加密的Flutter插件！

## Getting Started

对网易云音乐的API请求需要用到AES和RSA，目前Dart的基础库中关于加密的支持比较弱，所以选择通过成熟的Java来实现参数的加密。

```
var result = await NeteaseMusicCipher.encrypt('params string');
print(result['params']);
print(result['encSecKey']);
```

## Supported Platforms

- [x] Android
- [ ] iOS
