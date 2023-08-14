import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wordsapp/app/core/constants/api_paths.dart';
import 'package:wordsapp/app/core/constants/storage_keys.dart';
import 'package:wordsapp/app/core/interfaces/http_client_interface.dart';
import 'package:wordsapp/app/core/interfaces/secure_storage_interface.dart';
import 'package:wordsapp/app/core/interfaces/words_repository_interface.dart';
import 'package:wordsapp/app/core/models/word_detail/word_detail_model.dart';
import 'package:wordsapp/app/core/models/words/word_model.dart';

class WordsRepository implements IWordsRepository {
  final IHttpClient httpService;
  final ISecureStorage _secureStorage;

  WordsRepository(this.httpService, this._secureStorage);

  @override
  Future<WordList> getWordList() async {
    try {
      const url = ApiPaths.fullDictionaryUrl;

      final response = await httpService.get(url);

      final jsonMap = json.decode(response.data) as Map<String, dynamic>;
      final List<String> keys = jsonMap.keys.toList();

      final List<WordModel> wordList = [];
      for (var element in keys) {
        wordList.add(WordModel(word: element));
      }

      if (wordList.isEmpty) {
        return const WordList.empty();
      }

      await _secureStorage.writeData(StorageKeys.wordList.key, response.data);

      return WordList.data(wordList);
    } on DioException catch (e) {
      return WordList.error(e);
    } catch (e, s) {
      debugPrintStack(label: '$e', stackTrace: s);
      return WordList.error(e);
    }
  }

  @override
  Future<WordDetail> getWordDetail(String word) async {
    try {
      final url = '${ApiPaths.wordApiUrl}/$word';

      final response = await httpService.get(
        url,
        queryParameters: {
          'when': '2023-08-13T17:36:58.266Z',
          'encrypted': '8cfdb189e7229b9beb9207bee858bdbfaeb5250932f991b8',
        },
      );

      final wordDetail =
          WordDetailModel.fromJson(response.data as Map<String, dynamic>);

      return WordDetail.data(wordDetail);
    } on DioException catch (e, s) {
      debugPrintStack(label: '$e:${e.response}', stackTrace: s);
      return WordDetail.error(e);
    } catch (e, s) {
      debugPrintStack(label: '$e', stackTrace: s);
      return WordDetail.error(e);
    }
  }
}
