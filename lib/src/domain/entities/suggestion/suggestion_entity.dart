import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/unique_id.dart';

part 'suggestion_entity.freezed.dart';

@freezed
class SuggestionEntity with _$SuggestionEntity {
  const factory SuggestionEntity({
    required UniqueId id,
    required String description,
  }) = _SuggestionEntity;

}
