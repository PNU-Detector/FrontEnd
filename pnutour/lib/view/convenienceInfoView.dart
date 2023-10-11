import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:pnutour/view/buildingCameraLocationView.dart';
import 'package:provider/provider.dart';

import '../model/place.dart';
import '../viewModel/convenienceViewModel.dart';

class ConvenienceInfoView extends StatefulWidget {
  const ConvenienceInfoView({Key? key}) : super(key: key);

  @override
  _ConvenienceInfoViewState createState() => _ConvenienceInfoViewState();
}

class _ConvenienceInfoViewState extends State<ConvenienceInfoView> {
  int _selectedButtonIndex = 0;
  List<String> buttonNameList = [
    "카페",
    "프린트",
    "편의점"
  ];
  List<String> convenienceType = [
    "cafe",
    "print",
    "convenience"
  ];
  bool _orderByDistance = false;
  bool _orderByName = true;
  late String buildingCode;
  String buildingName = "위치정보 없음";
  bool isLoading=true;
  late List<Place> convenienceList;
  final ConvenienceViewModel convenienceViewModel = ConvenienceViewModel();
  @override
  void initState() {
    super.initState();
    _loadConvenienceOrderByName();
  }
  Future<void> _loadConvenienceOrderByName() async {
    try {
      isLoading = true;
      await convenienceViewModel.getConvenienceListOrderByName(convenienceType[_selectedButtonIndex]);
      setState(() {
        isLoading = false; // 로딩 완료
        convenienceList = convenienceViewModel.convenienceList;
      });
    } catch (e) {
      // 에러 처리
      print("API 호출 에러: $e");
      setState(() {
        isLoading = false; // 로딩 완료
      });
    }
  }
  Future<void> _loadConvenienceOrderByDistance() async {
    try {
      isLoading = true;
      await convenienceViewModel.getConvenienceListOrderByDistance(convenienceType[_selectedButtonIndex], buildingCode);
      setState(() {
        isLoading = false; // 로딩 완료
        convenienceList = convenienceViewModel.convenienceList;
        _orderByDistance = false;
        _orderByName = true;
      });
    } catch (e) {
      // 에러 처리
      print("API 호출 에러: $e");
      setState(() {
        isLoading = false; // 로딩 완료
      });
    }
  }
  Future<void> _loadLocation() async {
    try {
      isLoading = true;
      await convenienceViewModel.getBuildingName(buildingCode);
      setState(() {
        buildingName = convenienceViewModel.buildingName;
        _loadConvenienceOrderByName();
        isLoading = false; // 로딩 완료
      });
    } catch (e) {
      // 에러 처리
      print("API 호출 에러: $e");
      setState(() {
        isLoading = false; // 로딩 완료
      });
    }
  }

  Color _getButtonColor(int index) {
    return _selectedButtonIndex == index ? Colors.blue : Colors.white;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "편의시설",
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
      body: Consumer<ConvenienceViewModel>(
        builder: (context, provider, child) {
          convenienceList = convenienceViewModel.convenienceList;
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
                        _loadLocation();
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
                                          _loadConvenienceOrderByName();


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
                                          _loadConvenienceOrderByDistance();



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
              ),SizedBox(
                height: 50,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.3),
                  onPageChanged: (index) {
                    setState(() {
                      _selectedButtonIndex = index;
                    });
                  },
                  itemCount: buttonNameList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          // 버튼 클릭 시 선택된 버튼 인덱스 설정
                          setState(() {
                            _selectedButtonIndex = index;
                            _orderByName=true;
                            _orderByDistance=false;
                            _loadConvenienceOrderByName();
                          });
                        },
                        child: Container(
                          width: buttonNameList[index].length * 18.0,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              buttonNameList[index],
                              style: TextStyle(
                                color: _selectedButtonIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18, // 버튼의 높이로 글자 크기 설정
                              ),
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue; // 버튼이 눌린 상태에서는 파란색 배경
                            }
                            return _getButtonColor(index); // 기본적으로는 _getButtonColor 함수에서 색상 반환
                          }),
                          side: MaterialStateProperty.all(BorderSide(color: Colors.blue, width: 1)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildConvenienceBoxs(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildConvenienceBoxs() {
    if (isLoading) {
      // 로딩 중인 경우
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: convenienceList.map((place) {
        return Column(
          children: [
            SizedBox(height: 10),
            _buildConvenienceBox(place),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildConvenienceBox(Place place) {
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
