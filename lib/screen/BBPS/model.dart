import 'dart:convert';
import 'package:crypto/crypto.dart' as sha256;
import 'package:encrypt/encrypt.dart';




class EncryptData{
//for AES Algorithms

  static Encrypted? encrypted;
  static var decrypted;

  static encryptAES(plainText){
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));

    encrypted = encrypter.encrypt(plainText, iv: iv);
    print(encrypted!.base64);
  }

  static decryptAES(plainText){
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    decrypted = encrypter.decrypt(encrypted!, iv: iv);
    print(decrypted);
  }
}


class NatrisEncryption {

  String createMD5(String input) {
    return sha256.md5.convert(utf8.encode(input)).toString();
  }

  // String generateSha256Hash(List<int> message) {
  //   var shaa256 = sha256.Digest(message);
  //   return base64Encode(shaa256.bytes);
  //
  // }

  String encryptUsingSessionKey( skey,  data) {




    // You may need to implement AES encryption in Dart using a library.
    // There isn't a built-in AESCryptoServiceProvider in Dart.
    // You can use a package like 'pointycastle' for AES encryption.
    // Example: https://pub.dev/packages/pointycastle
    // Implement AES encryption using 'pointycastle' or another suitable library.
    return ''; // Placeholder until you implement AES encryption.
  }

  void completeEncryption(String myValue, String eskey) {

    // final key = encrypt.Key.fromLength(32);
    // final iv = encrypt.IV.fromLength(16);
    // final aesKey = encrypt.Encrypter(encrypt.AES(key));
    // final encrypted = aesKey.encrypt(myValue, iv: iv);
    // print("base:  "+encrypted.base64);
    // print(myValue);
    //
    // final aesKsey = <int>[/* Generate your AES key here */];
    final nval = createMD5(myValue);
    print(nval);
    // eskey = encryptUsingSessionKey(encrypted, utf8.encode(nval));
    print(eskey);
  }
}