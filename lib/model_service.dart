import 'package:tflite/tflite.dart';

class ModelService {
  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
    print("Model Loaded: $res"); // تأكد من ظهور هذا في الـ Debug Console
  }


  Future<String> predictImage(String imagePath) async {
    var output = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 1, // أعلى نتيجة واحدة فقط
      threshold: 0.5, // الحد الأدنى للثقة
    );

    if (output != null && output.isNotEmpty) {
      return output[0]['label']; // إرجاع تصنيف الوضعية
    } else {
      return "غير معروف";
    }
  }
}




// import 'package:tflite/tflite.dart';
// import 'dart:typed_data';
// import 'package:camera/camera.dart';
// import 'package:image/image.dart' as img;
//
// class ModelService {
//   Future<void> loadModel() async {
//     await Tflite.loadModel(
//       model: "assets/model.tflite",
//       labels: "assets/labels.txt",
//
//     );
//     print("✅ تم تحميل المودل!");
//   }
//
//   Future<String> predictFrame(CameraImage image) async {
//
//     var output = await Tflite.runModelOnFrame(
//       bytesList: image.planes.map((plane) => plane.bytes).toList(),
//       imageHeight: image.height,
//       imageWidth: image.width,
//       numResults: 1,
//       threshold: 0.5,
//       asynch: true,
//     );
//
//
//     if (output != null && output.isNotEmpty) {
//       return output[0]['label'];  // اسم الوضعية
//     } else {
//       return "غير معروف";
//     }
//   }
//
//   Uint8List convertCameraImage(CameraImage image) {
//     try {
//       final int width = image.width;
//       final int height = image.height;
//       final int uvRowStride = image.planes[1].bytesPerRow;
//       final int uvPixelStride = image.planes[1].bytesPerPixel ?? 1;
//
//       // إنشاء صورة فارغة بحجم الكاميرا
//       img.Image imgBuffer = img.Image(width: width, height: height);
//
//       for (int y = 0; y < height; y++) {
//         for (int x = 0; x < width; x++) {
//           final int uvIndex = uvPixelStride * (x >> 1) + uvRowStride * (y >> 1);
//           final int index = y * width + x;
//
//           final int yValue = image.planes[0].bytes[index] & 0xFF;
//           final int uValue = image.planes[1].bytes[uvIndex] & 0xFF;
//           final int vValue = image.planes[2].bytes[uvIndex] & 0xFF;
//
//           // تحويل YUV إلى RGB
//           int r = (yValue + 1.370705 * (vValue - 128)).toInt();
//           int g = (yValue - 0.337633 * (uValue - 128) - 0.698001 * (vValue - 128)).toInt();
//           int b = (yValue + 1.732446 * (uValue - 128)).toInt();
//
//           imgBuffer.setPixel(x, y, img.ColorInt8.rgb(
//             r.clamp(0, 255),
//             g.clamp(0, 255),
//             b.clamp(0, 255),
//           ));
//         }
//       }
//
//       return Uint8List.fromList(img.encodeJpg(imgBuffer));
//     } catch (e) {
//       print("❌ خطأ في تحويل الصورة: $e");
//       return Uint8List(0);
//     }
//   }
// }
