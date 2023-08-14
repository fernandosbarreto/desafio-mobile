import 'package:mobx/mobx.dart';
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

  @computed
  WordDetailModel? get wordDetail => _store.wordDetail.maybeWhen(
        data: (wordDetailModel) => wordDetailModel,
        orElse: () => null,
      );
}
