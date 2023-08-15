import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/app/core/models/word_definition/word_definition_model.dart';
import 'package:wordsapp/app/core/models/word_pronunciation/word_pronunciation_model.dart';

part 'word_detail_model.freezed.dart';
part 'word_detail_model.g.dart';

@freezed
class WordDetailModel with _$WordDetailModel {
  @JsonSerializable(fieldRename: FieldRename.none)
  factory WordDetailModel({
    String? word,
    @JsonKey(defaultValue: false) bool? isFavorite,
    List<WordDefinitionModel>? results,
    WordPronunciationModel? pronunciation,
    double? frequency,
  }) = _WordDetailModel;

  factory WordDetailModel.fromJson(Map<String, dynamic> json) =>
      _$WordDetailModelFromJson(json);
}

@freezed
class WordDetail with _$WordDetail {
  const factory WordDetail.data(WordDetailModel wordDetailModel) =
      WordDetailData;
  const factory WordDetail.none() = WordDetailNone;
  const factory WordDetail.loading() = WordDetailLoading;
  const factory WordDetail.error([Object? error]) = WordDetailError;
}
