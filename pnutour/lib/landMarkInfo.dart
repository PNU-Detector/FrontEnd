import 'package:flutter/material.dart';

class LandMarkInfo extends StatefulWidget {
  const LandMarkInfo({Key? key}) : super(key: key);

  @override
  _LandMarkInfoState createState() => _LandMarkInfoState();
}

class _LandMarkInfoState extends State<LandMarkInfo> {
  int _selectedButtonIndex = 0;
  List<String> buttonNameList = [
    "전체",
    "조형물",
    "카더라",
    "흡연구역",
    "운동시설",
    "우체국",
    "자판기",
  ];
  bool _nearbyOnly = false;
  bool _showAll = true;

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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
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
                  onPressed: () {},
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
                    Text("테스트건물명"),
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
                                      groupValue: _nearbyOnly,
                                      onChanged: (value) {
                                        setState(() {
                                          _nearbyOnly = value!;
                                          _showAll = !value;
                                        });
                                      },
                                    ),
                                    Text('근처추천'),
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
                                      groupValue: _showAll,
                                      onChanged: (value) {
                                        setState(() {
                                          _showAll = value!;
                                          _nearbyOnly = !value;
                                        });
                                      },
                                    ),
                                    Text('전체보기'),
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
            SizedBox(
              height: 10,
            ),
            // Add image boxes with icons and text
            _buildLandmarkBox(
              '명소1',
              Icons.expand_more_sharp, // First icon
            ),

            SizedBox(height: 10),

            _buildLandmarkBox(
              '명소2',
              Icons.expand_more_sharp,
            ),

            SizedBox(height: 10),

            _buildLandmarkBox(
              '명소3',
              Icons.expand_more_sharp,
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the landmark box with icons and text
  Widget _buildLandmarkBox(String title, IconData firstIcon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 150, // Set the width for the image box

              child: Icon(
                Icons.photo, // You can replace this with the actual image
                size: 150,
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Column(
              children: [SizedBox(height: 140,),
                IconButton(
                  onPressed: () {
                    // Handle the first icon button press
                  },
                  icon: Icon(firstIcon),
                  color: Colors.blue,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}