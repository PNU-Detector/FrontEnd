import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class BuildingInfo extends StatefulWidget {
  final String buildingCode;
  const BuildingInfo({required this.buildingCode, Key? key}) : super(key: key);

  @override
  _BuildingInfoState createState() => _BuildingInfoState();
}

class Info {
  final String code;
  final String name;
  final String info;
  final String latitude;
  final String longitude;

  Info({
    required this.code,
    required this.name,
    required this.info,
    required this.latitude,
    required this.longitude,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    final response = json['response'];
    return Info(
      code: response['code'].replaceAll(RegExp(r'[^0-9]'), ''),
      name: response['name'],
      info: response['info'],
      latitude: response['latitude'],
      longitude: response['longitude'],
    );
  }
}

class _BuildingInfoState extends State<BuildingInfo> {
  Info info = Info(code: "", name: "", info: "", latitude: "", longitude: "");
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    _loadInfoData();
  }

  Future<void> _loadInfoData() async {
    final buildingCode = widget.buildingCode;

    // 정보 조회 API 호출
    final apiUrl = "http://54.180.198.149:8080/structures/$buildingCode";
    final response1 = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response1.statusCode == 200) {
      final jsonBody = utf8.decode(response1.bodyBytes);
      final decodedData = json.decode(jsonBody);

      setState(() {
        info = Info.fromJson(decodedData);
      });
    } else {
      throw Exception('Failed to load info');
    }

    // 이미지를 가져오는 엔드포인트
    final imageUrl = "http://54.180.198.149:8080/structures/$buildingCode/images";
    final response2 = await http.get(Uri.parse(imageUrl));
    print(response2.statusCode);
    print(response2.body.toString());
    if (response2.statusCode == 200) {
      // 이미지 데이터를 바이트 배열로 변환
      final imageBytes = response2.bodyBytes;

      // 화면 갱신
      setState(() {
        imageData = Uint8List.fromList(imageBytes);
      });
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              info.name,
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: info.code.isNotEmpty
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '해당건물의 이름은 ',
                          style: TextStyle(
                            fontSize: 15, // 일반 글자 크기
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // 검정색
                          ),
                        ),
                        TextSpan(
                          text: '${info.name}',
                          style: TextStyle(
                            fontSize: 20, // 변수 글자 크기
                            fontWeight: FontWeight.bold,
                            color: Colors.blue, // 파란색
                          ),
                        ),
                        TextSpan(
                          text: ' 이며,\n 건물 번호는 ',
                          style: TextStyle(
                            fontSize: 15, // 일반 글자 크기
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // 검정색
                          ),
                        ),
                        TextSpan(
                          text: '${info.code}',
                          style: TextStyle(
                            fontSize: 20, // 변수 글자 크기
                            fontWeight: FontWeight.bold,
                            color: Colors.blue, // 파란색
                          ),
                        ),
                        TextSpan(
                          text: ' 입니다.',
                          style: TextStyle(
                            fontSize: 15, // 일반 글자 크기
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // 검정색
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95, // 화면 가로 길이의 95%
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black54,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "부산대학교의 건물 번호는 위치에 따라 정해집니다."
                          "정문을 기준으로 학교 위쪽으로 올라갈수록 건물번호의 첫번째자리 숫자가 커지며 "
                          "우측으로 갈수록 나머지 뒷자리 숫자가 커집니다.",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95, // 화면 가로 길이의 95%
                    child: Center(
                      child: imageData != null
                          ? Container(
                        decoration: BoxDecoration(
                          color: Colors.black54, // 배경 색상
                          borderRadius: BorderRadius.circular(5), // 굴곡 설정
                        ),
                        padding: EdgeInsets.all(5), // 내부 여백 설정
                        child: Image.memory(
                          imageData!, // 바이트 배열을 표시
                          fit: BoxFit.cover, // 이미지를 화면에 맞게 조절
                        ),
                      )
                          : CircularProgressIndicator(), // 로딩 중이면 로딩 아이콘 표시
                    ),
                  ),

                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.deepOrangeAccent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () async {
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 30,),
                              Icon(
                                Icons.report,
                                color: Colors.deepOrangeAccent,
                                size: 24,
                              ),
                              SizedBox(width: 20),
                              Flexible(
                                child: Text(
                                  '이 건물이 아니라면 버튼을 눌러 신고해주세요',
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15,),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${info.name}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0, // 원하는 크기로 조정
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                        TextSpan(
                          text: '은',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0, // 작게 표시할 크기로 조정
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(info.info,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(height: 15,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 400,
                    child: NaverMap(
                      forceGesture: true,
                      options: NaverMapViewOptions(
                        initialCameraPosition: NCameraPosition(
                          target: NLatLng(
                            double.tryParse(info.latitude) ?? 0.0,  // 기본값을 0.0으로 설정하거나 다른 기본값을 선택할 수 있습니다.
                            double.tryParse(info.longitude) ?? 0.0,
                          ),
                          zoom: 16,
                          bearing: 280,
                        ),
                      ),
                      onMapReady: (controller) {
                        print("네이버 맵 로딩 완료!");
                      },
                    ),)



                ],
              )
                  : CircularProgressIndicator(),

            ),
          ),
        )
    );
  }
}
