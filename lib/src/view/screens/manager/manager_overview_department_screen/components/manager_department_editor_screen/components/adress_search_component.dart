import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../application/departments/places_locator/places_locator_bloc.dart';
import '../../../../../../../domain/entities/suggestion/suggestion_entity.dart';

class AddressSearchComponent extends SearchDelegate<SuggestionEntity?> {
  final sessionToken;
  final Bloc<PlacesLocatorEvent, PlacesLocatorState> placeLocatorBloc;

  AddressSearchComponent(this.sessionToken, this.placeLocatorBloc);

  @override
  ThemeData appBarTheme(BuildContext context) {
    var superThemeData = super.appBarTheme(context);

    return superThemeData.copyWith(
      textTheme: superThemeData.textTheme.copyWith(
        headline6: superThemeData.textTheme.headline6?.copyWith(fontSize: 13),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) {
    // TODO: implement buildBottom
    return PreferredSize(
      preferredSize: Size(10, 10),
      child: Container(),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    print(query);
    this.placeLocatorBloc.add(
          PlacesLocatorEvent.getSuggestionsEvent(
            input: query,
            language: "de",
            sessionToken: this.sessionToken,
          ),
        );

    return BlocBuilder(
      bloc: this.placeLocatorBloc,
      builder: (BuildContext context, PlacesLocatorState state) {
        if (state is PlaceLocatorStateInitial) {
          return Container();
        } else if (state is PlaceLocatorStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PlaceLocatorStateFailure) {
          return Center(
            child: Text(
              "An Error has occured",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          );
        } else if (state is PlaceLocatorStateSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (
              context,
              index,
            ) {
              SuggestionEntity sugg = state.suggestions[index];
              return ListTile(
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 8,),
                        Expanded(
                          child: Text(
                            sugg.description,
                            style: themeData.textTheme.headline6?.copyWith(fontSize: 13),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            query = sugg.description;
                          },
                          child: Icon(
                            Icons.north_west,
                            color: themeData.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    // InkWell(
                    //   onTap: () {
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: themeData.colorScheme.secondary.withOpacity(0.1),
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Text(
                    //       "+ Hausnummer hinzufügen",
                    //       style: TextStyle(fontSize: 13, color: themeData.colorScheme.primary),
                    //     ),
                    //   ),
                    // ),
                    Divider()
                  ],
                ),
                onTap: () {
                  close(context, state.suggestions[index]);
                },
              );
            },
            itemCount: state.suggestions.length,
          );
        }

        return Container();
      },
    );
  }
}
