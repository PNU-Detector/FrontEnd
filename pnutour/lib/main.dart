import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:pnutour/view/Building/buildingCameraView.dart';
import 'package:pnutour/view/Building/buildingInfoView.dart';
import 'package:pnutour/view/campusmapView.dart';
import 'package:pnutour/view/convenienceInfoView.dart';
import 'package:pnutour/view/homeView.dart';
import 'package:pnutour/view/landMarkInfoView.dart';
import 'package:pnutour/view/restaurantInfoView.dart';
import 'package:pnutour/view/schoolInfoView.dart';
import 'package:pnutour/view/sculpture/sculptureCameraView.dart';
import 'package:flutter/services.dart';
import 'package:pnutour/viewModel/homeViewModel.dart';
import 'package:provider/provider.dart';


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
      home: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
        child: const HomeView(),
      ),
      title: 'Button Grid',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: Color.fromRGBO(15, 85, 190, 1),
      ),
    );
  }
}

