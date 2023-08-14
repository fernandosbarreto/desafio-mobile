import 'package:wordsapp/app/core/models/word_detail/word_detail_model.dart';
import 'package:wordsapp/app/core/models/words/word_model.dart';

abstract class IWordsRepository {
  Future<WordList> getWordList();
  Future<WordDetail> getWordDetail(String word);
}
