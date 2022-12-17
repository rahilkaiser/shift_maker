import 'dart:async';
import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:uuid/uuid.dart';

import '../../../../../../../application/departments/places_locator/places_locator_bloc.dart';
import '../../../../../../../domain/entities/suggestion/suggestion_entity.dart';
import '../../../../../../../injection.dart';
import 'adress_search_component.dart';

class ManagerAdressMapScreen extends StatefulWidget {
  final TextEditingController controller;

  const ManagerAdressMapScreen({Key? key, required this.controller}) : super(key: key);

  static const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide.none,
  );

  @override
  State<ManagerAdressMapScreen> createState() => _ManagerAdressMapScreenState();
}

class _ManagerAdressMapScreenState extends State<ManagerAdressMapScreen> {
  final Completer<GoogleMapController> googleMapsController = Completer<GoogleMapController>();
  final Set<Marker> _markers = HashSet<Marker>();

  late TextEditingController searchController;
  double zoom = 19.151926040649414;

  @override
  void initState() {
    setState(() {
      this.searchController = TextEditingController(text: widget.controller.text);
    });

    if (this.searchController.text.isNotEmpty) {
      this._goToSelectedAdress();
    } else {
      this._goToMyCurrentLocation();
      //Go to my current location
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => serviceLocator<PlacesLocatorBloc>(),
      child: BlocConsumer<PlacesLocatorBloc, PlacesLocatorState>(
        listener: (context, state) {
          if (state is PlaceLocatorStateFailure) {
            print("HELLO");
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                this._goToMyCurrentLocation();
              },
              child: const Icon(Icons.my_location_outlined),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text("Adresse festlegen"),
            ),
            body: Stack(
              children: [
                GoogleMap(
                  markers: this._markers,
                  mapType: MapType.hybrid,
                  initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
                  onMapCreated: (controller) {
                    this.googleMapsController.complete(controller);
                  },
                  zoomControlsEnabled: false,
                  onTap: (LatLng loc) {
                    this._relocatePosition(loc);
                  },
                ),
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(top: 8),
                      sliver: SliverAppBar(
                        backgroundColor: Colors.transparent,
                        automaticallyImplyLeading: false,
                        snap: true,
                        floating: true,
                        centerTitle: true,
                        title: Container(
                          decoration: BoxDecoration(
                            color: themeData.colorScheme.surface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.location_on_outlined),
                                      border: ManagerAdressMapScreen.outlineInputBorder,
                                      enabledBorder: ManagerAdressMapScreen.outlineInputBorder,
                                      focusedBorder: ManagerAdressMapScreen.outlineInputBorder,
                                      errorBorder: ManagerAdressMapScreen.outlineInputBorder,
                                      hintText: "Adresse suchen",
                                    ),
                                    readOnly: true,
                                    controller: this.searchController,
                                    style: themeData.textTheme.headline6?.copyWith(fontSize: 12),
                                    onTap: () async {
                                      final sessionToken = Uuid().v4();

                                      SuggestionEntity? sugg = await showSearch(
                                        context: context,
                                        query: this.searchController.text,
                                        delegate: AddressSearchComponent(
                                          sessionToken,
                                          BlocProvider.of<PlacesLocatorBloc>(context),
                                        ),
                                      ) as SuggestionEntity;

                                      this.searchController.text = sugg.description;
                                      this._goToSelectedAdress();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            widget.controller.text = this.searchController.text;
                                            AutoRouter.of(context).pop();
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: themeData.colorScheme.inversePrimary,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(12)),
                                            )),
                                        child: const Icon(Icons.arrow_right_alt_rounded)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _goToSelectedAdress() async {
    List<Location> locations = await locationFromAddress(this.searchController.text);

    LatLng newPosLatLng = LatLng(locations[0].latitude, locations[0].longitude);

    this._relocatePosition(newPosLatLng);
  }

  void _goToMyCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    LatLng newPosLatLng = LatLng(pos.latitude, pos.longitude);

    this._relocatePosition(newPosLatLng);
  }

  Future<void> _relocatePosition(LatLng loc) async {
    final GoogleMapController controller = await this.googleMapsController.future;
    LatLng newPosLatLng = LatLng(loc.latitude, loc.longitude);

    CameraPosition newCamPos = CameraPosition(target: newPosLatLng, zoom: this.zoom);

    List<Placemark> placeMarks = await placemarkFromCoordinates(loc.latitude, loc.longitude);
    setState(() {
      this.searchController.text =
          '${placeMarks[0].thoroughfare} ${placeMarks[0].subThoroughfare}, ${placeMarks[0].locality}, ${placeMarks[0].country}';

      this._setMarkers(pos: newPosLatLng);
    });

    controller.animateCamera(CameraUpdate.newCameraPosition(newCamPos));
  }

  void _setMarkers({required LatLng pos}) {
    if (_markers.isNotEmpty) _markers.clear();

    _markers.add(
      Marker(
        markerId: MarkerId("0"),
        position: pos,
      ),
    );
  }
}
