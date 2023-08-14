import 'package:mobx/mobx.dart';
import 'package:wordsapp/app/core/models/word_detail/word_detail_model.dart';
import 'package:wordsapp/app/modules/words/pages/words_store.dart';

part 'history_controller.g.dart';

class HistoryController = HistoryControllerBase with _$HistoryController;

abstract class HistoryControllerBase with Store {
  final WordsStore _store;

  HistoryControllerBase(
    this._store,
  );

  @action
  Future<void> getWordDetail(String word) => _store.getWordDetail(word);

  @action
  Future<void> updateHistory() => _store.updateHistory();

  @computed
  List<WordDetailModel> get wordHistory => _store.wordHistory.reversed.toList();
}
