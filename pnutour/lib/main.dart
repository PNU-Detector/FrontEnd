import 'package:flutter/material.dart';
import 'package:pnutour/buildingSearch.dart';
import 'package:pnutour/campusMap.dart';
import 'package:pnutour/convenience.dart';
import 'package:pnutour/landMarkInfo.dart';
import 'package:pnutour/museumSearch.dart';
import 'package:pnutour/restaurantInfo.dart';
import 'package:pnutour/schoolInfo.dart';
import 'package:pnutour/sculptureSearch.dart';


// git test
// git test2

//test
void main() {
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

class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  child: Image.asset("assets/pnulogo.png"),
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
                    widthFactor: 0.9, // 상대적인 너비 비율 조정
                    child: ButtonWidget("assets/building.png", "건물"),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.9, // 상대적인 너비 비율 조정
                    child: ButtonWidget("assets/sculpture.png", "조형물"),
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
                    widthFactor: 0.9, // 상대적인 너비 비율 조정
                    child: ButtonWidget("assets/museum.png", "박물관"),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.9, // 상대적인 너비 비율 조정
                    child: ButtonWidget("assets/restaurant.png", "식단표"),
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
                    widthFactor: 0.9, // 상대적인 너비 비율 조정
                    child: ButtonWidget("assets/convenience.png", "편의시설"),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.9, // 상대적인 너비 비율 조정
                    child: ButtonWidget("assets/landmark.png", "캠퍼스명소"),
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
                    widthFactor: 0.9, // 상대적인 너비 비율 조정
                    child: ButtonWidget("assets/map.png", "캠퍼스맵"),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.9 , // 상대적인 너비 비율 조정
                    child: ButtonWidget("assets/map.png", "캠퍼스맵"),
                  ),
                ),
              ],
            ),
          ],
        ),
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
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9)
      ),
      alignment: Alignment.center,
      child: Container(

          width: 80,
          height: 103,
          decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(9)

          ),


          child: Column(
            children: [InkWell(
              onTap: (){
                if (menuname == "건물"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => buildingSearch()),
                  );
                }
                else if (menuname == "조형물"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => scultureSerach()),
                  );
                }
                else if (menuname == "박물관"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => museumSearch()),
                  );
                }
                else if (menuname == "식단표"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => restaurantInfo()),
                  );
                }
                else if (menuname == "편의시설"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => convenience()),
                  );
                }
                else if (menuname == "캠퍼스명소"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => landMarkInfo()),
                  );
                }
                else if (menuname == "캠퍼스맵"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => campusMap()),
                  );
                }
              },
              child: Image.asset('$imagsrc'),
            ),
              Text(this.menuname,
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ))
            ],
          )

      ),
    );
  }
}

