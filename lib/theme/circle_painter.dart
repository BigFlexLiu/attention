import 'dart:math';
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final int numberOfTriangles;
  final int numberOfCircles;
  final Random random = Random();
  bool built = false;
  List<Circle> circles = [];
  List<Triangle> triangles = [];

  CirclePainter({this.numberOfCircles = 15, this.numberOfTriangles = 0});

  @override
  void paint(Canvas canvas, Size size) {
    // Prevent the circles from changing on every repaint
    if (!built) {
      _generateCircles(size);
      _generateTriangles(size);
      built = true;
    }
    for (Circle circle in circles) {
      canvas.drawCircle(
          circle.position, circle.radius, Paint()..color = circle.color);
    }
    for (Triangle triangle in triangles) {
      final paint = Paint()..color = triangle.color;
      final path = Path()
        ..moveTo(triangle.vertex1.dx, triangle.vertex1.dy)
        ..lineTo(triangle.vertex2.dx, triangle.vertex2.dy)
        ..lineTo(triangle.vertex3.dx, triangle.vertex3.dy)
        ..close();
      canvas.drawPath(path, paint);
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

  void _generateTriangles(Size size) {
    double screenArea = size.width * size.height;
    double minArea = screenArea / 32;
    double maxArea = screenArea / 16;

    for (int i = 0; i < numberOfTriangles; i++) {
      final color = Color.fromRGBO(
          random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);

      // Randomly choose a triangle model
      bool isEquilateral = random.nextBool();

      // Generate an area within the bounds
      double targetArea = random.nextDouble() * (maxArea - minArea) + minArea;
      double sideLength;

      // Calculate the side length based on the target area and the model
      if (isEquilateral) {
        // Area of equilateral triangle: (sqrt(3)/4) * side^2
        sideLength = sqrt(targetArea / (sqrt(3) / 4));
      } else {
        // Area of right isosceles triangle: (1/2) * side^2
        sideLength = sqrt(targetArea * 2);
      }

      // Random initial position
      Offset position = Offset(random.nextDouble() * (size.width - sideLength),
          random.nextDouble() * (size.height - sideLength));

      // Generate triangle based on the model and calculated side length
      List<Offset> vertices;
      if (isEquilateral) {
        vertices = generateEquilateralTriangle(position, sideLength);
      } else {
        vertices = generateRightIsoscelesTriangle(position, sideLength);
      }

      triangles.add(Triangle(vertices[0], vertices[1], vertices[2], color));
    }
  }

  List<Offset> generateEquilateralTriangle(Offset start, double size) {
    Offset second = Offset(start.dx + size, start.dy);
    double height = size * sqrt(3) / 2;
    Offset third = Offset(start.dx + size / 2, start.dy - height);
    return [start, second, third];
  }

  List<Offset> generateRightIsoscelesTriangle(Offset start, double size) {
    Offset second = Offset(start.dx + size, start.dy);
    Offset third = Offset(start.dx, start.dy + size);
    return [start, second, third];
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
}

class Triangle {
  final Offset vertex1;
  final Offset vertex2;
  final Offset vertex3;
  final Color color;

  Triangle(this.vertex1, this.vertex2, this.vertex3, this.color);
}
