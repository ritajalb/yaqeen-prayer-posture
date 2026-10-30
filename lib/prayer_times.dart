import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrayerTimes {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  PrayerTimes({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    return PrayerTimes(
      fajr: json['data']['timings']['Fajr'],
      dhuhr: json['data']['timings']['Dhuhr'],
      asr: json['data']['timings']['Asr'],
      maghrib: json['data']['timings']['Maghrib'],
      isha: json['data']['timings']['Isha'],
    );
  }
}

Future<PrayerTimes> fetchPrayerTimes(double latitude, double longitude, String date) async {
  final String baseUrl = 'http://api.aladhan.com/v1/timings';
  final url = Uri.parse('$baseUrl?latitude=$latitude&longitude=$longitude&date=$date');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return PrayerTimes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('❌ فشل تحميل أوقات الصلاة');
  }
}

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({Key? key}) : super(key: key);

  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  late Future<PrayerTimes> futurePrayerTimes;

  @override
  void initState() {
    super.initState();
    futurePrayerTimes = fetchPrayerTimes(21.3891, 39.8579, '2025-02-09'); // مكة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🕌 أوقات الصلاة')),
      body: Center(
        child: FutureBuilder<PrayerTimes>(
          future: futurePrayerTimes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('⚠️ خطأ: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('❌ لا توجد بيانات متاحة');
            } else {
              final prayerTimes = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrayerTimeRow(title: 'الفجر', time: prayerTimes.fajr),
                  PrayerTimeRow(title: 'الظهر', time: prayerTimes.dhuhr),
                  PrayerTimeRow(title: 'العصر', time: prayerTimes.asr),
                  PrayerTimeRow(title: 'المغرب', time: prayerTimes.maghrib),
                  PrayerTimeRow(title: 'العشاء', time: prayerTimes.isha),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class PrayerTimeRow extends StatelessWidget {
  final String title;
  final String time;

  const PrayerTimeRow({required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(time, style: TextStyle(fontSize: 20, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
