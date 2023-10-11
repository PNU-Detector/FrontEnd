import 'package:pnutour/view/Building/buildingCameraView.dart';
import 'package:pnutour/view/campusmapView.dart';
import 'package:pnutour/view/convenienceInfoView.dart';
import 'package:pnutour/view/landMarkInfoView.dart';
import 'package:pnutour/view/restaurantInfoView.dart';
import 'package:pnutour/view/schoolInfoView.dart';
import 'package:pnutour/view/sculpture/sculptureCameraView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnutour/viewModel/convenienceViewModel.dart';
import 'package:pnutour/viewModel/restaurantViewModel.dart';
import 'package:provider/provider.dart';

import '../viewModel/buildingViewModel.dart';
import '../viewModel/homeViewModel.dart';
import '../viewModel/landmarkViewModel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();

}

class _HomeViewState extends State<HomeView>{
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
                    context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider<BuildingViewModel>(
                    create: (context) => BuildingViewModel(),
                    child: BuildingCamera(),
                  ),),
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
                    context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider<RestaurantViewModel>(
                    create: (context) => RestaurantViewModel(),
                    child: const RestaurantInfo(),
                  ),),
                  );
                }
                else if (menuname == "편의시설"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider<ConvenienceViewModel>(
                    create: (context) => ConvenienceViewModel(),
                    child: const ConvenienceInfoView(),
                  ),),
                  );
                }
                else if (menuname == "캠퍼스명소"){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider<LandmarkViewModel>(
                    create: (context) => LandmarkViewModel(),
                    child: const LandMarkInfoView(),
                  ),),
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
