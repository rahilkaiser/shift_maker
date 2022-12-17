import 'dart:convert';

import 'package:http/http.dart';

import '../../../../env.dart';
import '../../../core/util/failures/suggestion_failures/suggestion_failure.dart';
import '../../../domain/entities/core/unique_id.dart';
import '../../../domain/entities/suggestion/suggestion_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/repositories/suggestion/suggestion_repository.dart';

class SuggestionRepoImpl implements SuggestionRepository {
  final Client client;

  const SuggestionRepoImpl({
    required this.client,
  });

  @override
  Future<Either<SuggestionFailure, List<SuggestionEntity>>> getSuggestions(String input, String language, String sessionToken) async {

    final request = Uri.https('maps.googleapis.com', '/maps/api/place/autocomplete/json', {
      'input': input.isEmpty ? "''" : input,
      'types': 'address',
      'language': language,
      'components': 'country:de',
      'key': API_KEY,
      'sessiontoken': sessionToken,
    });

    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return right<SuggestionFailure, List<SuggestionEntity>>(result['predictions']
            .map<SuggestionEntity>(
              (place) => SuggestionEntity(
                id: UniqueId.fromUniqueString(place['place_id']),
                description: place['description'],
              ),
            )
            .toList());
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return right<SuggestionFailure, List<SuggestionEntity>>([]);
      }
      return Left(SuggestionFailureGeneralFailure());
    } else {
      throw Left(SuggestionFailureGeneralFailure());
    }

    print(response.toString());
    print("RESPONSE");
    return Left(SuggestionFailureGeneralFailure());
  }
}
