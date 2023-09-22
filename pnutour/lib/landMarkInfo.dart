import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:pnutour/buildingCameraLocation.dart';
class LandMarkInfo extends StatefulWidget {
  const LandMarkInfo({Key? key}) : super(key: key);

  @override
  _LandMarkInfoState createState() => _LandMarkInfoState();
}

class Place {
  final String name;
  final int number;
  final String description;
  final String placeImagePath;
  final String mapImagePath;


  Place({
    required this.name,
    required this.number,
    required this.description,
    required this.placeImagePath,
    required this.mapImagePath,
  });
}

class _LandMarkInfoState extends State<LandMarkInfo> {

  bool _nearbyOnly = false;
  bool _showAll = true;
  String buildingCode="위치정보 없음";

  Map<String,Place> _places = {
    "10.16기념관":Place(
    name: '10.16기념관',
    number: 1,
    description:'2005년 부마민주항쟁 26주년을 맞이하여 10.16 민주항쟁의 진원지(부산대학교 효원회관 부근)을 기념하고, 민주항쟁 역사와 그 정신을 조명·계승하기 위해 ‘효원회관’을 대대적으로 리모델링하여 「10.16기념관」이라 명명하였습니다.\n\n'
  '이 기념관은 합창, 콘서트, 연극, 무용 등 공연이 가능한 380석 규모의 복합시설로 대학과 지역사회를 연결하여 10.16 정신을 기리고 있습니다.\n'
  '학기 중에는 매주 목요일 점심시간 상설공연인 ‘목요아트스페셜’이 개최됩니다.\n\n1979년 10월 15일 오후, 부산대학교 효원회관 부근에서 일어난 소규모 학생 시위가 우리나라 민주화를 향한 반독재 항쟁의 도화선이 된 상징적 사건입니다.\n독재 타도 궐기를 촉구하는 유인물이 살포되고, 교내 시위가 일어났습니다.\n\n다음 날 10월 16일 약 4천여명의 학생들이 재차 교정에 모여 유신 철폐와 독재 타도를 외치며 교내 시위를 하다가 시내 중심가로 진출하였고, 부산 시민들의 호응으로 야당 탄압 중지, 독재 타도 등 시위가 확대되었습니다.\n\n'
  '10월 18일 0시를 기하여 부산 일원에 비상계엄이 선포되었고, 부산 항쟁의 여파는 마산의 대규모 시위로 확산되어 10월 20일 창원·마산 지역에 위수령이 내려졌으며, 세력이 더욱 강화된 부마항쟁은 전국으로 확산되어 유신체제를 반대하는 민중 시위로 변모되었습니다.\n\n'
  '부산대학교 교정에서 점화된 민주화의 불길은 학생운동, 노동운동, 시민참여로 전국적·전민중적으로 확산되어 우리나라 민주화 역사에 큰 획을 그었습니다.',
    placeImagePath: 'assets/landmark/1.png',
    mapImagePath: '/landmarkmap/1.png',
  ),
    "무지개문":Place(
      name: '무지개문',
      number: 2,
      description:'무지개문 건립은 개교 10주년을 기념하여 1957년도에 초대 윤인구 총장의 구상으로 추진되었습니다.'
          '한국 현대건축의 선구자인 김중업 선생이 설계하고, 초창기의 학교 발전에 많은 공헌을 한 당시 박선기 부산대학교 후원회장(대선발효공업주식회사 사장)이 총 건립비를 출연하여 축조하였습니다.'
          '완만하게 고부라지는 진입로를 돌아들면 금정산과 캠퍼스의 녹음을 배경으로 하얀 무지개가 우아한 자태로 눈길을 끕니다. 이러한 아름다움을 문화재청으로부터 인정받아 2014년 10월 30일 인문관과 함께 무지개문 및 옛 수위실이 등록문화재로 등록되었습니다.'
          '2017년 1월 대학의 변화하는 이미지를 홍보하고, 야간 보행 환경 개선을 위하여 설치한 조명으로 야간에도 아름다운 무지개문의 자태를 감상할 수 있습니다.',
      placeImagePath: 'assets/landmark/2.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "문창대":Place(
      name: '문창대 및 문창대 60계단',
      number: 3,
      description:'1954년 10월 22일 우리 대학을 방문한 이선근 문교부장관은 당시 윤인구 총장이 새 교지를 효원이라 명명했음에 찬사를 표하고, 약학관 앞의 기암촉석을 발견하고는 그곳이 문창성이 비치는 곳이라고 하여 그 일대를 문창대로 명명하였습니다.'
          '문창대 60계단은 2006년 개교 60주년을 기념해 박종익(경영62), 이상직(상학63) 동문이 출연한 발전기금으로 문창대로 오르는 언덕에 조성했습니다.',
      placeImagePath: 'assets/landmark/3.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "미리내골":Place(
      name: '미리내골',
      number: 4,
      description:'미리내골은 1982년 재학생 및 교직원을 대상으로 한 계곡 이름 짓기 공모에서 당선작으로 선정된 이름입니다. 밤하늘의 미리내처럼 맑고 아름답다는 뜻입니다.'
          '미리내골은 그 경관이 아름다워 밤하늘 은하수에 비유하여 지어진 이름이지만 빛나는 별들이 모여 은하를 이루듯이 효원 인재들의 예지와 학문, 전통이 도도한 흐름으로 창일하기를 바라는 소망의 이름입니다. 미리내골에는 두 개의 아치형 다리가 있습니다.',
      placeImagePath: 'assets/landmark/4.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "콰이강의다리":Place(
      name: '콰이강의다리(미리내골)',
      number: 5,
      description:'박물관 별관과 인덕관 사이의 미리내골을 건너는 길이 14m, 폭 2m 크기의 자그마한 철다리로 영화 "콰이강의 다리"에 나오는 다리와 이미지가 비슷하다 하여 언젠가부터 ‘콰이강의 다리’로 불리어지고 있습니다. 초기에는 다리 바닥이 철판으로 되어 ‘천생연분이 지나가면 다리가 무너진다’ 하여 다리를 건너는 커플들은 일부러 쿵쾅거리며 지나갔었으나 현재는 철판 위에 아스팔트로 견고하게 보수가 되어있습니다.',
      placeImagePath: 'assets/landmark/5.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "미라보다리":Place(
      name: '미라보다리(미리내골)',
      number: 6,
      description:'인문대 교수연구동과 자연과학관을 이어주는 다리입니다. 파리 세느강의 ‘미라보 다리’와 이미지가 비슷하다 하여 ‘미라보 다리’로 불리어지고 있습니다.',
      placeImagePath: 'assets/landmark/6.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "미리마루":Place(
      name: '미리마루',
      number: 7,
      description:'보행자 안전 중심으로 조성된 미리내골을 따라 난 산책로 미리마루는 ‘은하수’를 뜻하는 ‘미리내’와 ‘산꼭대기’란 뜻의 우리말 ‘마루’를 합쳐 우리 대학이 세계 속에 우뚝한 최고의 대학이 되기를 기원하는 뜻의 이름',
      placeImagePath: 'assets/landmark/7.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "박물관":Place(
      name: '박물관',
      number: 8,
      description:'한국 현대 건축의 선구자인 김중업 선생이 고딕 스타일로 설계·시공하여 1959년 3월에 준공되었습니다. 초기에는 대학원, 도서관, 강당, 음악관으로 활용되다가 1993년 7월 현재의 별관에 있던 박물관 본관이 이전하였습니다. 전시실, 시청각실, 고인골실, 보존처리실, 자료실, 도서실 등이 있습니다.부산·경남의 대표적인 선사 및 고대문화 연구기관으로 남부지역 선사·가야문화자료를 발굴, 수집, 전시 및 보존하는 역할을 하고 있습니다. 다양한 분야 유물을 2만 5천여 점 소장하고 있습니다. '
          '별관은 1956년 3월에 준공되었습니다. 규모는 작지만 외관만으로 로코코 스타일을 느끼게 하며 벽면을 크고 작은 자연의 돌멩이로 축조하여 무구한 조형미를 감상할 수 있습니다. 건립 초기에는 국립중앙박물관의 피난 국보문화재를 수탁·보관하는 창고와 임시 교실로 활용되다가 1993년 7월에 현재의 본관으로 이전한 후 유물수장고로 활용되고 있습니다.',
      placeImagePath: 'assets/landmark/8.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "어울마당":Place(
      name: '어울마당',
      number: 9,
      description:'박물관 뒤편 동아리마당으로 어울마당은 ‘어울리다’와 ‘마당’을 합쳐 ‘함께 어우러져 어떤 일을 하는 자리’라는 뜻입니다.'
          '동아리 모임의 활성화와 다양한 사람들이 자유로운 만남을 통해 공동체 정신을 키워가길 바라는 염원이 담긴 이름입니다.',
      placeImagePath: 'assets/landmark/9.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "예원정":Place(
      name: '예원정(禮源庭)과 문창솔(文昌솔)',
      number: 10,
      description:'예원정(禮源庭)은 예의 근원이 되는 곳이라는 뜻의 사회관 앞 정원을 말합니다.'
          '문창(文昌)은 문운(文運)을 주관하는 별로 효원인의 학문과 기상이 이 푸른 소나무와 함께 상생하기를 기원하는 뜻에서 이 사회관 앞의 소나무를 문창솔이라 하였습니다.',
      placeImagePath: 'assets/landmark/10.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "운죽정":Place(
      name: '운죽정',
      number: 11,
      description:'1975년 당시 김종필 국무총리가 본교를 방문하여 희사한 600만원으로 지은 학생휴게실입니다.'
          '주변에 자생하는 대나무 숲과 금정산 Sky Line에 흐르는 구름이 멋진 조화를 이룬다는 뜻으로 ‘운죽정’이라 이름 지어졌습니다. 현재 카페로 활용되고 있으며 부산대학교 공식 기념품 등을 판매하고 있습니다.',
      placeImagePath: 'assets/landmark/11.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "웅비의탑":Place(
      name: '웅비의 탑',
      number: 12,
      description:'15m 탑신의 상층부에 세워진 독수리는 조각가 김세중 교수가 설계하여 높이 3m, 날개 길이 2.8m, 무게 3톤의 구리로 제작되었습니다. ‘창공으로 비상하려는 독수리’는 학문과 예지를 닦아 미래로 세계로 웅비하려는 효원인의 기상을 표현함에 이 탑을 일러 웅비의 탑이라 합니다.'
          '1987년 셀마 태풍 때 독수리가 날아감에 따라 우리 대학 미술학과 김정명 교수가 복원하여 1988년 5월 20일에 제막하였습니다. 독수리처럼 힘차게 뻗쳐오르는 효원인의 기개를 노래한 "독수리 송頌"을 탑신 하단부에 동판으로 새겼습니다.'
          '독수리송: 1972. 12. 5. 지은이 미상 여기 금정산 정기 받아 세워진 진리의 전당(殿堂)몇 천 몇 만의 슬기로운 일꾼들이 이 곳을 거쳤느니 진리 자유 봉사의 정신으로 마음을 가다듬고창공을 웅비하는 독수리로 기상을 삼았네.바위처럼 꿋꿋한 자체는 사해(四海)를 굽어보고한 번 날면 하늘의 왕자로서 기상(氣像)도 늠름(凜凜)하다.천리를 꿰뚫는 황금의 안광(眼光)'
          '천금만조(千禽萬鳥)를 습복(慴伏)시키는 용기를'
          '우리 부대인은 배우리',
      placeImagePath: 'assets/landmark/12.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "인덕관":Place(
      name: '인덕관',
      number: 13,
      description:'인덕관은 초대 총장 윤인구 박사의 건학 정신을 기리기 위하여 미망인 방덕수 여사가 1억원과 거주하던 아파트를 기증하여 건립되었습니다.'
          '1991년 4월 23일에 완공되었으며 단층 569.45㎡에 철근 콘크리트 라멘조의 복물형 양식으로 건축되었습니다. 대세미나실, 소세미나실, 기념홀 및 부속시설로 활용되며 윤인구 초대 총장의 유품이 전시되어 있습니다.',
      placeImagePath: 'assets/landmark/13.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "인문관":Place(
      name: '인문관',
      number: 14,
      description:'인문관은 우리 대학 초창기에 건축되어 부산대학교 역사를 말할 때 빠질 수 없는 주요한 건축물이며 우리나라 현대 건축의 선구자로 명망이 높은 여천 김중업(1922~1988) 선생이 설계한 한국 현대 건축의 처녀작입니다.'
          '1957년 7월에 착공하여 1959년 10월에 준공된 인문관은 우리나라 근대 모더니즘 건축의 대표적 작품으로 꼽힙니다. 약4억환의 예산으로 건축된 반달형 구조인 인문관은 길이가 140m, 지하 1층 지상4층 연면적 9,195㎡ 규모로 당시에는 초현대식 건물로 숱한 화제를 낳았습니다.'
          '인문관은 경사면을 따라 지형적 특징을 살리며 10개의 기둥벽이 건물을 떠받치고 있습니다. 필로티 양식이 반달형의 독특한 구조와 어우러져 멀리서 보면 화려한 여객선이 대양을 향하여 출항하는 듯합니다.+'
          '문화재청이 부산대학교 인문관을 우리나라 초기 모더니즘 건축을 대표하는 건축물로 인정, 근대문화유산 등록을 추진해 2014년 10월 30일 등록문화재로 최종 등록됐습니다.',
      placeImagePath: 'assets/landmark/14.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "정문홍보패널":Place(
      name: '정문 홍보패널',
      number: 15,
      description:'2016년에 개교 70주년 기념사업의 일환으로 대학의 얼굴이라고 할 수 있는 정문을 새롭게 정비하여 구성원들의 자긍심을 고취시키고, 대학을 방문하는 방문객과 시민들에게 대외적으로 부산대학교의 발전상과 메시지 등의 이미지를 홍보하는 공간으로 활용하고자 설치하였습니다. 뿐만아니라 늦은 저녁 정문을 밝혀주는 조명 역할도 하고 있습니다.',
      placeImagePath: 'assets/landmark/15.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "조각공원":Place(
      name: '조각공원',
      number: 16,
      description:'이상조(사회복지77) 동문의 기부로 캠퍼스의 친환경적 그린캠퍼스 및 문화캠퍼스를 구현하는 쾌적한 교육환경 조성을 목적으로 만들어진 생물관 앞의 공원입니다. 4,628㎡ 규모의 공원에 예술대학 교수들의 작품 8점이 설치되어 있습니다.',
      placeImagePath: 'assets/landmark/16.png',
      mapImagePath: '지도 이미지 주소',
    ),
    "해울못":Place(
      name: '해울못',
      number: 17,
      description:'해울못은 예술관 옆 생태연못입니다. ‘해울’이란 ‘이른 아침 풀잎에 맺히는 첫 이슬’을 이르는 우리말로 풀잎과 이슬의 깨끗하고 맑은 이미지가 복원된 생태연못에 잘 어울리는 이름입니다.',
      placeImagePath: 'assets/landmark/17.png',
      mapImagePath: '지도 이미지 주소'
    ),};




