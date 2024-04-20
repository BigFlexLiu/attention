import 'dart:math';
import 'package:flutter/material.dart';

class FallingCircleAnimator extends StatefulWidget {
  const FallingCircleAnimator({super.key, required this.child});
  final Widget child;

  @override
  _FallingCircleAnimatorState createState() => _FallingCircleAnimatorState();
}

class _FallingCircleAnimatorState extends State<FallingCircleAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Circle> circles = List.generate(20, (index) => Circle.random());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _controller.addListener(() {
      setState(() {
        for (var circle in circles) {
          circle.update();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(circles),
      child: widget.child,
    );
  }
}

class CirclePainter extends CustomPainter {
  final List<Circle> circles;
  CirclePainter(this.circles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (var circle in circles) {
      paint.color = circle.color;
      canvas.drawCircle(circle.position, circle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Circle {
  late Offset position;
  late double radius;
  late Color color;
  late double speed;

  Circle(
      {required this.position,
      required this.radius,
      required this.color,
      required this.speed});

  Circle.random() {
    final random = Random();
    position = Offset(random.nextDouble() * 400, random.nextDouble() * 800);
    radius = random.nextDouble() * 40 + 5;
    color = Colors.primaries[random.nextInt(Colors.primaries.length)];
    speed = random.nextDouble() + 0.5; // Speed of movement
  }

  void update() {
    position = Offset(position.dx, position.dy + speed);
    if (position.dy - radius > 800) {
      // Reset to the top
      position = Offset(position.dx, -radius);
    }
  }
}
