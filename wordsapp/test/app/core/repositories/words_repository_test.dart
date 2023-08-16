import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordsapp/app/core/models/word_detail/word_detail_model.dart';
import 'package:wordsapp/app/core/models/words/word_model.dart';
import 'package:wordsapp/app/core/repositories/words_repository.dart';

import '../../../mock/mockJsonReponses/json_word_detail_model.dart';
import '../../../mock/mockJsonReponses/json_word_list_model.dart';
import '../../../mock/mocktail_mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late MockSecureStorage mockSecureStorage;
  late WordsRepository wordsRepository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockSecureStorage = MockSecureStorage();
    wordsRepository = WordsRepository(mockHttpClient, mockSecureStorage);
  });

  group('WordsRepository - getWordList:', () {
    test(
      'should return a WordListData',
      () async {
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => dio.Response(
            data: jsonWordListModel,
            requestOptions: dio.RequestOptions(path: 'path'),
          ),
        );

        when(
          () => mockSecureStorage.writeData(any(), any()),
        ).thenAnswer(
          (_) async {},
        );

        var actual = await wordsRepository.getWordList();

        expect(actual, isA<WordListData>());
      },
    );

    test(
      'should return an instance of WordListError when an exception is thrown',
      () async {
        when(() => mockHttpClient.get(
              any(),
              options: any(named: 'options'),
            )).thenThrow(
          dio.DioException(
            error: '',
            response:
                dio.Response(requestOptions: dio.RequestOptions(path: 'path')),
            requestOptions: dio.RequestOptions(path: 'path'),
          ),
        );

        var actual = await wordsRepository.getWordList();

        expect(actual, isA<WordListError>());
      },
    );
  });

  group('WordsRepository - getWordDetail:', () {
    test(
      'should return a WordDetailData',
      () async {
        when(
          () => mockHttpClient.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => dio.Response(
            data: jsonWordDetailModel,
            requestOptions: dio.RequestOptions(path: 'path'),
          ),
        );

        var actual = await wordsRepository.getWordDetail('word');

        expect(actual, isA<WordDetailData>());
      },
    );

    test(
      'should return an instance of WordDetailError when an exception is thrown',
      () async {
        when(() => mockHttpClient.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
            )).thenThrow(
          dio.DioException(
            error: '',
            response:
                dio.Response(requestOptions: dio.RequestOptions(path: 'path')),
            requestOptions: dio.RequestOptions(path: 'path'),
          ),
        );

        var actual = await wordsRepository.getWordDetail('word');

        expect(actual, isA<WordDetailError>());
      },
    );
  });
}
