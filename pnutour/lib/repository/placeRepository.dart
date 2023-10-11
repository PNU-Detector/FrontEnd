import 'dart:typed_data';

import '../dataSource/remoteDataSource.dart';
import '../model/place.dart';

class PlaceRepository {
  final RemoteDataSource _dataSource = RemoteDataSource();

  Future<List<Place>> getLandmarkListOrderByName() {
    return _dataSource.getLandmarkListOrderByName();
  }

  Future<List<Place>> getLandmarkListOrderByDistance(String buildingCode) {
    return _dataSource.getLandmarkListOrderByDistance(buildingCode);
  }

  Future<Place> getPlace(String buildingCode){
    return _dataSource.getPlace(buildingCode);
  }

  Future<Uint8List> getPlaceImage(String buildingCode){
    return _dataSource.getPlaceImage(buildingCode);
  }

  Future<List<Place>> getConvenienceListByTypeOrderByDistance(String convenienceType, String buildingCode) {
    return _dataSource.getConvenienceListByTypeOrderByDistance(convenienceType, buildingCode);
  }

  Future<List<Place>> getConvenienceListByTypeOrderByName(String convenienceType) {
    return _dataSource.getConvenienceListByTypeOrderByName(convenienceType);
  }

}