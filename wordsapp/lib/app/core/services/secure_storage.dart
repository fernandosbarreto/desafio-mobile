import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wordsapp/app/core/interfaces/secure_storage_interface.dart';
import 'package:wordsapp/app/core/models/word_detail/word_detail_model.dart';

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

  @override
  Future<List<String>> findList(String key) async {
    List<String> storageList = [];
    final listResult = await readData(key);
    if (listResult != null) {
      storageList = json.decode(listResult);
    }
    return storageList;
  }

  @override
  Future<List<WordDetailModel>> findWordList(String key) async {
    String? jsonStringList = await readData(key);
    if (jsonStringList != null) {
      List<dynamic> jsonList = json.decode(jsonStringList);
      try {
        List<WordDetailModel> wordDetailList = jsonList
            .map((jsonMap) => WordDetailModel.fromJson(jsonMap))
            .toList();
        return wordDetailList;
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  @override
  Future<void> removeWordFromList({
    required String key,
    required WordDetailModel wordDetail,
  }) async {
    final wordDetailList = await findWordList(key);

    final existingIndex =
        wordDetailList.indexWhere((element) => element.word == wordDetail.word);

    if (existingIndex != -1) {
      wordDetailList.removeWhere((element) => element.word == wordDetail.word);

      String jsonStringList =
          json.encode(wordDetailList.map((detail) => detail.toJson()).toList());

      await writeData(key, jsonStringList);
    }
  }

  @override
  Future<void> updateWordList({
    required String key,
    required WordDetailModel newWordDetail,
  }) async {
    final wordDetailList = await findWordList(key);

    final existingIndex = wordDetailList
        .indexWhere((element) => element.word == newWordDetail.word);

    if (existingIndex != -1) {
      wordDetailList[existingIndex] = newWordDetail;
    } else {
      wordDetailList.add(newWordDetail);
    }

    String jsonStringList =
        json.encode(wordDetailList.map((detail) => detail.toJson()).toList());

    await writeData(key, jsonStringList);
  }
}
