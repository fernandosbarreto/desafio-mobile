import 'package:flutter_modular/flutter_modular.dart';
import 'package:wordsapp/app/core/interfaces/words_repository_interface.dart';
import 'package:wordsapp/app/core/repositories/words_repository.dart';
import 'package:wordsapp/app/modules/words/pages/home_page.dart';
import 'package:wordsapp/app/modules/words/pages/home_controller.dart';

class WordsModule extends Module {
  @override
  final List<Bind> binds = [
    //controllers
    Bind.lazySingleton((i) => HomeController(i.get())),

    //repositories
    Bind.lazySingleton<IWordsRepository>((i) => WordsRepository(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}
