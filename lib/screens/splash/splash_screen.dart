import 'dart:async';
import 'package:flutter/material.dart';

class IntroSplash extends StatefulWidget {
  const IntroSplash({super.key});

  @override
  State<IntroSplash> createState() => _IntroSplashState();
}

class _IntroSplashState extends State<IntroSplash> {
  int currentPage = 0;
  late Timer timer;

  final List<_IntroPageData> pages = const [
    _IntroPageData(
      image: 'assets/images/main_logo.png', // your golden glowing logo
      title: 'JANTRA',
      subtitle: 'THE MACHINE THAT BELONGS TO TRUTH',
      isFirstPage: true,
    ),
    _IntroPageData(
      image: 'assets/images/main_logo.png',
      title: 'Truth is not told — it is revealed.',
      subtitle: 'Together we uncover what is real.',
      isFirstPage: false,
    ),
    _IntroPageData(
      image: 'assets/images/main_logo.png',
      title: 'Every citizen is a witness to change.',
      subtitle: 'Your voice is your verification.',
      isFirstPage: false,
    ),
    _IntroPageData(
      image: 'assets/images/main_logo.png',
      title: 'Technology serves when it belongs to truth.',
      subtitle: 'Welcome to the machine built by citizens.',
      isFirstPage: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (t) {
      if (currentPage < pages.length - 1) {
        setState(() => currentPage++);
      } else {
        t.cancel();
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final page = pages[currentPage];
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: _IntroPage(
          key: ValueKey(currentPage),
          data: page,
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// One page of the intro sequence
/// ---------------------------------------------------------------------------
class _IntroPage extends StatelessWidget {
  final _IntroPageData data;
  const _IntroPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF9C802), Color(0xFFFFF9E6)], // app theme gradient
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(
            data.image,
            width: 150,  // 🔸 set one uniform size for all pages
            height: 150,
          ),

            const SizedBox(height: 25),
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: data.isFirstPage ? 44 : 26,
                fontWeight:
                    data.isFirstPage ? FontWeight.w700 : FontWeight.bold,
                color: const Color(0xFF6C5C00),
                letterSpacing: data.isFirstPage ? 2 : 1,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                data.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: data.isFirstPage ? 15 : 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8C7000),
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple data holder
class _IntroPageData {
  final String image;
  final String title;
  final String subtitle;
  final bool isFirstPage;
  const _IntroPageData({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.isFirstPage,
  });
}
