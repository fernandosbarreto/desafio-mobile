import 'package:wordsapp/app/core/models/words/word_model.dart';

abstract class IWordsRepository {
  Future<WordList> getWordList();
}
