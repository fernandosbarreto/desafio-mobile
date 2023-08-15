import 'package:mobx/mobx.dart';
import 'package:wordsapp/app/core/models/word_detail/word_detail_model.dart';
import 'package:wordsapp/app/modules/words/pages/words_store.dart';

part 'favorites_controller.g.dart';

class FavoritesController = FavoritesControllerBase with _$FavoritesController;

abstract class FavoritesControllerBase with Store {
  final WordsStore _store;

  FavoritesControllerBase(
    this._store,
  );

  @action
  Future<void> getWordDetail(String word) => _store.getWordDetail(word);

  @action
  Future<void> getFavoriteWords() => _store.getFavoriteWords();

  @computed
  List<WordDetailModel> get favoriteWords =>
      _store.favoriteWords.reversed.toList();

  @computed
  WordDetail get wordDetail => _store.wordDetail;
}
