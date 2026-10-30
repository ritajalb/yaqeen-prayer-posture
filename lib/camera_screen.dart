
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera_service.dart';
import 'model_service.dart';
//import 'package:audioplayers/audioplayers.dart';

class CameraScreen extends StatefulWidget {
  final String selectedPrayer; // الصلاة المختارة

  CameraScreen({required this.selectedPrayer});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraService cameraService = CameraService();
  ModelService modelService = ModelService();
//  AudioPlayer audioPlayer = AudioPlayer();
  String result = "انتظر...";
  bool isProcessing = false;

  // ✅ عدد الركعات لكل صلاة
  Map<String, int> prayerRakaa = {
    "الفجر": 2,
    "الظهر": 4,
    "العصر": 4,
    "المغرب": 3,
    "العشاء": 4
  };

  // ✅ ترتيب الصلاة الصحيح
  List<String> correctSequence = ["qiyam", "ruku", "qiyam", "sujud", "sitting", "sujud"];
  int currentStep = 0;
  int currentRakaa = 1;
  late int totalRakaa; // عدد الركعات المطلوبة

  @override
  void initState() {
    super.initState();
    totalRakaa = prayerRakaa[widget.selectedPrayer] ?? 2;
    initServices();
  }

  Future<void> initServices() async {
    await cameraService.initializeCamera();
    await modelService.loadModel();
    startFrameAnalysis();
    //playTakbeer();
    setState(() {});
  }

  void startFrameAnalysis() {
    cameraService.getCameraController()!.startImageStream((CameraImage image) async {
      if (!isProcessing) {
        isProcessing = true;
        String label = await modelService.predictFrame(image);

        checkPrayerStep(label);

        setState(() {
          result = label;
        });

        isProcessing = false;
      }
    });
  }

  void checkPrayerStep(String detectedPose) {
    if (detectedPose == correctSequence[currentStep]) {
      print("✅ صحيح: $detectedPose");
      if (currentStep < correctSequence.length - 1) {
        currentStep++;
      } else {
        currentStep = 0;
        currentRakaa++;

        if (currentRakaa > totalRakaa) {
          showErrorMessage("⚠️ لقد زدت عدد الركعات عن المطلوب!");
          //playErrorSound();
          currentRakaa = totalRakaa; // منع الزيادة
        } else {
          print("✅ تم تسجيل ركعة جديدة (${currentRakaa}/$totalRakaa)");
        }
      }
    } else {
      showErrorMessage("❌ خطأ! يجب أن تكون في وضعية ${correctSequence[currentStep]}");
      //playErrorSound();
    }
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

 // void playErrorSound() async {
 //   await audioPlayer.play(AssetSource("error_sound.mp3"));
 // }

 // void playTakbeer() async {
 //   await audioPlayer.play(AssetSource("takbeer.mp3")); // تأكد من إضافة ملف التكبير إلى assets
 // }

  @override
  void dispose() {
    cameraService.getCameraController()?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String selectedPrayer = (ModalRoute.of(context)?.settings.arguments as String?) ?? widget.selectedPrayer;

    return Scaffold(
      appBar: AppBar(title: Text("تحليل الصلاة: $selectedPrayer")),
      body: Column(
        children: [
          cameraService.getCameraController() != null &&
              cameraService.getCameraController()!.value.isInitialized
              ? CameraPreview(cameraService.getCameraController()!)
              : Center(child: CircularProgressIndicator()),
          SizedBox(height: 20),
          Text("الوضع الحالي: $result", style: TextStyle(fontSize: 24)),
          SizedBox(height: 10),
          Text("عدد الركعات: $currentRakaa / $totalRakaa", style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
