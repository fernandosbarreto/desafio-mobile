import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_pronunciation_model.freezed.dart';
part 'word_pronunciation_model.g.dart';

@freezed
class WordPronunciationModel with _$WordPronunciationModel {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.none)
  factory WordPronunciationModel({
    String? all,
  }) = _WordPronunciationModel;

  factory WordPronunciationModel.fromJson(Map<String, dynamic> json) =>
      _$WordPronunciationModelFromJson(json);
}
