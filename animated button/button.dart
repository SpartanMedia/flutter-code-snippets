import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedButtonBorder extends StatefulWidget {
  const AnimatedButtonBorder({super.key});

  @override
  State<AnimatedButtonBorder> createState() => _AnimatedButtonBorderState();
}

class _AnimatedButtonBorderState extends State<AnimatedButtonBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Button Animated Border',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 70,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {},
                              borderRadius: BorderRadius.circular(
                                0,
                              ),
                              child: Center(
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Button',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ClipPath(
                            clipper: _CenterCutPath(
                              radius: 18,
                              thickness: 3,
                            ),
                            child: AnimatedBuilder(
                              animation: _controller,
                              builder: (context, _) {
                                final angle = _controller.value * 2 * math.pi;

                                return Stack(
                                  children: [
                                    Container(
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.deepOrange
                                                .withValues(alpha: 0.9),
                                            offset: const Offset(0, 0),
                                            blurRadius: 5,
                                            // spreadRadius: 0.1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: constraints.maxWidth * 0.95,
                                        height: constraints.maxHeight * 0.95,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.amber.withValues(
                                                alpha: 0.9,
                                              ),
                                              offset: const Offset(
                                                0,
                                                0,
                                              ),
                                              blurRadius: 5,
                                              // spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: const [
                                            Colors.deepOrange,
                                            Colors.amber,
                                            // AppColors.primary,
                                          ],
                                          transform: GradientRotation(
                                            angle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
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

class _CenterCutPath extends CustomClipper<Path> {
  final double radius;
  final double thickness;
  _CenterCutPath({this.radius = 0, this.thickness = 1});

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(
      -size.width,
      -size.width,
      size.width * 2,
      size.height * 2,
    );
    final double width = size.width - thickness * 2;
    final double height = size.height - thickness * 2;

    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(thickness, thickness, width, height),
          Radius.circular(radius - thickness),
        ),
      )
      ..addRect(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant _CenterCutPath oldClipper) {
    return oldClipper.radius != radius || oldClipper.thickness != thickness;
  }
}
