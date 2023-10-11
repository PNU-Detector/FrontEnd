import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:pnutour/view/buildingCameraLocationView.dart';
import 'package:provider/provider.dart';

import '../model/place.dart';
import '../viewModel/landmarkViewModel.dart';

class LandMarkInfoView extends StatefulWidget {
  const LandMarkInfoView({Key? key}) : super(key: key);

  @override
  _LandMarkInfoViewState createState() => _LandMarkInfoViewState();
}

class _LandMarkInfoViewState extends State<LandMarkInfoView> {
  bool _orderByDistance = false;
  bool _orderByName = true;
  late String buildingCode;
  String buildingName = "위치정보 없음";
  bool isLoading= true;
  late List<Place> landmarkList;
  late LandmarkViewModel landmarkViewModel = LandmarkViewModel();
  @override
  void initState() {
    super.initState();
    _loadLandmarkOrderByName();
  }

  Future<void> _loadLandmarkOrderByName() async {
    try {
      isLoading = true;
      await landmarkViewModel.getLandmarkListOrderByName();
      setState(() {
        isLoading = false; // 로딩 완료
        landmarkList = landmarkViewModel.landmarkList;
      });
    } catch (e) {
      // 에러 처리
      print("API 호출 에러: $e");
      setState(() {
        isLoading = false; // 로딩 완료
      });
    }
  }
  Future<void> _loadLandmarkOrderByDistance() async {
    try {
      isLoading = true;
      await landmarkViewModel.getLandmarkListOrderByDistance(buildingCode);
      setState(() {
        isLoading = false; // 로딩 완료
        landmarkList = landmarkViewModel.landmarkList;
      });
    } catch (e) {
      // 에러 처리
      print("API 호출 에러: $e");
      setState(() {
        isLoading = false; // 로딩 완료
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "캠퍼스 명소",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2.0,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(15, 85, 190, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      body: Consumer<LandmarkViewModel>(
        builder: (context, provider, child) {
          landmarkList = landmarkViewModel.landmarkList;
          return ListView(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      final code = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => buildingCameraLocation(),
                        ),
                      );
                      setState(() {
                        buildingCode = code;
                        buildingName = code.replaceAll(RegExp(r'[^0-9]'), '');
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 30,),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.blue,
                          size: 24,
                        ),
                        SizedBox(width: 60),
                        Flexible(
                          child: Text(
                            '근처 건물을 촬영하여\n가까운 캠퍼스 명소를 찾아보세요',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        '현재 위치: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(6, 119, 229, 0.6509803921568628),
                        ),
                      ),
                      Text(buildingName),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Radio<bool>(
                                        value: true,
                                        groupValue: _orderByName,
                                        onChanged: (value) {
                                          setState(() {
                                            _orderByName = value!;
                                            _orderByDistance = !value;
                                          });
                                          _loadLandmarkOrderByName();



                                        },
                                      ),
                                      Text('ㄱ-ㅎ 이름순'),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Radio<bool>(
                                        value: true,
                                        groupValue: _orderByDistance,
                                        onChanged: (value) {
                                          setState(() {
                                            _orderByDistance = value!;
                                            _orderByName = !value;
                                          });
                                          _loadLandmarkOrderByDistance();


                                        },

                                      ),
                                      Text('가까운 거리순'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              _buildLandmarkBoxs(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLandmarkBoxs() {
    if (isLoading) {
      // 로딩 중인 경우
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: landmarkList.map((place) {
        return Column(
          children: [
            SizedBox(height: 10),
            _buildLandmarkBox(place),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildLandmarkBox(Place place) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          _showPopupDialog(place);
          // Handle button tap here
          // For example, you can navigate to a new screen or perform an action
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: MemoryImage(place.image!),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Text(
                        place.name!,
                        style: TextStyle(
                          fontSize: 24,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.blue,
                        ),
                      ),
                      Text(
                        place.name!,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

  void _showPopupDialog(Place place) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                place.name!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                place.info!, // 여기에 본문 텍스트 추가
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width * 0.95, // 화면 가로 길이의 95%
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54, // 배경 색상
                    borderRadius: BorderRadius.circular(5), // 굴곡 설정
                  ),
                  padding: EdgeInsets.all(5), // 내부 여백 설정
                  child: Image.memory(
                    place.image!, // 바이트 배열을 표시
                    fit: BoxFit.cover, // 이미지를 화면에 맞게 조절
                  ),
                ),
              ), // 이미지 추가
              SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: NaverMap(
                  forceGesture: true,
                  options: NaverMapViewOptions(
                    initialCameraPosition: NCameraPosition(
                      target: NLatLng(
                        place.latitude ?? 0.0,
                        place.longitude ?? 0.0,
                      ),
                      zoom: 16,
                      bearing: 280,
                    ),
                  ),
                  onMapReady: (controller) {
                    print("네이버 맵 로딩 완료!");
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 닫기 버튼
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
