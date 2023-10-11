import 'package:flutter/cupertino.dart';

import '../model/place.dart';
import '../repository/placeRepository.dart';

class ConvenienceViewModel with ChangeNotifier {
  late final PlaceRepository _placeRepository;
  List<Place> _convenienceList = List.empty(growable: true);
  String _buildingName = "";
  List<Place> get convenienceList => _convenienceList;
  String get buildingName => _buildingName;

  ConvenienceViewModel() {
    _placeRepository = PlaceRepository();
    getConvenienceListOrderByName("cafe");
  }

  Future<void> getConvenienceListOrderByName(String convenienceType) async {
    _convenienceList = await _placeRepository.getConvenienceListByTypeOrderByName(convenienceType);
    print(_convenienceList[0].code);
    print(_convenienceList[0].name);
    notifyListeners();
  }

  Future<void> getConvenienceListOrderByDistance(String convenienceType, String buildingCode) async {
    _convenienceList = await _placeRepository.getConvenienceListByTypeOrderByDistance(convenienceType,buildingCode);

    print(_convenienceList[0].code);
    print(_convenienceList[0].name);
    notifyListeners();
  }

  Future<void> getBuildingName(String buildingCode) async {
    Place _place = await _placeRepository.getPlace(buildingCode);
    _buildingName = _place.name!;
    notifyListeners();
  }

}