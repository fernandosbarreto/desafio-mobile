import 'package:wordsapp/app/core/models/word_detail/word_detail_model.dart';

abstract class ISecureStorage {
  Future<void> writeData(String key, String value);
  Future<String?> readData(String key);
  Future<Map<String, String>> readAllData();
  Future<void> deleteData(String key);
  Future<void> clearAll();
  Future<List<String>> findList(String key);
  Future<List<WordDetailModel>> findWordList(String key);
  Future<void> updateWordList({
    required String key,
    required WordDetailModel newWordDetail,
  });
  Future<void> removeWordFromList({
    required String key,
    required WordDetailModel wordDetail,
  });
}
