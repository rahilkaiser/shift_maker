part of 'places_locator_bloc.dart';

@freezed
class PlacesLocatorEvent with _$PlacesLocatorEvent {
  const factory PlacesLocatorEvent.getSuggestionsEvent({
    required String input,
    required String language,
    required String sessionToken,
  }) = GetSuggestionsEvent;
}
