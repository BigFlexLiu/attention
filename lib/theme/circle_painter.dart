import 'dart:math';
import 'package:attention/theme/theme.dart';
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final int numberOfCircles;
  final Random random = Random();
  bool built = false;
  final Color backgroundColor;
  List<Circle> circles = [];
  PainterTheme painterTheme;

  CirclePainter(
      {this.numberOfCircles = 15,
      this.backgroundColor = Colors.white,
      this.painterTheme = PainterTheme.circle});

  get painterFunction {
    switch (painterTheme) {
      case PainterTheme.circle:
        return drawCircle;
      case PainterTheme.ripple:
        return drawRipple;
      case PainterTheme.bubble:
        return drawBubble;
      default:
        return drawCircle;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (painterTheme == PainterTheme.none) return;
    // Prevent the circles from changing on every repaint
    if (!built) {
      _generateCircles(size);
      built = true;
    }
    for (Circle circle in circles) {
      painterFunction(canvas, circle);
    }
  }

  void drawCircle(Canvas canvas, Circle circle) {
    canvas.drawCircle(
        circle.position, circle.radius, Paint()..color = circle.color);
  }

  void drawBubble(Canvas canvas, Circle circle) {
    drawCircle(canvas, circle);
    final cover = Circle.copyWith(circle,
        radius: circle.radius * 0.97, color: backgroundColor);
    drawCircle(canvas, cover);
  }

  void drawRipple(Canvas canvas, Circle circle) {
    Circle newCircle = circle;
    drawBubble(canvas, circle);
    for (int i = 0; i < 10; i++) {
      newCircle = Circle.copyWith(newCircle, radius: newCircle.radius * 0.7);
      drawBubble(canvas, newCircle);
    }
  }

  void _generateCircles(Size size) {
    int attempts;
    for (int i = 0; i < numberOfCircles; i++) {
      bool positionFound = false;
      attempts = 0;
      while (!positionFound && attempts < 100) {
        // Limit to 100 attempts to avoid infinite loops
        final color = Color.fromRGBO(
            random.nextInt(256), random.nextInt(256), random.nextInt(256), 0.3);

        // Random position within the canvas
        final position = Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        );

        // Random radius between 10 and 30
        final radius =
            (0.5 + random.nextDouble()) * min(size.width, size.height) / 8;

        // Check if the new circle overlaps with any existing circle
        bool overlaps = false;
        for (Circle circle in circles) {
          double distance = (circle.position - position).distance;
          if (distance < circle.radius + radius) {
            // Check if circles overlap
            overlaps = true;
            break;
          }
        }

        if (!overlaps) {
          circles.add(Circle(position, radius, color));
          positionFound = true;
        }

        attempts++;
      }
    }
    built = true;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Circle {
  final Offset position;
  final double radius;
  final Color color;

  Circle(this.position, this.radius, this.color);

  Circle.copyWith(Circle circle,
      {Offset? position, double? radius, Color? color})
      : position = position ?? circle.position,
        radius = radius ?? circle.radius,
        color = color ?? circle.color;

  @override
  String toString() {
    return 'Circle(position: $position, radius: $radius, color: $color)';
  }
}
