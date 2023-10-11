import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:pnutour/model/place.dart';

class RemoteDataSource{
  String host = "http://10.0.2.2:8080";
  Future<Uint8List> getPlaceImage(String? buildingCode) async{
    print("image");
    final imageUrl = "$host/structures/$buildingCode/images";
    final response = await http.get(
      Uri.parse(imageUrl),
    );
    print(response.statusCode);
    print(response.body.toString());
    if (response.statusCode == 200) {
      // 이미지 데이터를 바이트 배열로 변환
      final imageBytes = response.bodyBytes;
      return Uint8List.fromList(imageBytes);

    } else {
      return Uint8List(0);
    }
  }

  Future<Place> getPlace(String buildingCode) async{
    // 장소 정보 가져오기
    final apiUrl = "$host/structures/$buildingCode";

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );


    if (response.statusCode == 200) {
      print("success");
      final decodedBody = utf8.decode(response.bodyBytes);
      Place place = Place.fromJson(jsonDecode(decodedBody)['response']);
      return place;

    } else {
      throw Exception('Failed to load info');
    }

  }




  Future<List<Place>> getLandmarkListOrderByName() async{
    // 장소 정보 가져오기
    final apiUrl = "$host/structures/landmarks/order-name";

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    return loadInfo(response);
  }

  Future<List<Place>> getLandmarkListOrderByDistance(String buildingCode) async{
    // 장소 정보 가져오기
    final apiUrl = "$host/structures/landmarks/order-distance/$buildingCode";

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    return loadInfo(response);
  }

  Future<List<Place>> getConvenienceListByTypeOrderByName(String convenienceType) async{
    // 장소 정보 가져오기
    final apiUrl = "$host/structures/conveniences/order-name/$convenienceType";
    print("------------------------");
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    return loadInfo(response);
  }

  Future<List<Place>> getConvenienceListByTypeOrderByDistance(String convenienceType, String buildingCode) async{

    // 장소 정보 가져오기
    final apiUrl = "$host/structures/conveniences/order-distance/$convenienceType/$buildingCode";

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    return loadInfo(response);

  }


  Future<List<Place>> loadInfo(http.Response response) async{
    List<Place> places= List.empty();
    if (response.statusCode == 200) {
      print("success");
      print(response);
      final decodedBody = utf8.decode(response.bodyBytes);
      places = jsonDecode(decodedBody)['response']['structures']
          .map<Place>((json) => Place.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load info');
    }

    //사진 정보 가져오기
    for (var place in places) {
      final image = await getPlaceImage(place.code);
      place.setImage(image);
      print(place.longitude);
    }
    return places;
  }





}