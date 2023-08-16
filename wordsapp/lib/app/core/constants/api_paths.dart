class ApiPaths {
  static const String fullDictionaryUrl =
      'https://raw.githubusercontent.com/dwyl/english-words/master/words_dictionary.json';

  static const String wordApiUrl = 'https://www.wordsapi.com/mashape/words';

  static const String envWordApiDate = String.fromEnvironment('wordApiDate');
  static const String envWordApiToken = String.fromEnvironment('wordApiToken');
}
