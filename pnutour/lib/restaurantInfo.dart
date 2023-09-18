import 'dart:convert';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class RestaurantInfo extends StatefulWidget {
  const RestaurantInfo({Key? key}) : super(key: key);

  @override
  _RestaurantInfoState createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  int _selectedButtonIndex = 0;
  List<String> buttonNameList = [
    "금정회관 학생",
    "금정회관 교직원",
    "샛벌회관",
    "학생회관 교직원",
    "학생회관 학생",
    "문창회관"
  ];
  List<double> latitude = [35.235388519818244,35.235388519818244,35.23415265271931,35.23509909319508,35.23509909319508,35.233944378942546];
  List<double> longitude = [129.0801642000777,129.0801642000777,129.07971527155115,129.07642245177314,129.07642245177314,129.08213175748338];

  List<String> time = ["","",""];
  List<List<String>> meal = [[],[],[]];
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadMealData();


  }

  Future<void> _loadMealData() async {
    if (true) const CircularProgressIndicator();
    if(_selectedButtonIndex==0){
      meal = await findMenu(today,"Geumjeong","student"); //금정회관 학생
    }
    else if(_selectedButtonIndex==1){
      meal = await findMenu(today,"Geumjeong","employee"); //금정회관 교직원
    }
    else if(_selectedButtonIndex==2){
      meal = await findMenu(today,"Saesbeol","student"); //금정회관 교직원
    }
    else if(_selectedButtonIndex==3){
      meal = await findMenu(today,"Pusan","employee"); //학생회관 교직원
      print(meal[1]);
    }
    else if(_selectedButtonIndex==4){
      meal = await findMenu(today,"Pusan","student"); //학생회관 학생
      print(meal[1]);
    }
    else if(_selectedButtonIndex==5){
      meal = [["푸드코트"," ","돈까스","함박세트","돈까스카레"," 닭다리카레","치킨가스","치킨마요덮밥","마라치킨마요덮밥","닭다리스테이크","(부타동)간장불고기덮밥","계란파볶음밥","돼지고기김치찌게","콩나물국밥","육개장","육개장칼국수","짜장면","짬뽕","꼬지어묵우동","우삼겹마라탕면","고기칼국수","우육탕면","양지쌀국수","왕만두국","공기밥","짜계치","통삼겹카레","큐브스테이크카레","탄탄면","꼬지어묵","밀면","쫄면","순두부짬뽕","가라아게카레덮밥"],["푸드코트"," ","돈까스","함박세트","돈까스카레"," 닭다리카레","치킨가스","치킨마요덮밥","마라치킨마요덮밥","닭다리스테이크","(부타동)간장불고기덮밥","계란파볶음밥","돼지고기김치찌게","콩나물국밥","육개장","육개장칼국수","짜장면","짬뽕","꼬지어묵우동","우삼겹마라탕면","고기칼국수","우육탕면","양지쌀국수","왕만두국","공기밥","짜계치","통삼겹카레","큐브스테이크카레","탄탄면","꼬지어묵","밀면","쫄면","순두부짬뽕","가라아게카레덮밥"],["푸드코트"," ","돈까스","함박세트","돈까스카레"," 닭다리카레","치킨가스","치킨마요덮밥","마라치킨마요덮밥","닭다리스테이크","(부타동)간장불고기덮밥","계란파볶음밥","돼지고기김치찌게","콩나물국밥","육개장","육개장칼국수","짜장면","짬뽕","꼬지어묵우동","우삼겹마라탕면","고기칼국수","우육탕면","양지쌀국수","왕만두국","공기밥","짜계치","통삼겹카레","큐브스테이크카레","탄탄면","꼬지어묵","밀면","쫄면","순두부짬뽕","가라아게카레덮밥"]]; //문창회관
      time=["","",""];
    }
    // await로 비동기 처리 기다리기
    setState(() {}); // 상태 업데이트를 위해 setState 호출
  }

  Future<List<List<String>>> findMenu(DateTime date,String restaurant,String type) async {
    date = date.subtract(Duration(days: 1));
    print("date"+date.toString());
    List<List<String>> newMeal = [[],[],[]];
    String url = 'https://m.pusan.ac.kr/ko/process/pusan/getMeal'+restaurant;
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded', // content-type 추가
      },
      body: {
        'date': date.toString(),
      },
    );

    if (response.statusCode == 200) {
      // JSON 파싱
      final jsonData = jsonDecode(response.body);

      if (jsonData['success'] == true) {
        print("api success");
        final responseJSON = jsonData['lists'];
        for (var item in responseJSON) {
          if(type=="student"&&(item['RESTAURANT_NAME']=="학생 식당"||item['RESTAURANT_NAME']=="식당")){
            if (item['MENU_TYPE']=="B" ){
              newMeal[0].add(item['MENU_TITLE']);
              newMeal[0].add(item['MENU_CONTENT']);
              newMeal[0].add("");
              time[0]=item['BREAKFAST_TIME'];
            }
            else if(item['MENU_TYPE']=="L"){
              newMeal[1].add(item['MENU_TITLE']);
              newMeal[1].add(item['MENU_CONTENT']);
              newMeal[1].add("");
              time[1]=item['LUNCH_TIME'];
            }
            else if(item['MENU_TYPE']=="D"){
              newMeal[2].add(item['MENU_TITLE']);
              newMeal[2].add(item['MENU_CONTENT']);
              newMeal[2].add("");
              time[2]=item['DINNER_TIME'];
            }
          }
          else if (!(item['RESTAURANT_NAME']=="학생 식당"||item['RESTAURANT_NAME']=="식당")){
            if (item['MENU_TYPE']=="B"){
              newMeal[0].add(item['MENU_TITLE']);
              newMeal[0].add(item['MENU_CONTENT']);
              newMeal[0].add("");
              time[0]=item['BREAKFAST_TIME'];
            }
            else if(item['MENU_TYPE']=="L"){
              newMeal[1].add(item['MENU_TITLE']);
              newMeal[1].add(item['MENU_CONTENT']);
              newMeal[1].add("");
              time[1]=item['LUNCH_TIME'];
            }
            else if(item['MENU_TYPE']=="D"){
              newMeal[2].add(item['MENU_TITLE']);
              newMeal[2].add(item['MENU_CONTENT']);
              newMeal[2].add("");
              time[2]=item['DINNER_TIME'];
            }
          }


        }
      } else {
        print('Request was successful, but "success" field is false.');
      }
    } else {
      print('POST request failed with status: ${response.statusCode}');
    }

    int maxLength = 0;
    for (List l in newMeal){
      if (l.isEmpty){
        l.add("식단 정보가 없습니다.");
      }
      int sumLength = 0;
      for (String str in l) {
        sumLength += str.length;
      }
      if (sumLength > maxLength) {
        maxLength = sumLength;
      }
    }
    //
    // for (List l in newMeal){
    //   int sumLength = 0;
    //   for (String str in l) {
    //     sumLength += str.length;
    //   }
    //   print(maxLength-sumLength);
    //   l.add("    "*(maxLength-sumLength));
    // }



    return newMeal;
  }

  Color _getButtonColor(int index) {
    return _selectedButtonIndex == index ? Colors.blue : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double boxWidth = (screenWidth - 20) / 3; // 20은 간격 및 여백 등의 총 합
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "식단표",
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
        body: ListView(
          children: [
            // 날짜와 화살표 Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue),
                  onPressed: () {
                    // 이전 버튼 클릭 시 처리
                    today = today.subtract(Duration(days: 1));
                    _loadMealData();
                  },
                ),
                Text(
                  today.year.toString() +"년 "+ today.month.toString().padLeft(2).replaceAll(" ", "0")+"월 "+today.day.toString().padLeft(2).replaceAll(" ", "0")+"일",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.blue),
                  onPressed: () {
                    today = today.add(Duration(days: 1));
                    _loadMealData();
                    // 다음 버튼 클릭 시 처리
                  },
                ),
              ],
            ),
            SizedBox(height: 10), // 간격 추가

            // 슬라이더 버튼들
            SizedBox(
              height: 50, // 각 버튼의 높이를 200으로 설정
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
                        _loadMealData();
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
                        backgroundColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blue; // 버튼이 눌린 상태에서는 파란색 배경
                          }
                          return _getButtonColor(index); // 기본적으로는 _getButtonColor 함수에서 색상 반환
                        }),
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.blue, width: 1)),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        minimumSize:
                        MaterialStateProperty.all(Size.zero), // 버튼의 최소 크기를 설정하지 않음
                      ),
                    ),
                  );
                },
              ),
            ),

            // 여기서부터 추가된 부분
            SizedBox(
              height: 20,
            ),

            // 각 버튼에 해당하는 메뉴를 출력하는 박스들 위의 조식, 중식, 석식 Text박스 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    '조식'+time[0],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(5, 26, 253, 1.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '중식'+time[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(5, 26, 253, 1.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '석식'+time[2],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(5, 26, 253, 1.0),
                    ),
                  ),
                ),
              ],
            ),

            // 각 버튼에 해당하는 메뉴를 출력하는 박스들
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 300,
                  width: boxWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.5),
                    child: SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.center,
                        child: _buildMenuBox(meal[0]),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: boxWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.5),
                    child: SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.center,
                        child: _buildMenuBox(meal[1]),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: boxWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.5),
                    child: SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.center,
                        child: _buildMenuBox(meal[2]),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            // 휴대폰 아래부분에 네모난 박스
            Container(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // 지도를 표시하는 위젯이 여기에 들어가야합니다.
                  // 예시로 Text 위젯으로 대체하겠습니다.
                  child: Center(
                    child: NaverMap(
                        forceGesture: true,
                      options:  NaverMapViewOptions(

                        initialCameraPosition: NCameraPosition(target: NLatLng(latitude[_selectedButtonIndex], longitude[_selectedButtonIndex]), zoom: 15, bearing: 280),
                      ),
                      onMapReady: (controler){
                        final marker = NMarker(id: "test", position: NLatLng(latitude[_selectedButtonIndex], longitude[_selectedButtonIndex]));
                        print("네이버 맵 로딩 완료!");
                      },
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 메뉴들을 출력하는 박스를 생성하는 메서드
  Widget _buildMenuBox(List<String> menuList) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          return Text(
            menuList[index],
            style: TextStyle(fontSize: 16),
          );
        },
      ),
    );
  }
}

