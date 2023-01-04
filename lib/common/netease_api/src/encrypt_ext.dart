import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart' hide Algorithm;

class NoPaddingEncoding extends PKCS1Encoding {
  NoPaddingEncoding(this._engine) : super(_engine);

  final AsymmetricBlockCipher _engine;

  late int _keyLength;
  late bool _forEncryption;

  @override
  void init(bool forEncryption, CipherParameters params) {
    super.init(forEncryption, params);
    _forEncryption = forEncryption;
    if (params is AsymmetricKeyParameter<RSAAsymmetricKey>) {
      _keyLength = (params.key.modulus?.bitLength ?? 0 + 7) ~/ 8;
    }
  }

  @override
  int get inputBlockSize {
    return _keyLength;
  }

  @override
  int get outputBlockSize {
    return _keyLength;
  }

  @override
  int processBlock(
      Uint8List inp, int inpOff, int len, Uint8List out, int outOff) {
    if (_forEncryption) {
      return _encodeBlock(inp, inpOff, len, out, outOff);
    } else {
      return _decodeBlock(inp, inpOff, len, out, outOff);
    }
  }

  int _encodeBlock(
      Uint8List inp, int inpOff, int inpLen, Uint8List out, int outOff) {
    if (inpLen > inputBlockSize) {
      throw ArgumentError("Input data too large");
    }

    var block = Uint8List(inputBlockSize);
    var padLength = (block.length - inpLen);

    block.fillRange(0, padLength, 0x00);

    block.setRange(padLength, block.length, inp.sublist(inpOff));

    return _engine.processBlock(block, 0, block.length, out, outOff);
  }

  int _decodeBlock(
      Uint8List inp, int inpOff, int inpLen, Uint8List out, int outOff) {
    var block = Uint8List(outputBlockSize);
    var len = _engine.processBlock(inp, inpOff, inpLen, block, 0);
    block = block.sublist(0, len);

    if (block.length < outputBlockSize) {
      throw ArgumentError("Block truncated");
    }

    return block.length;
  }
}

abstract class AbstractRSAExt {
  final RSAPublicKey? publicKey;
  final RSAPrivateKey? privateKey;

  PublicKeyParameter<RSAPublicKey>? get _publicKeyParams =>
      publicKey != null ? PublicKeyParameter(publicKey!) : null;

  PrivateKeyParameter<RSAPrivateKey>? get _privateKeyParams =>
      privateKey != null ? PrivateKeyParameter(privateKey!) : null;
  final AsymmetricBlockCipher _cipher;

  AbstractRSAExt({
    required this.publicKey,
    required this.privateKey,
  }) : _cipher = NoPaddingEncoding(RSAEngine());
}

class RSAExt extends AbstractRSAExt implements Algorithm {
  RSAExt({RSAPublicKey? publicKey, RSAPrivateKey? privateKey})
      : super(publicKey: publicKey, privateKey: privateKey);

  @override
  Encrypted encrypt(Uint8List bytes, {IV? iv}) {
    if (publicKey == null) {
      throw StateError('Can\'t encrypt without a public key, null given.');
    }

    _cipher
      ..reset()
      ..init(true, _publicKeyParams!);

    return Encrypted(_cipher.process(bytes));
  }

  @override
  Uint8List decrypt(Encrypted encrypted, {IV? iv}) {
    if (privateKey == null) {
      throw StateError('Can\'t decrypt without a private key, null given.');
    }

    _cipher
      ..reset()
      ..init(false, _privateKeyParams!);

    return _cipher.process(encrypted.bytes);
  }
}
