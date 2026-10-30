import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart' as webPicker;
import 'dart:io' show File;
import 'package:tflite/tflite.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  Uint8List? _imageBytes; // للويب
  File? _imageFile; // للموبايل
  String _result = "لم يتم التعرف على الوضعية بعد.";

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  // تحميل النموذج
  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  // اختيار صورة
  Future<void> pickImage() async {
    if (kIsWeb) {
      // للويب: استخدام image_picker_web
      Uint8List? bytesFromPicker = await webPicker.ImagePickerWeb.getImageAsBytes();
      if (bytesFromPicker != null) {
        setState(() {
          _imageBytes = bytesFromPicker;
          _imageFile = null; // تصفير الصورة في الهاتف لمنع التضارب
        });
        analyzeImageWeb(_imageBytes!);
      }
    } else {
      // للهاتف: استخدام image_picker
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _imageBytes = null; // تصفير الصورة في الويب لمنع التضارب
        });
        analyzeImageMobile(_imageFile!);
      }
    }
  }

  // تحليل الصورة على الهاتف
  Future<void> analyzeImageMobile(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _result = recognitions != null && recognitions.isNotEmpty
          ? recognitions[0]['label']
          : "لم يتم التعرف على الوضعية.";
    });
  }

  // تحليل الصورة على الويب
  Future<void> analyzeImageWeb(Uint8List imageBytes) async {
    var recognitions = await Tflite.runModelOnBinary(
      binary: imageBytes,
      numResults: 1,
      threshold: 0.5,
      asynch: true,
    );

    setState(() {
      _result = recognitions != null && recognitions.isNotEmpty
          ? recognitions[0]['label']
          : "لم يتم التعرف على الوضعية.";
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تحليل وضعية الصلاة")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageBytes != null
                ? Image.memory(_imageBytes!, width: 200, height: 200, fit: BoxFit.cover) // للويب
                : _imageFile != null
                ? Image.file(_imageFile!, width: 200, height: 200, fit: BoxFit.cover) // للهاتف
                : const Icon(Icons.image, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text("اختر صورة"),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
