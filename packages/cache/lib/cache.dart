library cache;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// {@template cache_client}
/// An in-memory cache client.
/// {@endtemplate}
class CacheClient {
  /// {@macro cache_client}
  CacheClient() : _storage = FlutterSecureStorage() {}

  final FlutterSecureStorage _storage;

  /// Writes the provide [key], [value] pair to the in-memory cache.
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  Future<String> read({required String key}) async {
    final value = await _storage.read(key: key);
    if (value == null) return '';
    return value;
  }
}
