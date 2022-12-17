part of 'places_locator_bloc.dart';

@freezed
class PlacesLocatorState with _$PlacesLocatorState {
  const factory PlacesLocatorState.initial() = PlaceLocatorStateInitial;

  const factory PlacesLocatorState.loading() = PlaceLocatorStateLoading;

  const factory PlacesLocatorState.success({
    required List<SuggestionEntity> suggestions,
  }) = PlaceLocatorStateSuccess;

    const factory PlacesLocatorState.failure({
    required SuggestionFailure failure,
  }) = PlaceLocatorStateFailure;
}
