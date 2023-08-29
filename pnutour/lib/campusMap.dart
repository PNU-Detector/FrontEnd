import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class campusMap extends StatefulWidget {
  const campusMap({Key? key}) : super(key: key);

  @override
  _CampusMapState createState() => _CampusMapState();
}

class _CampusMapState extends State<campusMap> {
  int _selectedButtonIndex = 0;
  List<String> buttonNameList = [
    "건물",
    "조형물",
    "식당",
    "편의시설",
    "캠퍼스명소",
  ];

  @override
  void initState() {
    super.initState();
  }

  Color _getButtonColor(int index) {
    return _selectedButtonIndex == index ? Colors.blue : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "부산대학교",
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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(
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
//지도 들어가야함
          Expanded(child:  NaverMap(
            options: const NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(target: NLatLng(35.233052, 129.078465), zoom: 15, bearing: 280),
            ),
            onMapReady: (controler){
              print("네이버 맵 로딩 완료!");
            },
          ))

          ],
        ),
      ),
    );
  }

}



