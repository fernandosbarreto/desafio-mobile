# Desafio Mobile 🏅 2023 - Dicionário

## Descrição

O aplicativo WordsApp oferece uma experiência intuitiva ao exibir uma lista de palavras em inglês. Ao tocar em uma palavra, os usuários podem acessar uma tela detalhada contendo descrição, pronúncia e frequência de uso. A funcionalidade de salvar palavras favoritas localmente adiciona comodidade, permitindo aos usuários revisitar suas seleções. Esse projeto foi proposto como desafio pela equipe [**Pilar**](https://www.soupilar.com.br/) e pode ser acessado em [**DesafioMobile**](https://github.com/alessandrosil/desafio-mobile).

## Etapas
1. Realizar fork e clone do projeto;
2. Investigar o funcionamento da API (descobri que não é necessário cadastrar cartão de crédito para uso, testando com F12 no navegador, encontrei os parâmetros padrões);
3. Adicionar dependências e estrutura inicial;
4. Buscar e armazenar localmente os dados da lista de palavras;
5. Criar tela inicial e exibir a lista;
6. Adicionar requisição dos detalhes das palavras;
7. Salvar o resultado de cada palavra pesquisada;
8. Criar tela e exibir detalhes das palavras para começar a salvar o histórico;
9. Adicionar recurso de histórico e armazenamento local;
10. Adicionar recurso para salvar como favorito (processo semelhante ao histórico, mas com a opção de remover).

## Descobertas
- Como utilizar o `secure_storage` para armazenar dados "complexos"; eu havia usado somente para guardar uma string de refreshToken;
- Dependendo de onde é utilizado, o `safeArea` pode causar congelamentos no aplicativo.

## Um projeto Flutter feito utilizando:

- **Flutter** Versão 3.10.6 - última versão estável em 15/08/2023 [[doc]](https://docs.flutter.dev/release/archive?tab=windows)
- 
- **mobx** para gerenciamento de estado [[pub.dev]](https://pub.dev/packages/mobx) [[doc]](https://pub.dev/documentation/mobx/latest/)

- **freezed** para ajudar a criar modelos e estados de exibição [[pub.dev]](https://pub.dev/packages/freezed) [[doc]](https://pub.dev/documentation/freezed/latest/)

- **Flutter Modular** para injeção de dependência e rotas [[pub.dev]](https://pub.dev/packages/flutter_modular) [[doc]](https://modular.flutterando.com.br/)
-  
- **Flutter Secure Storage** para armazenamento local criptografado [[pub.dev]](https://pub.dev/packages/flutter_secure_storage) [[doc]](https://pub.dev/documentation/flutter_secure_storage/latest/)
  
- **Dio** para simplificar requisições de rede e interações com API [[pub.dev]](https://pub.dev/packages/dio) [[doc]](https://pub.dev/documentation/dio/latest/)

## Sobre os módulos
Este projeto foi desenvolvido utilizando uma estrutura de módulos, permitindo a separação de cada módulo em pacotes, facilitando a manutenção e coesão de cada módulo.

 - **CoreModule**: responsável por fornecer recursos básicos a todos os módulos;
 - **wordsModule**: para exibir a lista de palavras;

## Para executar o projeto:
```
flutter pub get
flutter run
```

# Autor

Fernando Danza Barreto

https://www.linkedin.com/in/fernando-barreto-75bb841a0/

## Se este é o seu primeiro projeto Flutter

Alguns recursos para você começar se este é o seu primeiro projeto Flutter:

- [Lab: Crie seu primeiro aplicativo Flutter](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Exemplos úteis do Flutter](https://flutter.dev/docs/cookbook)

Para obter ajuda para começar com o Flutter, consulte está documentação
[documentação online](https://flutter.dev/docs), que oferece tutoriais,
exemplos, orientações sobre desenvolvimento mobile e uma referência completa da API.
