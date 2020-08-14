import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  List<CameraDescription> cameras = [];
  CameraController controller;
  int selectedCameraIdx;

  @override
  void initState() {
    super.initState();
    availableCameras().then(
            (value) {
              cameras = value;
              if (cameras.length > 0) {
                setState(() {
                  // 2
                  selectedCameraIdx = 0;
                });
                controller = CameraController(cameras[selectedCameraIdx], ResolutionPreset.medium);
                controller.initialize().then((_) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {});
                });

              }else{
                print("No camera available");
              }
            }).catchError((err) {
      // 3
      print('Error: $err.code\nError Message: $err.message');
    });


  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!controller.value.isInitialized) {
      return Container();
    }
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height/1.2,
            child: CameraPreview(controller)),
        Icon(Icons.camera,size: 60,color: Colors.white,)
      ],
    );
  }

  Future<void> getCameras() async{
    cameras = await availableCameras();
    print('hello');
  }
}
