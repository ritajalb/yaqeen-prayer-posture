//





import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'prayer_detail_page.dart';
import 'salah_info.dart';

class PrayerHomePage extends StatefulWidget {
  @override
  State<PrayerHomePage> createState() => _PrayerHomePageState();
}

class _PrayerHomePageState extends State<PrayerHomePage> {
  int _selectedIndex = 1;

  final List<SalahInfo> prayers = [
    // [نفس قائمة الصلاة اللي عندك، بدون تغيير]
  ];

  final List<Map<String, String>> arabicPrayers = [
    {"name": "الفجر", "image": "assets/fajr.png"},
    {"name": "الظهر", "image": "assets/dhuhr.png"},
    {"name": "العصر", "image": "assets/asr.png"},
    {"name": "المغرب", "image": "assets/maghrib.png"},
    {"name": "العشاء", "image": "assets/isha.png"},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // التنقل بناءً على العنصر
    if (index == 0) {
      Navigator.pushNamed(context, '/azkar'); // صفحة الأذكار
    } else if (index == 1) {
      // الصفحة الحالية
    } else if (index == 2) {
      Navigator.pushNamed(context, '/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B1D2B), // لون خلفية مطابق للصورة
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'صلاتي',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'اختر صلاة لحساب عدد الركعات بشكل صحيح',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: List.generate(prayers.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrayerDetailPage(salahInfo: prayers[index]),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF14222F),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.brightness_2, // ايقونة تشبه القمر
                              size: 40,
                              color: Color(0xFFF9A826),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'صلاة ${arabicPrayers[index]["name"]!}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),

      /// شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF0B1D2B),
        selectedItemColor: Color(0xFFF9A826),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome), // أيقونة الأذكار
            label: 'الأذكار',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }
}


//
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'prayer_detail_page.dart';
// import 'salah_info.dart';
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