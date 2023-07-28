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

  List<List<String>> time = [["08:20~11:00","11:00~17:00","17:00~18:30"],["","11:00~15:00",""],["","11:00~14:00",""],["","11:00~14:00",""],["","10:30~16:30","16:30~18:20"],["","",""]];
  List<List<String>> geumjungStudent = [
    ["금정회관학생", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"]
  ];

  List<List<String>> geumjungEmployee = [
    ["금정회관교직원식당", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"]
  ];

  List<List<String>> munchang = [
    ["문창", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"]
  ];

  List<List<String>> hallStudent = [
    ["학생회관학생", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"]
  ];

  List<List<String>> hallEmployee = [
    ["학생회관교직원", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"]
  ];

  List<List<String>> satbull = [
    ["샛벌", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"],
    ["백미밥", "닭개장", "돈육버섯간장불고기", "푸실리햄볶음", "두부조림", "다시마채볶음", "김치"]
  ];

  @override
  void initState() {
    super.initState();
    getMenuByCrawlling();
  }

  Future<void> getMenuByCrawlling() async {
    final url =
        'https://www.pusan.ac.kr/kor/CMS/MenuMgr/menuListOnBuilding.do?mCode=MN202&campus_gb=PUSAN&building_gb=R004&restaurant_code=PH002';
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      // HTML 응답 파싱
      var document = parse(response.body);
      List<Element> menuItems =
      document.querySelectorAll('.menuName').cast<Element>();
      setState(() {}); // 새로운 데이터로 UI 업데이트
    }
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
                  },
                ),
                Text(
                  '2023.07.27(목)',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.blue),
                  onPressed: () {
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
                    '조식'+time[_selectedButtonIndex][0],
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
                    '중식'+time[_selectedButtonIndex][1],
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
                    '석식'+time[_selectedButtonIndex][2],
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
              crossAxisAlignment: CrossAxisAlignment.start, // 위쪽 정렬
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _buildMenuBox(
                      _selectedButtonIndex == 0
                          ? geumjungStudent[0]
                          : _selectedButtonIndex == 1
                          ? geumjungEmployee[0]
                          : _selectedButtonIndex == 2
                          ? satbull[0]
                          : _selectedButtonIndex == 3
                          ? hallEmployee[0]
                          : _selectedButtonIndex == 4
                          ? hallStudent[0]
                          : munchang[0],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _buildMenuBox(
                      _selectedButtonIndex == 0
                          ? geumjungStudent[1]
                          : _selectedButtonIndex == 1
                          ? geumjungEmployee[1]
                          : _selectedButtonIndex == 2
                          ? satbull[1]
                          : _selectedButtonIndex == 3
                          ? hallEmployee[1]
                          : _selectedButtonIndex == 4
                          ? hallStudent[1]
                          : munchang[1],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _buildMenuBox(
                      _selectedButtonIndex == 0
                          ? geumjungStudent[2]
                          : _selectedButtonIndex == 1
                          ? geumjungEmployee[2]
                          : _selectedButtonIndex == 2
                          ? satbull[2]
                          : _selectedButtonIndex == 3
                          ? hallEmployee[2]
                          : _selectedButtonIndex == 4
                          ? hallStudent[2]
                          : munchang[2],
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
                    child: Text(
                      '지도',
                      style: TextStyle(fontSize: 24),
                    ),
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
