import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:wordsapp/app/modules/words/pages/words_store.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final WordsStore _store;

  HomeControllerBase(this._store);

  @observable
  int currentPage = 0;

  @observable
  PageController pageViewController = PageController();

  @action
  Future<void> onInit() async => _store.getWords();

  @action
  void setPage(int pageNumber) {
    pageViewController.animateToPage(
      pageNumber,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    currentPage = pageNumber;
  }
}
