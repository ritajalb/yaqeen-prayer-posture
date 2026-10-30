
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'salah_info.dart';

class PrayerDetailPage extends StatefulWidget {
  final SalahInfo salahInfo;

  const PrayerDetailPage({Key? key, required this.salahInfo}) : super(key: key);

  @override
  _PrayerDetailPageState createState() => _PrayerDetailPageState();
}

class _PrayerDetailPageState extends State<PrayerDetailPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // استخراج معرف الفيديو من رابط YouTube
    final Uri youtubeUrl = Uri.parse(widget.salahInfo.youtubeUrl);
    final String? videoId =
        youtubeUrl.queryParameters['v'] ?? youtubeUrl.pathSegments.last;

    // تحقق من وجود معرف الفيديو وإنشاء الـ Controller
    if (videoId != null && videoId.isNotEmpty) {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      );
    } else {
      print('Invalid YouTube URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية مع التدرج
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF123A6B), Color(0xFF123A6B).withOpacity(0.80)],
              ),
            ),
            child: Column(
              children: [
                // عرض الفيديو
                Container(
                  height: MediaQuery.of(context).size.height * 0.4, // يشغل 40% من الشاشة
                  width: double.infinity,
                  child: YoutubePlayerScaffold(
                    controller: _controller,
                    aspectRatio: 16 / 9,
                    builder: (context, player) {
                      return player;
                    },
                  ),
                ),
                // المعلومات الإضافية
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About ${widget.salahInfo.title}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.salahInfo.description,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Additional Information:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...widget.salahInfo.additionalInfo.map((info) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              '• $info',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                // زر "Start Learning"
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFADEBFF).withOpacity(0.80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {
                      // Add functionality here
                    },
                    child: const Text(
                      'Start Learning',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // زر الرجوع
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}