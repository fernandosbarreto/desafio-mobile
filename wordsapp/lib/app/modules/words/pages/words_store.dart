import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:wordsapp/app/core/constants/storage_keys.dart';
import 'package:wordsapp/app/core/interfaces/secure_storage_interface.dart';
import 'package:wordsapp/app/core/interfaces/words_repository_interface.dart';
import 'package:wordsapp/app/core/models/words/word_model.dart';

part 'words_store.g.dart';

class WordsStore = WordsStoreBase with _$WordsStore;

abstract class WordsStoreBase with Store {
  final ISecureStorage _secureStorage;
  final IWordsRepository _wordsRepository;

  WordsStoreBase(this._wordsRepository, this._secureStorage);

  @observable
  int counter = 0;

  @observable
  bool hasWordList = false;

  @observable
  WordList words = const WordList.empty();

  @action
  Future<void> getWords() async {
    words = const WordList.loading();

    final storageWordList =
        await _secureStorage.readData(StorageKeys.wordList.key);
    hasWordList = storageWordList != null;

    if (!hasWordList) {
      _secureStorage.deleteData(StorageKeys.wordList.key);
      words = await _wordsRepository.getWordList();
    } else {
      final jsonMap =
          json.decode(storageWordList ?? '') as Map<String, dynamic>;
      final List<String> keys = jsonMap.keys.toList();

      final List<WordModel> wordList = [];
      for (var element in keys) {
        wordList.add(WordModel(word: element));
      }

      if (wordList.isEmpty) {
        words = const WordList.empty();
      }

      words = WordList.data(wordList);
    }
  }

  Future<void> increment() async {
    getWords();
    counter = counter + 1;
  }
}
