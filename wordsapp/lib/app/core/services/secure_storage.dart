import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wordsapp/app/core/interfaces/secure_storage_interface.dart';

class SecureStorage implements ISecureStorage {
  final _storage = const FlutterSecureStorage();
  final _iOptions = IOSOptions.defaultOptions;
  final _aOptions = const AndroidOptions(encryptedSharedPreferences: true);

  @override
  Future<void> writeData(String key, String value) => _storage.write(
      key: key, value: value, iOptions: _iOptions, aOptions: _aOptions);

  @override
  Future<String?> readData(String key) async =>
      _storage.read(key: key, iOptions: _iOptions, aOptions: _aOptions);

  @override
  Future<Map<String, String>> readAllData() async =>
      _storage.readAll(iOptions: _iOptions, aOptions: _aOptions);

  @override
  Future<void> deleteData(String key) =>
      _storage.delete(key: key, iOptions: _iOptions, aOptions: _aOptions);

  @override
  Future<void> clearAll() async =>
      _storage.deleteAll(iOptions: _iOptions, aOptions: _aOptions);
}
