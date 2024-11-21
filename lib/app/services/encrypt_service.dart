import 'package:dafa/app/core/values/app_consts.dart';
import 'package:encrypt/encrypt.dart' as enc;

class EncryptService{
  final _key = enc.Key.fromUtf8(AppConsts.ENCRYPT_KEY);
  final _iv = enc.IV.fromUtf8(AppConsts.ENCRYPT_KEY);
  late enc.Encrypter encrypter = enc.Encrypter(enc.AES(_key, mode: enc.AESMode.cbc));

  String? encryptedIDNumber;

  String? decryptedIDNumber;

  String encrypt(String text) {
    final encrypted = encrypter.encrypt(text, iv: _iv);
    return encrypted.base64;
  }

  String decrypt(String text) {
    final encrypted = enc.Encrypted.fromBase64(text);
    final decrypted = encrypter.decrypt(encrypted, iv: _iv);
    return decrypted;
  }
}