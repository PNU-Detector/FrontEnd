import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:pnutour/Building/buildingCamera.dart';
import 'package:pnutour/Building/buildingInfo.dart';
import 'package:pnutour/campusMap.dart';
import 'package:pnutour/convenience.dart';
import 'package:pnutour/landMarkInfo.dart';
import 'package:pnutour/restaurantInfo.dart';
import 'package:pnutour/schoolInfo.dart';
import 'package:pnutour/sculpture/sculptureCamera.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await NaverMapSdk.instance.initialize(
      clientId: 'xvg31y6sqw',
      onAuthFailed: (ex) {
        print("********* 네이버맵 인증오류 : $ex *********");
      });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Button Grid',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: Color.fromRGBO(15, 85, 190, 1)
      ),
      home: homepage(),
    );
  }
}
//test
class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width,maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => schoolInfo()),
                      );
                    },
                    child: Image.asset("assets/home/pnulogo.png"),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "부산대학교 캠퍼스",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 5.0,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "관광 해설앱",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 5.0,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.7, // 상대적인 너비 비율 조정
                      child: ButtonWidget("assets/home/building.png", "건물"),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.7, // 상대적인 너비 비율 조정
                      child: ButtonWidget("assets/home/sculpture.png", "조형물"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.7, // 상대적인 너비 비율 조정
                      child: ButtonWidget("assets/home/convenience.png", "편의시설"),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.7, // 상대적인 너비 비율 조정
                      child: ButtonWidget("assets/home/landmark.png", "캠퍼스명소"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.7, // 상대적인 너비 비율 조정
                      child: ButtonWidget("assets/home/restaurant.png", "식단표"),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.7, // 상대적인 너비 비율 조정
                      child: ButtonWidget("assets/home/map.png", "캠퍼스맵"),
                    ),
                  ),
                ],
              ),


            ],
          ),
        )
      ),

    );
  }
}


class ButtonWidget extends StatelessWidget {
  final String imagsrc;
  final String menuname;
  void function(){}
  ButtonWidget(this.imagsrc, this.menuname);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 110,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9)
      ),
      alignment: Alignment.center,
      child: Container(

          width: 70,
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(9)

          ),


          child: Column(
            children: [InkWell(
              onTap: (){
                if (menuname == "건물"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => buildingCamera()),
                    // context, MaterialPageRoute(builder: (context) => buildingInfo(buildingCode: "b201")),

                  );
                }
                else if (menuname == "조형물"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => sculptureCamera()),
                  );
                }
                else if (menuname == "식단표"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => RestaurantInfo()),
                  );
                }
                else if (menuname == "편의시설"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Convenience()),
                  );
                }
                else if (menuname == "캠퍼스명소"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LandMarkInfo()),
                  );
                }
                else if (menuname == "캠퍼스맵"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => campusMap()),
                  );
                }
              },
              child: Image.asset(
                '$imagsrc',
                width: 60, // 이미지 너비 조절
                height: 60, // 이미지 높이 조절
              ),
            ),
              Text(this.menuname,
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                  ))
            ],
          )

      ),
    );
  }
}

