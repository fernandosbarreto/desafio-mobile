import 'package:mobx/mobx.dart';
import 'package:wordsapp/app/core/models/words/word_model.dart';
import 'package:wordsapp/app/modules/words/pages/words_store.dart';

part 'word_list_controller.g.dart';

class WordListController = WordListControllerBase with _$WordListController;

abstract class WordListControllerBase with Store {
  final WordsStore _store;

  WordListControllerBase(this._store);

  @computed
  WordList get words => _store.words;
}
