import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_model.freezed.dart';
part 'word_model.g.dart';

@freezed
class WordModel with _$WordModel {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.none)
  factory WordModel({
    required String word,
  }) = _WordModel;

  factory WordModel.fromJson(Map<String, dynamic> json) =>
      _$WordModelFromJson(json);
}

@freezed
class WordList with _$WordList {
  const factory WordList.data(List<WordModel> wordList) = WordListData;
  const factory WordList.empty() = WordListEmpty;
  const factory WordList.loading() = WordListLoading;
  const factory WordList.error([Object? error]) = WordListError;
}
