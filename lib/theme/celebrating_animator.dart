import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/services.dart';

class CelebratingAnimator extends StatefulWidget {
  const CelebratingAnimator({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  _CelebratingAnimatorState createState() => _CelebratingAnimatorState();
}

class _CelebratingAnimatorState extends State<CelebratingAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  List<ImageAnimation> images = [];
  List<ui.Image> loadedImages = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    loadImages([
      'assets/images/balloon_blue.png',
      'assets/images/balloon_red.png',
      'assets/images/balloon_green.png', // Add more paths as needed
    ]);
  }

  void loadImages(List<String> paths) async {
    for (String path in paths) {
      final data = await rootBundle.load(path);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      loadedImages.add(frame.image);
    }
    setState(() {
      for (int i = 0; i < 7; i++) {
        final randomImage = loadedImages[Random().nextInt(loadedImages.length)];
        images.add(ImageAnimation(
          controller: controller,
          image: randomImage,
          position: Offset(MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height),
          scale: Random().nextDouble() * 0.05 + 0.15,
          speed: Random().nextDouble() * 4 + 4,
          drift: (Random().nextDouble() - 0.5) * 5, // Drift speed modifier
        ));
      }
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return CustomPaint(
                painter: MultipleImagePainter(images, controller.value),
                child: widget.child,
              );
            },
          )
        : const Center(child: CircularProgressIndicator());
  }
}

class ImageAnimation {
  final ui.Image image;
  Offset position;
  double scale;
  final double speed;
  final double drift; // Horizontal drift factor
  final AnimationController controller;

  ImageAnimation({
    required this.controller,
    required this.image,
    required this.position,
    required this.scale,
    required this.speed,
    required this.drift,
  });

  void moveUp() {
    position = Offset(position.dx + drift * sin(controller.value * 2 * pi),
        position.dy - speed);
  }
}

class MultipleImagePainter extends CustomPainter {
  final List<ImageAnimation> images;
  final double animationValue;

  MultipleImagePainter(this.images, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (var img in images) {
      img.moveUp();
      paintImage(
        canvas: canvas,
        image: img.image,
        rect: Rect.fromCenter(
            center: img.position,
            width: img.image.width * img.scale,
            height: img.image.height * img.scale),
        fit: BoxFit.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Could optimize by comparing old and new positions
  }
}
