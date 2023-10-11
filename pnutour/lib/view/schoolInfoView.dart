import 'package:flutter/material.dart';

class schoolInfo extends StatefulWidget {
  const schoolInfo({Key? key}) : super(key: key);

  @override
  _ConvenienceState createState() => _ConvenienceState();
}

class _ConvenienceState extends State<schoolInfo> {
  int _selectedButtonIndex = 0;
  List<String> buttonNameList = [
    "상징",
    "캐릭터",
    "교육이념",
    "건학스토리",
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
            _buildContent(_selectedButtonIndex)
          ],
        ),
      ),
    );
  }

}



Widget _buildContent(int buttonIndex) {
  if (buttonIndex == 0) {
    return ListView(scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
      Text("상징",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(child:Image.asset("assets/home/pnulogo.png"),height: 200,),
      Text(
          "부산대학교 UI는 1981년 9월 부산대학교 제반표지에 관한 규정이 제정되면서 발전 변모된 교표의 모습을 오늘의 심벌로 이미지화 한 것으로 독수리ㆍ책ㆍㄱ,ㅂ,ㄷ도안화 심볼 도안화 심볼 ㆍ환(環)으로 구성되어있습니다. 여기서 독수리는 웅비ㆍ도약ㆍ희망을 뜻하고 '책'은 학문과 진리 탐구를, 그리고 ㄱ,ㅂ,ㄷ도안화 심볼 도안화 심볼은 국립부산대학교의 머리글자 ㄱ, ㅂ, ㄷ 을 도안화한 것입니다. 또한 바깥 부분의 둥근 '환'은 평화와 공존을 의미하고 있습니다.")
      ,
    ],);
  }
  else if (buttonIndex ==1) {
    return Expanded(child: ListView(scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Text("캐릭터",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(child:Image.asset("assets/schoolInfo/sanjinee.png") ,height: 200,)
        ,
        Text(
            "부산대학교 UI는 1981년 9월 부산대학교 제반표지에 관한 규정이 제정되면서 발전 변모된 교표의 모습을 오늘의 심벌로 이미지화 한 것으로 독수리ㆍ책ㆍㄱ,ㅂ,ㄷ도안화 심볼 도안화 심볼 ㆍ환(環)으로 구성되어있습니다. 여기서 독수리는 웅비ㆍ도약ㆍ희망을 뜻하고 '책'은 학문과 진리 탐구를, 그리고 ㄱ,ㅂ,ㄷ도안화 심볼 도안화 심볼은 국립부산대학교의 머리글자 ㄱ, ㅂ, ㄷ 을 도안화한 것입니다. 또한 바깥 부분의 둥근 '환'은 평화와 공존을 의미하고 있습니다.")
        ,
      ],));
  }
  else if (buttonIndex ==2) {
    return Expanded(child: ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,children: [
      Text(
        "교육이념 (진리, 자유, 봉사)",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 16),
      Text("진리",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      Text(
        "우리 대학은 진리를 추구하고, 상상력과 창의력에 기반한 학문적 발전을 도모하는 교육과 연구를 수행하여 한국을 대표하는 참 대학으로서 세계적 경쟁력을 확보하고, 이웃과 사회와 적극적으로 공감하며 시대를 통찰할 수 있는 창의적 통섭형 인재를 양성합니다.\n"
            "자유 우리 대학은 생명의 근본인 자유를 지키고, 상생과 협력 공동체 정신에 근거한 자유로운 진리 탐구와 교육을 수행하여, 국가와 인류의 발전을 위해 창의성을 적극 활용할 수 있는 능력과 태도를 가진 성숙한 지성인을 양성하는 참 대학입니다.\n"
            "봉사  우리 대학은 진리와 자유에 기반한 지식과 교육을 탐구하며, 인류애 실현과 사회·국가의 발전에 필요한 다양한 봉사를 제공하고자하며 개인적으로 사회가 필요로 하는 봉사 활동에 기꺼이 참여하는 태도와 덕성을 가진 지성인을 양성하고, 대학 차원에서 사회 발전과 평생 교육, 재교육 등의 봉사 활동 체제를 구축한 참 대학입니다.\n",
        // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16),
      ),
      Text("자유",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      Text(
        "우리 대학은 생명의 근본인 자유를 지키고, 상생과 협력 공동체 정신에 근거한 자유로운 진리 탐구와 교육을 수행하여, 국가와 인류의 발전을 위해 창의성을 적극 활용할 수 있는 능력과 태도를 가진 성숙한 지성인을 양성하는 참 대학입니다.\n",
        style: TextStyle(fontSize: 16),
      ),
      Text("봉사",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      Text(
        "우리 대학은 진리와 자유에 기반한 지식과 교육을 탐구하며, 인류애 실현과 사회·국가의 발전에 필요한 다양한 봉사를 제공하고자하며 개인적으로 사회가 필요로 하는 봉사 활동에 기꺼이 참여하는 태도와 덕성을 가진 지성인을 양성하고, 대학 차원에서 사회 발전과 평생 교육, 재교육 등의 봉사 활동 체제를 구축한 참 대학입니다.\n",
        // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16),
      ),
      
    ],));
  }
  else if (buttonIndex ==3) {
    return Expanded(child: ListView(scrollDirection: Axis.vertical,
        shrinkWrap: true
      ,children: [
      Text(
        "건학 스토리",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(
        "부산대학교는 1946년 5월 15일 지역민의 헌금으로 설립된 대한민국 최초의 종합 국립대학입니다. 산업화와 민주화를 이끌면서 대한민국 근현대사의 위대한 여정을 함께해오며 지역 거점국립대학으로서 소임을 다해왔습니다.\n",
        // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16),
      ),

      Text("시민 헌금으로 국립대학 설립기금 마련\n", // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(
        "1945년 해방 이후 국가체제도 제대로 갖추지 못한 어려운 환경에서도 대한민국을 이끌어갈 인재 양성의 열망은 뜨거웠습니다. 대한민국 정부수립(1948) 이전의 교육정책은 미군정에서 결정·집행하였고, 고등교육에 대한 개혁 방향은 일제강점기 시절의 전문학교를 4년제 대학으로 재편하는 데 있었습니다. 당시 경상남도 당국은 도민의 숙원인 국립대학 설립에 총력을 집중하여 미군정청이 제시한 국립대학 설립기금 1,000만 원 조달에 매진하였습니다. 고성의 옥천사는 사찰 소유의 토지 13만 5천 평(당시 500만 원 감정)을 내놓았고 지역민과 기업들은 십시일반 헌금을 모아 1,000만 원이 넘는 1,032만 9,000원의 기금을 마련해주었습니다. 이 중 1,000만 원은 미군정청 문교부에 국립대학 설립기금으로 납입하였고, 일부는 대학도서관을 채울 막대한 양의 장서 확보에 사용되었습니다.\n",
        // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16),
      ),
      Text("1946년 5월 15일 국내 최초의 종합국립대로 출범\n", // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(
        "국립대학 설립의 기초작업이 일단 완료된 뒤에는 당시 경상남도 학무과장이었던 윤인구 부산대 초대총장이 나서 대학 설립을 위한 제반 행정절차를 밟았습니다. 이에 1946년 5월 15일 윤인구 경상남도 학무과장과 학무과 고문관 에디 중위가 관계 기관과 협의하여 한미 양 문교부장의 최종 결재를 얻어냄으로써 국립부산종합대학교의 설립이 확정되었습니다. 정식 교명은 ‘국립 부산대학’으로 정해졌고, 인문학부와 수산학부의 두 학부가 개설되었습니다. 이때의 학부는 오늘날의 단과대학에 해당되는 것이었습니다. 1946년 3월 7일에 공포된 대학령 제2조 후단에는 인문계 및 자연계의 학부가 병설될 때는 2개 이상의 학부로써 ‘종합대학교’를 구성할 수 있도록 규정되어 있었습니다. 1946년 8월 22일 대학 명칭은 국립부산대학교, 학부 칭호는 인문과대학, 수산과대학으로 개칭되었다가 1948년 7월에 수산과대학은 ‘국립부산수산대학’으로, 인문과대학은 ‘국립 부산대학’으로 분리·확정되었습니다.\n",
        // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16),
      ),
      Text("윤인구 초대총장, 새벽벌에 진리·자유·봉사의 건학이념을 세우다\n", // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(
        "1953년 4월 3일에는 문리과대학·법과대학·상과대학·공과대학·약학대학·의과대학 등 6개 단과대학으로 구성된 ‘부산대학교’를‘종합대학교’로 승격하는 대통령 재가가 내려졌습니다. 부산대학교 인문과대학을 부산대학으로 변경한 뒤 신 종합대학교를 재건하기 위하여 끈질긴 노력을 기울인 쾌거였습니다. 같은 해 9월 15일 국립학교 설치령 개정에 의해‘부산대학교 설치령’이 대통령령으로 공포됨에 따라 부산대는 국립 종합대로 정식 출범하게 되었습니다. 11월 26일에는 총장서리였던 윤인구 박사가 초대총장으로 임명되었습니다.\n",
        // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16),
      ),
      Text("리처드 위트컴 미 군수사령관, 윤인구 총장캠퍼스 배치도에 감동해 적극 지원\n", // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(
        "윤인구 초대총장은 부산대가 1946년 대한민국 최초의 종합 국립대학으로 출범하고도 캠퍼스 부지 마련에 어려움을 겪는 데 고심하던 중 당시 유엔군 부산군수사령관이었던 위트컴 장군을 만나 자신이 직접 구상한 종 모양의 부산대 캠퍼스 배치도를 보여주고 이 나라 교육의 꿈과 비전을 제시하며 도움을 구하였습니다. 윤인구 초대총장의 꿈과 열정에 감동한 위트컴 장군은 현재의 부산 금정구 장전동 약 165만㎡(50만 평)의 부지를 확보하기 위하여 당시 이승만 대통령과 경남도지사를 설득하는 데 앞장서 부지 확보에 성공하였습니다. 위트컴 장군은 무상으로 양도받은 부산대 캠퍼스 부지의 시설 공사를 한국민사원조처(KCAC) 프로그램을 통해 원조하도록 하였으며, 미 공병부대를 동원하여 인근 온천동과 부산대 사이를 연결하는 도로를 개통시켰습니다.\n",
        // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16),
      ),
      Text(
        "자랑스러운 역사와 전통 위에 미래 100년의 꿈과 비전을 바로세우는 부산대학교\n", // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(
        "1953년 새롭게 종합대학교로 승격한 부산대학교는 다음해인 1954년 금정산 동쪽 기슭의 약 50만 평에 이르는 캠퍼스 부지를 확보하고 같은 해 12월 효원 교사 신축 기공식을 거행함으로써 서대신동·충무동 교사 시대를 지나 본격적인 ‘효원 시대’를 맞았습니다. ‘효원(曉原)’은 부산대를 일컫는 말로 윤인구 초대총장이 장전동의 캠퍼스 부지를 답사하며 새벽벌(曉原·효원)로 불렀다는 데서 유래하였습니다. 새벽벌인 효원 캠퍼스는 진리·자유·봉사의 원천이며 교육과 연구의 산실로서 부산대학교의 항구적인 보금자리로 터를 잡았습니다. 자랑스러운 역사와 전통을 바탕으로 미래 100년의 꿈과 비전을 바로세우고 있는 부산대학교가 세계 중심을 향한 힘찬 도약과 비상을 이어갑니다.\n",
        // 여기에 본문 텍스트 추가
        style: TextStyle(fontSize: 16),
      ),
    ],));
  }
  else if (buttonIndex ==4) {
    return Expanded(child: ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
    ],));
  }
  
  else{
    return Expanded(child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [

        ]
    ));
  }
}


