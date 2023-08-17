import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:wordsapp/app/core/interfaces/secure_storage_interface.dart';
import 'package:wordsapp/app/core/interfaces/words_repository_interface.dart';
import 'package:wordsapp/app/core/repositories/words_repository.dart';
import 'package:wordsapp/app/core/services/secure_storage.dart';
import 'package:wordsapp/app/modules/words/pages/favorites/favorites_controller.dart';
import 'package:wordsapp/app/modules/words/pages/home_page.dart';
import 'package:wordsapp/app/modules/words/pages/home_controller.dart';
import 'package:wordsapp/app/modules/words/pages/word_detail/word_detail_controller.dart';
import 'package:wordsapp/app/modules/words/pages/word_detail/word_detail_page.dart';
import 'package:wordsapp/app/modules/words/pages/word_list/word_list_controller.dart';
import 'package:wordsapp/app/modules/words/pages/words_store.dart';

import 'pages/history/history_controller.dart';

class WordsModule extends Module {
  @override
  final List<Bind> binds = [
    //controllers
    Bind.lazySingleton((i) => HomeController(i.get())),
    Bind.lazySingleton((i) => WordListController(i.get())),
    Bind.lazySingleton((i) => HistoryController(i.get())),
    Bind.lazySingleton((i) => FavoritesController(i.get())),
    Bind.lazySingleton((i) => WordDetailController(i.get(), i.get())),

    //stores
    Bind.lazySingleton((i) => WordsStore(i.get(), i.get())),

    //repositories
    Bind.lazySingleton<IWordsRepository>(
        (i) => WordsRepository(i.get(), i.get())),

    //services
    Bind.lazySingleton<ISecureStorage>((i) => SecureStorage()),
    Bind.lazySingleton((i) => FlutterTts()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
    ChildRoute('/word-detail', child: (_, args) => const WordDetailPage()),
  ];
}
