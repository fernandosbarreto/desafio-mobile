abstract class ISecureStorage {
  Future<void> writeData(String key, String value);
  Future<String?> readData(String key);
  Future<Map<String, String>> readAllData();
  Future<void> deleteData(String key);
  Future<void> clearAll();
}
