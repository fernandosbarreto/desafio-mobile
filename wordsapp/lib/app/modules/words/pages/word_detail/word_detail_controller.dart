import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobx/mobx.dart';
import 'package:wordsapp/app/core/constants/storage_keys.dart';
import 'package:wordsapp/app/core/models/word_detail/word_detail_model.dart';
import 'package:wordsapp/app/modules/words/pages/words_store.dart';

part 'word_detail_controller.g.dart';

class WordDetailController = WordDetailControllerBase
    with _$WordDetailController;

abstract class WordDetailControllerBase with Store {
  final WordsStore _store;
  final FlutterTts flutterTts;

  WordDetailControllerBase(this._store, this.flutterTts);

  @observable
  TtsState ttsState = TtsState.stopped;

  @observable
  double progress = 0;

  double calculatedFrequency() {
    double? frequency = wordDetail?.frequency;
    return frequency != null ? frequency * 0.1 : 0.0;
  }

  @action
  Future<void> onInit() async {
    await flutterTts.setLanguage('en-US');

    flutterTts.setCompletionHandler(() {
      ttsState = TtsState.stopped;
      progress = 0;
    });

    flutterTts.setPauseHandler(() {
      ttsState = TtsState.paused;
    });

    flutterTts.setErrorHandler((msg) {
      ttsState = TtsState.stopped;
    });

    flutterTts.setContinueHandler(() {
      ttsState = TtsState.continued;
    });

    flutterTts.setCancelHandler(() {
      ttsState = TtsState.stopped;
    });
  }

  @action
  Future<void> speech() async {
    if (ttsState == TtsState.playing) {
      await flutterTts.stop();
      ttsState = TtsState.stopped;
    } else {
      var result = await flutterTts.speak(wordDetail?.word ?? '');
      progress = 1;
      if (result == 1) {
        ttsState = TtsState.playing;
      }
    }
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

enum TtsState { playing, stopped, paused, continued }
