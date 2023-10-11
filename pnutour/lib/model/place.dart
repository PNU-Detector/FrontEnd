import 'dart:ffi';
import 'dart:typed_data';

class Place {
  final String? name;
  final String? code;
  final String? type;
  final String? info;
  final double? latitude;
  final double? longitude;
  late final Uint8List? image;


  Place({ this.name, this.code, this.type, this.info, this.latitude,this.longitude});

  factory Place.fromJson(Map<String, dynamic> json){

    return Place(name: json['name'],code: json['code'], type: json['type'], info: json['info'], latitude: double.parse(json['latitude']),longitude: double.parse(json['longitude']));
  }

  void setImage(Uint8List image){
    this.image = image;
  }




}
