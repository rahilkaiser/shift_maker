import 'package:dartz/dartz.dart';

import '../../../core/util/failures/suggestion_failures/suggestion_failure.dart';
import '../../entities/suggestion/suggestion_entity.dart';

abstract class SuggestionRepository {

  /// Get Suggestions
  ///
  ///
  Future<Either<SuggestionFailure,List<SuggestionEntity>>> getSuggestions(String input, String language, String sessionToken);
}
