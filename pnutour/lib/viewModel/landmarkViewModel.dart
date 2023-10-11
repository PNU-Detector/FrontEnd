import 'package:flutter/cupertino.dart';

import '../model/place.dart';
import '../repository/placeRepository.dart';

class LandmarkViewModel with ChangeNotifier {
  late final PlaceRepository _placeRepository;
  List<Place> _landmarkList = List.empty(growable: true);
  String _buildingName = "";
  List<Place> get landmarkList => _landmarkList;
  String get buildingName => _buildingName;

  LandmarkViewModel() {
    _placeRepository = PlaceRepository();
    getLandmarkListOrderByName();
  }

  Future<void> getLandmarkListOrderByName() async {
    _landmarkList = await _placeRepository.getLandmarkListOrderByName();
    print(_landmarkList[0].code);
    print(_landmarkList[0].name);
    notifyListeners();
  }

  Future<void> getLandmarkListOrderByDistance(String buildingCode) async {
    _landmarkList = await _placeRepository.getLandmarkListOrderByDistance(buildingCode);

    print(_landmarkList[0].code);
    print(_landmarkList[0].name);
    notifyListeners();
  }

  Future<void> getBuildingName(String buildingCode) async {
    Place _place = await _placeRepository.getPlace(buildingCode);
    _buildingName = _place.name!;
    notifyListeners();
  }

}