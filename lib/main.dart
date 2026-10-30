
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'welcome_screen.dart';
import 'prayer_home_page.dart';
import 'prayer_times.dart';
import 'upload_image_page.dart'; // استبدال صفحة الكاميرا بصفحة تحميل الصور

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PrayerLearningApp());
}

class PrayerLearningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/home': (context) => PrayerHomePage(),
        '/prayertimes': (context) => const PrayerTimesScreen(),
        '/upload': (context) => UploadImagePage(), // صفحة رفع الصورة بدلاً من الكاميرا
      },
    );
  }
}

class ModelService {
  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
    print("✅ تم تحميل المودل: $res");
  }

  Future<String> predictImage(String imagePath) async {
    var output = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 1,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    if (output != null && output.isNotEmpty) {
      return output[0]['label'];  // اسم التصنيف المتوقع
    } else {
      return "غير معروف";
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:tflite/tflite.dart';
// import 'welcome_screen.dart';
// import 'prayer_home_page.dart';
// import 'prayer_times.dart';
// import 'camera_screen.dart';
//
// List<CameraDescription> cameras = [];
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   runApp(PrayerLearningApp());
// }
//
// class PrayerLearningApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const WelcomeScreen(),
//         '/home': (context) => PrayerHomePage(),
//         '/prayertimes': (context) => const PrayerTimesScreen(),
//         '/camera': (context) => CameraScreen(selectedPrayer: "الفجر"),  // تمرير اسم صلاة افتراضي
//       },
//     );
//   }
// }
//
//
// class ModelService {
//   Future<void> loadModel() async {
//     String? res = await Tflite.loadModel(
//       model: "assets/model.tflite",
//     );
//     print("✅ تم تحميل المودل: $res");
//   }
//
//   Future<String> predictImage(String imagePath) async {
//     var output = await Tflite.runModelOnImage(
//       path: imagePath,
//     );
//
//     if (output != null && output.isNotEmpty) {
//       return output[0]['label'];  // اسم التصنيف المتوقع
//     } else {
//       return "غير معروف";
//     }
//   }
// }


//
// import 'package:flutter/material.dart';
// import 'welcome_screen.dart';
// import 'prayer_home_page.dart';
// import 'prayer_times.dart';
//
// void main() {
//   runApp(PrayerLearningApp());
// }
//
// class PrayerLearningApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const WelcomeScreen(),
//         '/home': (context) => PrayerHomePage(),
//         '/prayertimes': (context) => const PrayerTimesScreen(),
//       },
//     );
//   }
// }
//
// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF123A6B), Color(0xFF123A6B).withOpacity(0.7)],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 90),
//               Text(
//                 "(رَبِّ اجْعَلْنِي مُقِيمَ الصَّلاَةِ وَمِن ذُرِّيَّتِي رَبَّنَا وَتَقَبَّلْ دُعَاء)",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontFamily: 'Cairo',
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Image.asset(
//                 'assets/yaqeenLogo.png', // تأكد من وجود الملف في المسار
//                 width: 500, // تكبير اللوقو بشكل كبير
//                 height: 500,
//               ),
//               Spacer(flex: 2),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   "Welcome to Yaqeen! Our app is here to help you\n"
//                       "learn the Islamic prayers (Salah) with ease.\n"
//                       "Yaqeen is here to guide you step-by-step\n"
//                       "and to correct your mistakes in real-time,\n"
//                       "making your learning journey easier.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white70,
//                     fontFamily: 'Times New Roman',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 40),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFADEBFF).withOpacity(0.90),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                   ),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/home');
//                   },
//                   child: Text(
//                     'Get Started',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class PrayerHomePage extends StatelessWidget {
//   final List<SalahInfo> prayers = [
//     SalahInfo(
//       title: 'Fajr',
//       youtubeUrl: 'https://youtu.be/Kuk6HgOH9yQ?si=ECZzzJFeoBOBCf4x',
//       description:
//       'Fajr is the first prayer of the day, observed before dawn. It signifies the beginning of a new day and is highly rewarded.',
//       sunnahRakats: 2,
//       additionalInfo: [
//         "Time: Before dawn",
//         "2 Sunnah rak'ahs before Fajr are highly recommended",
//         "Fajr has 2 obligatory rak'ahs"
//       ],
//     ),
//     SalahInfo(
//       title: 'Dhuhr',
//       youtubeUrl: 'https://youtu.be/Nq3Fa-mwNeE?si=FTsj-rg0AGM4uM-6',
//       description:
//       'Dhuhr is the second prayer of the day, prayed just after midday. It is a time to pause, reflect, and seek blessings during work hours.',
//       sunnahRakats: 4,
//       additionalInfo: [
//         "Time: Just after midday",
//         "4 Sunnah rak'ahs before and 2 after are recommended",
//         "Dhuhr has 4 obligatory rak'ahs"
//       ],
//     ),
//     SalahInfo(
//       title: 'Asr',
//       youtubeUrl: 'https://youtu.be/IoOSSoL-U7E?si=kIHJ_D8ShDwDkB5G',
//       description:
//       'Asr is prayed in the afternoon and serves as a reminder of the final part of the day. It encourages focus on responsibilities and gratitude.',
//       sunnahRakats: 0,
//       additionalInfo: [
//         "Time: Afternoon",
//         "No confirmed Sunnah rak'ahs, but 4 optional Sunnah before Asr are recommended",
//         "Asr has 4 obligatory rak'ahs"
//       ],
//     ),
//     SalahInfo(
//       title: 'Maghrib',
//       youtubeUrl: 'https://youtu.be/wmoxCD7vl_c?si=Y2V2VYRmsyWrv91W',
//       description:
//       'Maghrib is prayed just after sunset, marking the end of the day. It signifies the time to rest and reflect on the day’s activities.',
//       sunnahRakats: 2,
//       additionalInfo: [
//         "Time: Just after sunset",
//         "2 Sunnah rak'ahs after Maghrib are recommended",
//         "Maghrib has 3 obligatory rak'ahs"
//       ],
//     ),
//     SalahInfo(
//       title: 'Isha',
//       youtubeUrl: 'https://youtu.be/g9l4u_EIqOI?si=XFg4wjUFaVwC8Acd',
//       description:
//       'Isha is the final prayer of the day, observed at night. It represents peace and relaxation, and it’s a moment to end the day with worship.',
//       sunnahRakats: 2,
//       additionalInfo: [
//         "Time: Night",
//         "2 Sunnah rak'ahs after Isha and 3 Witr are recommended",
//         "Isha has 4 obligatory rak'ahs"
//       ],
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true, // تمديد الخلفية خلف الـ AppBar
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(CupertinoIcons.arrow_left, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFF9CCDDB).withOpacity(0.70), // الخلفية مع الشفافية 70%
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 50),
//                   Text(
//                     "Let's Learn!",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1C1C1C).withOpacity(0.9), // تغيير لون النص
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Salah is our most important daily meeting',
//                     style: TextStyle(fontSize: 16, color: Color(0xFF1C1C1C).withOpacity(0.8)),
//                   ),
//                   SizedBox(height: 24),
//                   Text(
//                     'Today Prayer',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1C1C1C).withOpacity(0.9), // تغيير لون النص
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   SizedBox(
//                     height: 260,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: prayers.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     PrayerDetailPage(salahInfo: prayers[index]),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             width: 200,
//                             margin: EdgeInsets.only(right: 16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.3),
//                                   spreadRadius: 2,
//                                   blurRadius: 5,
//                                   offset: Offset(0, 3),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.vertical(
//                                       top: Radius.circular(16)),
//                                   child: Image.asset(
//                                     'assets/${prayers[index].title.toLowerCase()}.png',
//                                     height: 140,
//                                     width: 200,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     prayers[index].title,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xFF1C1C1C).withOpacity(0.9), // تغيير لون النص
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Text(
//                                     'Tap to begin step-by-step guidance and learn the prayer',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Color(0xFF1C1C1C).withOpacity(0.8),
//                                     ),
//                                     maxLines: 3,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 24),
//                   Text(
//                     'Learn more about Salah',
//                     style: TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1C1C1C).withOpacity(0.9)),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Watch videos and follow detailed steps to help you understand the salah more.',
//                     style: TextStyle(fontSize: 16, color: Color(0xFF1C1C1C).withOpacity(0.8)),
//                   ),
//                   SizedBox(height: 16),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: prayers.map((prayer) {
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     PrayerDetailPage(salahInfo: prayer),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             margin: EdgeInsets.only(right: 16),
//                             decoration: BoxDecoration(
//                               color: Colors.blue.shade50,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Column(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.asset(
//                                     'assets/${prayer.title.toLowerCase()}.png',
//                                     height: 100,
//                                     width: 100,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   prayer.title,
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF1C1C1C).withOpacity(0.9), // تغيير لون النص
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   SizedBox(height: 24),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: Icon(CupertinoIcons.clock_fill, color: Colors.black),
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/prayertimes');
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class PrayerDetailPage extends StatefulWidget {
//   final SalahInfo salahInfo;
//
//   PrayerDetailPage({required this.salahInfo});
//
//   @override
//   _PrayerDetailPageState createState() => _PrayerDetailPageState();
// }
//
// class _PrayerDetailPageState extends State<PrayerDetailPage> {
//   late YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // استخراج معرف الفيديو
//     final Uri youtubeUrl = Uri.parse(widget.salahInfo.youtubeUrl);
//     final String? videoId = youtubeUrl.queryParameters['v'] ?? youtubeUrl.pathSegments.last;
//
//     // تحقق من وجود المعرف
//     if (videoId != null && videoId.isNotEmpty) {
//       _controller = YoutubePlayerController.fromVideoId(
//         videoId: videoId,
//         params: YoutubePlayerParams(
//           showControls: true,
//           showFullscreenButton: true,
//         ),
//       );
//     } else {
//       print('Invalid YouTube URL');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // الخلفية مع التدرج
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Color(0xFF123A6B), Color(0xFF123A6B).withOpacity(0.80)],
//               ),
//             ),
//             child: Column(
//               children: [
//                 // الفيديو بحجم كبير
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.4, // يشغل 40% من الشاشة
//                   width: double.infinity,
//                   child: YoutubePlayerScaffold(
//                     controller: _controller,
//                     aspectRatio: 16 / 9,
//                     builder: (context, player) {
//                       return player;
//                     },
//                   ),
//                 ),
//                 // المعلومات الإضافية
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'About ${widget.salahInfo.title}',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           widget.salahInfo.description,
//                           style: TextStyle(fontSize: 16, color: Colors.white70),
//                         ),
//                         SizedBox(height: 20),
//                         Text(
//                           'Additional Information:',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         ...widget.salahInfo.additionalInfo.map((info) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 4.0),
//                             child: Text(
//                               '• $info',
//                               style: TextStyle(fontSize: 16, color: Colors.white70),
//                             ),
//                           );
//                         }).toList(),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // زر Start Learning
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 40),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFADEBFF).withOpacity(0.80),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     ),
//                     onPressed: () {
//                       // Add functionality here
//                     },
//                     child: Text(
//                       'Start Learning',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // زر الرجوع
//           Positioned(
//             top: 40,
//             left: 16,
//             child: IconButton(
//               icon: Icon(CupertinoIcons.arrow_left, color: Colors.white),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.close();
//     super.dispose();
//   }
// }
//
// class SalahInfo {
//   final String title;
//   final String youtubeUrl;
//   final String description;
//   final int sunnahRakats;
//   final List<String> additionalInfo;
//
//   SalahInfo({
//     required this.title,
//     required this.youtubeUrl,
//     required this.description,
//     required this.sunnahRakats,
//     required this.additionalInfo,
//   });
// }
// class PrayerTimesScreen extends StatefulWidget {
//   const PrayerTimesScreen({super.key});
//
//   @override
//   _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
// }
//
// class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
//   PrayerTimes? prayerTimes;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchPrayerTimes();
//   }
//
//   void _fetchPrayerTimes() async {
//     try {
//       PrayerTimes times = await fetchPrayerTimes(21.492500, 39.177570, '2024-11-14');
//       setState(() {
//         prayerTimes = times;
//       });
//     } catch (e) {
//       print('Error fetching prayer times: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true, // تمديد الخلفية خلف الـ AppBar
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(CupertinoIcons.arrow_left, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           "Daily Prayer Times",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFF123A6B).withOpacity(0.8), // خلفية مع الشفافية 80%
//         ),
//         child: Center(
//           child: prayerTimes == null
//               ? CircularProgressIndicator(color: Colors.white)
//               : Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   'In this section, you can find the times for the five daily prayers. Make it a habit to pray on time and stay connected with Allah.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _buildPrayerTimeCard(
//                   "Fajr", prayerTimes!.fajr, CupertinoIcons.moon),
//               _buildPrayerTimeCard(
//                   "Dhuhr", prayerTimes!.dhuhr, CupertinoIcons.sun_max),
//               _buildPrayerTimeCard(
//                   "Asr", prayerTimes!.asr, CupertinoIcons.sun_min),
//               _buildPrayerTimeCard("Maghrib", prayerTimes!.maghrib,
//                   CupertinoIcons.sunset_fill),
//               _buildPrayerTimeCard(
//                   "Isha", prayerTimes!.isha, CupertinoIcons.moon_stars),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPrayerTimeCard(String prayer, String time, IconData icon) {
//     return Container(
//       height: 90,  // تحديد الارتفاع إلى 90
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Color(0xFFD0D7E1),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             spreadRadius: 1,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: Icon(icon, color: Color(0xFF123A6B), size: 30),
//         title: Text(
//           prayer,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         trailing: Text(
//           time,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// class PrayerTimes {
//   final String fajr;
//   final String dhuhr;
//   final String asr;
//   final String maghrib;
//   final String isha;
//
//   PrayerTimes({
//     required this.fajr,
//     required this.dhuhr,
//     required this.asr,
//     required this.maghrib,
//     required this.isha,
//   });
//
//   factory PrayerTimes.fromJson(Map<String, dynamic> json) {
//     return PrayerTimes(
//       fajr: json['data']['timings']['Fajr'],
//       dhuhr: json['data']['timings']['Dhuhr'],
//       asr: json['data']['timings']['Asr'],
//       maghrib: json['data']['timings']['Maghrib'],
//       isha: json['data']['timings']['Isha'],
//     );
//   }
// }
//
// Future<PrayerTimes> fetchPrayerTimes(
//     double latitude, double longitude, String date) async {
//   final String baseUrl = 'http://api.aladhan.com/v1/timings';
//   final url =
//   Uri.parse('$baseUrl?latitude=$latitude&longitude=$longitude&date=$date');
//   final response = await http.get(url);
//
//   if (response.statusCode == 200) {
//     return PrayerTimes.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load prayer times');
//   }
// }
//
//
