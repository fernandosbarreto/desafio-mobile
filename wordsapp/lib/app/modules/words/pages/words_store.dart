import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:wordsapp/app/core/constants/storage_keys.dart';
import 'package:wordsapp/app/core/interfaces/secure_storage_interface.dart';
import 'package:wordsapp/app/core/interfaces/words_repository_interface.dart';
import 'package:wordsapp/app/core/models/word_detail/word_detail_model.dart';
import 'package:wordsapp/app/core/models/words/word_model.dart';

part 'words_store.g.dart';

class WordsStore = WordsStoreBase with _$WordsStore;

abstract class WordsStoreBase with Store {
  final ISecureStorage secureStorage;
  final IWordsRepository _wordsRepository;

  WordsStoreBase(this._wordsRepository, this.secureStorage);

  bool hasWordList = false;

  @observable
  List<WordDetailModel> wordHistory = [];

  @observable
  List<WordDetailModel> favoriteWords = [];

  @observable
  WordDetail wordDetail = const WordDetail.none();

  @observable
  WordList words = const WordList.empty();

  @action
  Future<void> getWords() async {
    words = const WordList.loading();

    final storageWordList =
        await secureStorage.readData(StorageKeys.wordList.key);
    hasWordList = storageWordList != null;

    if (!hasWordList) {
      secureStorage.deleteData(StorageKeys.wordList.key);
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

  @action
  Future<void> updateWordHistory(WordDetailModel word) async {
    await secureStorage.updateWordList(
      key: StorageKeys.wordHistory.key,
      newWordDetail: word,
    );
    await getWordDetail(word.word ?? '');
  }

  @action
  Future<void> getWordDetail(String word) async {
    if (word != '') {
      wordDetail = const WordDetail.loading();

      await getHistory();

      if (wordHistory.any((element) => element.word == word)) {
        final cachedWord =
            wordHistory.firstWhere((element) => element.word == word);
        wordDetail = WordDetail.data(cachedWord);
      } else {
        wordDetail = await _wordsRepository.getWordDetail(word);

        wordDetail.maybeWhen(
          data: (wordDetailModel) async {
            secureStorage.updateWordList(
              key: StorageKeys.wordHistory.key,
              newWordDetail: wordDetailModel,
            );
            await getHistory();
          },
          orElse: () {},
        );
      }
    }
  }

  @action
  Future<void> getHistory() async {
    wordHistory = await secureStorage.findWordList(StorageKeys.wordHistory.key);
  }

  @action
  Future<void> getFavoriteWords() async {
    favoriteWords =
        await secureStorage.findWordList(StorageKeys.favoriteWords.key);
  }
}
