import 'package:mobx/mobx.dart';
import 'package:wordsapp/app/core/models/word_detail/word_detail_model.dart';
import 'package:wordsapp/app/core/models/words/word_model.dart';
import 'package:wordsapp/app/modules/words/pages/words_store.dart';

part 'word_list_controller.g.dart';

class WordListController = WordListControllerBase with _$WordListController;

abstract class WordListControllerBase with Store {
  final WordsStore _store;

  WordListControllerBase(this._store);

  @action
  Future<void> getWordDetail(String word) => _store.getWordDetail(word);

  @computed
  WordList get words => _store.words;

  @computed
  WordDetail get wordDetail => _store.wordDetail;
}
