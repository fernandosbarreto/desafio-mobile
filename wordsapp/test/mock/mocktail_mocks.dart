import 'package:mocktail/mocktail.dart';
import 'package:wordsapp/app/core/interfaces/http_client_interface.dart';
import 'package:wordsapp/app/core/interfaces/secure_storage_interface.dart';

class MockHttpClient extends Mock implements IHttpClient {}

class MockSecureStorage extends Mock implements ISecureStorage {}
