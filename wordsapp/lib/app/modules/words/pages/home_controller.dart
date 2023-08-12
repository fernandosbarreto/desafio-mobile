import 'package:mobx/mobx.dart';
import 'package:wordsapp/app/core/interfaces/words_repository_interface.dart';
import 'package:wordsapp/app/core/models/words/word_model.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final IWordsRepository _wordsRepository;

  HomeControllerBase(this._wordsRepository);

  @observable
  int counter = 0;

  @observable
  WordList words = const WordList.empty();

  @action
  Future<void> onInit() async {
    getWords();
  }

  @action
  Future<void> getWords() async {
    words = const WordList.loading();
    words = await _wordsRepository.getWordList();
  }

  Future<void> increment() async {
    getWords();
    counter = counter + 1;
  }
}
