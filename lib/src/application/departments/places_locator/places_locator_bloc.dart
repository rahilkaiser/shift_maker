import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/util/failures/suggestion_failures/suggestion_failure.dart';
import '../../../domain/entities/suggestion/suggestion_entity.dart';
import '../../../domain/repositories/suggestion/suggestion_repository.dart';

part 'places_locator_event.dart';

part 'places_locator_state.dart';

part 'places_locator_bloc.freezed.dart';

class PlacesLocatorBloc extends Bloc<PlacesLocatorEvent, PlacesLocatorState> {
  final SuggestionRepository suggestionRepository;

  PlacesLocatorBloc({required this.suggestionRepository}) : super(const PlacesLocatorState.initial()) {
    on<GetSuggestionsEvent>((event, emit) async {
      Either<SuggestionFailure, List<SuggestionEntity>> result =
          await this.suggestionRepository.getSuggestions(event.input, event.language, event.sessionToken);

      result.fold(
        (l) => emit(PlacesLocatorState.failure(failure: l)),
        (r) => emit(PlacesLocatorState.success(suggestions: r)),
      );
    });
  }
}
