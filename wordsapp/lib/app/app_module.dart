import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wordsapp/app/core/interfaces/http_client_interface.dart';
import 'package:wordsapp/app/core/services/http_client_service.dart';
import 'package:wordsapp/app/modules/words/words_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    //services
    Bind.lazySingleton((i) => Dio()),
    Bind.lazySingleton<IHttpClient>((i) => HttpClientService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: WordsModule()),
  ];
}
