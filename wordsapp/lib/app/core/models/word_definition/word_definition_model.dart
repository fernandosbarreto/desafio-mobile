import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_definition_model.freezed.dart';
part 'word_definition_model.g.dart';

@freezed
class WordDefinitionModel with _$WordDefinitionModel {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.none)
  factory WordDefinitionModel({
    String? definition,
    List<String>? synonyms,
  }) = _WordDefinitionModel;

  factory WordDefinitionModel.fromJson(Map<String, dynamic> json) =>
      _$WordDefinitionModelFromJson(json);
}
