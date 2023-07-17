import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path_provider/path_provider.dart';

class buildingSearch extends StatefulWidget {
  @override
  _buildingSearchState createState() =>
      _buildingSearchState();
}

class _buildingSearchState
    extends State<buildingSearch> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isDetecting = false;
  Interpreter? _interpreter;
  String _lastRecognizedObject = '제도관';

  @override
  void initState() {
    super.initState();
    setupCamera();
    // loadModel();
  }

  Future<void> setupCamera() async {
    _cameras = await availableCameras();
    _cameraController =
        CameraController(_cameras![0], ResolutionPreset.ultraHigh);
    await _cameraController!.initialize();
    if (!mounted) return;
    setState(() {});
    // startStreaming();
  }

  // Future<void> loadModel() async {
  //   var modelFile = await File('assets/model.tflite').create();
  //   var labelsFile = await File('assets/labels.txt').create();
  //   // _interpreter = await Interpreter.fromFile(modelFile.path);
  //   var labels = await labelsFile.readAsLines();
  //   print('Loaded model with ${labels.length} labels.');
  // }
  //
  // Future<void> startStreaming() async {
  //   _cameraController!.startImageStream((CameraImage image) {
  //     if (_isDetecting) return;
  //     _isDetecting = true;
  //     detectObjects(image);
  //   });
  // }
  //
  // Future<void> detectObjects(CameraImage image) async {
  //   if (_interpreter == null) return;
  //   try {
  //     var recognitions = await _interpreter!.run(image);
  //     if (recognitions.isNotEmpty) {
  //       var recognizedObject = recognitions[0]['label'];
  //       setState(() {
  //         _lastRecognizedObject = recognizedObject;
  //       });
  //       print('Detected object: $recognizedObject');
  //     }
  //   } finally {
  //     _isDetecting = false;
  //   }
  // }

  Future<String> captureImage() async {
    if (!_cameraController!.value.isInitialized) return '';

    final imageDirectory = await getTemporaryDirectory();
    final imagePath = '${imageDirectory.path}/${DateTime.now()}.png';

    try {
      await _cameraController!.takePicture(); //imagePAth들어가야함
      return imagePath;
    } catch (e) {
      print('Error capturing image: $e');
      return '';
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _cameraController!.value.previewSize!.height,
          height: _cameraController!.value.previewSize!.width,
          child: Stack(
            children: [
              CameraPreview(_cameraController!),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Last Recognized Object: $_lastRecognizedObject',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var imagePath = await captureImage();
          if (imagePath.isNotEmpty) {
            // 캡처된 이미지를 처리하는 코드 작성
          }
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}