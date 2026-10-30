import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoController;
  Timer? _fallbackTimer;
  bool _isInitialized = false;
  bool _hasNavigated = false;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  void _initVideoPlayer() async {
    _videoController = VideoPlayerController.asset('assets/splash1.mp4');

    try {
      await _videoController.initialize();
      if (mounted) {
        _videoController.setVolume(0.0); // Mute audio
        setState(() {
          _isInitialized = true;
        });
        _videoController.play();
        _videoController.setLooping(false);

        _videoController.addListener(() {
          if (_videoController.value.isInitialized) {
            final duration = _videoController.value.duration;
            final position = _videoController.value.position;

            // Trigger smooth fade out 600ms before video ends
            if (duration > const Duration(milliseconds: 600) &&
                position >= duration - const Duration(milliseconds: 600)) {
              if (_opacity != 0.0) {
                setState(() {
                  _opacity = 0.0;
                });
              }
            }

            if (position >= duration) {
              _navigateToLogin();
            }
          }
        });
      }
    } catch (e) {
      _fallbackTimer = Timer(const Duration(milliseconds: 2500), _navigateToLogin);
    }
  }

  void _navigateToLogin() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionsBuilder: (_, anim, __, child) {
          return FadeTransition(opacity: anim, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  void dispose() {
    _fallbackTimer?.cancel();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AbsorbPointer(
        absorbing: true, // Ignore all tap/touch events during splash
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: _isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width > 0
                          ? _videoController.value.size.width
                          : 360,
                      height: _videoController.value.size.height > 0
                          ? _videoController.value.size.height
                          : 800,
                      child: VideoPlayer(_videoController),
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/svg/logo.jpeg',
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0552A2)),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