  @override
  void initState() {
    super.initState();
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
                  onPressed: () async {
                    final code = await Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => buildingCameraLocation(),
                    ));
                    print(buildingCode);
                    setState(() {
                      buildingCode = code;
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
                    Text(buildingCode),
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
                                    Text('가까운 거리순'),
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
                                    Text('ㄱ-ㅎ 글자순'),
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
            _buildLandmarkBoxs(_showAll, _nearbyOnly)
          ],
        ),
      ),
    );
  }

  Widget _buildLandmarkBoxs(bool _showAll, bool nearByOnly) {

    return Column(
      children: _places.keys.map((title) {
        final place = _places[title];
        final placeName = place?.name ?? '';
        final placeImagePath = place?.placeImagePath ?? ''; // Use an empty string as default if place or placeImagePath is null
        final placeDescription = place?.description ?? ''; // Use an empty string as default if place or placeImagePath is null

        return Column(
          children: [
            SizedBox(height: 10),
            _buildLandmarkBox(
              placeName,
              placeDescription,
              placeImagePath,
            ),
          ],
        );
      }).toList(),
    );
  }



  Widget _buildLandmarkBox(String title, String description, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          _showPopupDialog(title,description, imagePath);
          // Handle button tap here
          // For example, you can navigate to a new screen or perform an action
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
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
                        title,
                        style: TextStyle(
                          fontSize: 24,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.blue,
                        ),
                      ),
                      Text(
                        title,
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


  void _showPopupDialog(String title, String description, imagePath) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                description, // 여기에 본문 텍스트 추가
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Image.asset(imagePath), // 이미지 추가
              SizedBox(height: 16),
              SizedBox(height:300,child:  NaverMap(
                forceGesture: true,
                options: const NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(target: NLatLng(35.233052, 129.078465), zoom: 15, bearing: 280),
                ),
                onMapReady: (controler){
                  print("네이버 맵 로딩 완료!");
                },
              )),
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
