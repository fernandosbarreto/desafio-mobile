import 'package:flutter_modular/flutter_modular.dart';
import 'package:wordsapp/app/core/interfaces/secure_storage_interface.dart';
import 'package:wordsapp/app/core/interfaces/words_repository_interface.dart';
import 'package:wordsapp/app/core/repositories/words_repository.dart';
import 'package:wordsapp/app/core/services/secure_storage.dart';
import 'package:wordsapp/app/modules/words/pages/home_page.dart';
import 'package:wordsapp/app/modules/words/pages/home_controller.dart';
import 'package:wordsapp/app/modules/words/pages/word_list/word_list_controller.dart';
import 'package:wordsapp/app/modules/words/pages/words_store.dart';

class WordsModule extends Module {
  @override
  final List<Bind> binds = [
    //controllers
    Bind.lazySingleton((i) => HomeController(i.get())),
    Bind.lazySingleton((i) => WordListController(i.get())),

    //stores
    Bind.lazySingleton((i) => WordsStore(i.get(), i.get())),

    //repositories
    Bind.lazySingleton<IWordsRepository>(
        (i) => WordsRepository(i.get(), i.get())),

    //services
    Bind.lazySingleton<ISecureStorage>((i) => SecureStorage()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}
