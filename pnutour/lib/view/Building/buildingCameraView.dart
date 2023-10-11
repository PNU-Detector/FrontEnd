import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:pnutour/view//Building//buildingInfoView.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';


class BuildingCamera extends StatefulWidget {
  @override
  _BuildingCameraState createState() => _BuildingCameraState();
}

class _BuildingCameraState extends State<BuildingCamera> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isLoading = false; // API 요청 중 여부를 나타내는 변수
  String errorMessage = ''; // 에러 메시지를 저장하는 변수
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      CameraDescription(
        name: '0', // 카메라 디바이스 선택 (0은 후면 카메라, 1은 전면 카메라)
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 180,
      ),
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_controller),
                ); // 카메라 뷰 미리보기
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context); // 이전 화면으로 돌아가는 기능
                    },
                  ),
                  Text(
                    errorMessage.isNotEmpty ? errorMessage : '건물을 비추고 검색버튼을 눌러주세요',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 40.0), // 오른쪽 여백
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: isLoading
                  ? CircularProgressIndicator() // 로딩 아이콘 표시
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(150, 60),
                  primary: Colors.transparent, // 버튼 배경색 투명
                  onPrimary: Colors.white, // 텍스트 색상 흰색
                  side: BorderSide(color: Colors.white, width: 1.0), // 테두리 스타일
                ),
                onPressed: () async {
                  try {
                    setState(() {
                      isLoading = true; // 버튼을 누르면 로딩 상태로 변경
                      errorMessage = ''; // 에러 메시지 초기화
                    });



                    ///////////////////////////////////////////////////////////////////
                    //사진 촬영 및 api 통신




                    final XFile? picture = await _controller.takePicture(); // 사진 촬영


                    // API 요청 코드...
                    // 촬영된 사진을 API에 전송 (http 패키지 사용)
                    String url = 'http://54.180.198.149:8000/detect/';
                    MultipartFile _file=MultipartFile.fromFileSync(picture!.path,  contentType: new MediaType("image", "jpg"));

                    FormData _formData = FormData.fromMap({"file": _file});
                    Dio dio = Dio();
                    dio.options.contentType = 'multipart/form-data';
                    final response = await dio.post(url, data: _formData);
                      print('========================');
                      print("status: "+ response.statusCode.toString());
                      print("error: "+response.data['error'].toString());
                      print("label: "+response.data['label'].toString());
                      print('========================');


                      if (response.statusCode == 200) {
                        // 성공적인 응답 처리
                        // API 요청이 성공한 경우 다음 페이지로 이동
                        if (response.data['label']!=null) {
                          String buildingCode = response.data['label'];
                          setState(() {
                            isLoading = false; // 로딩 상태 해제
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BuildingInfo(buildingCode : buildingCode)),
                          );
                        }else{
                          setState(() {
                            isLoading = false; // 로딩 상태 해제
                            errorMessage = '건물인식실패, 다시 시도해주세요.';
                          });
                        }
                      }
                      else {
                            setState(() {
                            isLoading = false; // 로딩 상태 해제
                            errorMessage = '오류가 발생했습니다. 다시 시도해주세요.';
                            });
                      }
                    } catch (e) {
                    setState(() {
                      isLoading = false; // 로딩 상태 해제
                      errorMessage = '오류가 발생했습니다. 다시 시도해주세요.';
                    });
                    print('Error: $e');
                  }
                },
                child: Text('검색'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

