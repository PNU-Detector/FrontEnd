import 'package:flutter/cupertino.dart';

import '../model/place.dart';
import '../repository/placeRepository.dart';

class RestaurantViewModel with ChangeNotifier {
  late final PlaceRepository _placeRepository;
  List<Place> _restaurantList = List.empty(growable: true);
  List<Place> get restaurantList => _restaurantList;

  RestaurantViewModel() {
    _placeRepository = PlaceRepository();
  }

  Future<void> getRestaurantList() async {
    List<String> buildingCodes = ["b419","b415","b708","b310"];
    Place _place = new Place();
    for(String buildingCode in buildingCodes){
      _place = await _placeRepository.getPlace(buildingCode);
      _place.setImage(await _placeRepository.getPlaceImage(buildingCode));
      restaurantList.add(_place);
    }
    notifyListeners();
  }

}