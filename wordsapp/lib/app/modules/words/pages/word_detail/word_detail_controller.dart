import 'package:mobx/mobx.dart';
import 'package:wordsapp/app/core/constants/storage_keys.dart';
import 'package:wordsapp/app/core/models/word_detail/word_detail_model.dart';
import 'package:wordsapp/app/modules/words/pages/words_store.dart';

part 'word_detail_controller.g.dart';

class WordDetailController = WordDetailControllerBase
    with _$WordDetailController;

abstract class WordDetailControllerBase with Store {
  final WordsStore _store;

  WordDetailControllerBase(this._store);

  double calculatedFrequency() {
    double? frequency = wordDetail?.frequency;
    return frequency != null ? frequency * 0.1 : 0.0;
  }

  @action
  Future<void> setFavoriteWord(WordDetailModel? word) async {
    final bool isCurrentWordFavorite = word?.isFavorite ?? false;
    final newWord = word!.copyWith(isFavorite: !isCurrentWordFavorite);
    _store.updateWordHistory(newWord);
    if (newWord.isFavorite ?? false) {
      _store.secureStorage.updateWordList(
          key: StorageKeys.favoriteWords.key, newWordDetail: newWord);
    } else {
      _store.secureStorage.removeWordFromList(
          key: StorageKeys.favoriteWords.key, wordDetail: newWord);
    }
  }

  @computed
  WordDetailModel? get wordDetail => _store.wordDetail.maybeWhen(
        data: (wordDetailModel) => wordDetailModel,
        orElse: () => null,
      );

  @computed
  bool get isFavorite => wordDetail?.isFavorite ?? false;
}
