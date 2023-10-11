import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class campusMap extends StatefulWidget {
  const campusMap({Key? key}) : super(key: key);

  @override
  _CampusMapState createState() => _CampusMapState();
}

class _CampusMapState extends State<campusMap> {
  int _selectedButtonIndex = 0;

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
//지도 들어가야함
          Expanded(child:  NaverMap(
            forceGesture: true,
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



