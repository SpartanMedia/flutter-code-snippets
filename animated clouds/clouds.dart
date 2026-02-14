import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedClouds extends StatefulWidget {
  const AnimatedClouds({super.key});

  @override
  State<AnimatedClouds> createState() => _AnimatedCloudsState();
}

class _AnimatedCloudsState extends State<AnimatedClouds>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final Random _random = Random();
  Offset _currentOffset = Offset.zero;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // slow & smooth
    )..repeat(reverse: true);

    _generateNewOffset();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generateNewOffset() {
    final newOffset = Offset(
      _random.nextDouble() * 20 - 10, // left/right range
      _random.nextDouble() * 20 - 10, // up/down range
    );

    _animation = Tween<Offset>(
      begin: _currentOffset,
      end: newOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _currentOffset = newOffset;

    _controller
      ..reset()
      ..forward().whenComplete(_generateNewOffset);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Image.asset('assets/images/clouds_bg.png', fit: BoxFit.cover),
        Lottie.asset(
          'assets/lottie/lt-animation.json',
          repeat: true,
          fit: BoxFit.cover,
          reverse: true,
        ),
        Positioned(
          top: 120,
          right: 20,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, child) {
              return Transform.translate(
                offset: -_animation.value,
                child: child,
              );
            },
            child: Image.asset('assets/images/cloud_1.png', width: 100),
          ),
        ),
        Positioned(
          top: 280,
          left: 20,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, child) {
              return Transform.translate(
                offset: _animation.value,
                child: child,
              );
            },
            child: Image.asset('assets/images/cloud_2.png', width: 100),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent),
          body: const SafeArea(
            child: Center(
              child: Text(
                'Floating animation',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
