import 'package:flutter/material.dart';

import '../utils/mini_map_geometry.dart';

/// Paints the InteractiveViewer's visible scene area over a minimap preview.
class MiniMapViewportPainter extends CustomPainter {
  MiniMapViewportPainter({
    required this.controller,
    required this.contentSize,
    required this.viewportSize,
    required this.viewportColor,
    required this.viewportBorderColor,
    required this.viewportBorderWidth,
  }) : super(repaint: controller);

  final TransformationController controller;
  final Size contentSize;
  final Size viewportSize;
  final Color viewportColor;
  final Color viewportBorderColor;
  final double viewportBorderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final geometry = MiniMapGeometry.create(
      contentSize: contentSize,
      mapSize: size,
    );
    if (!geometry.isUsable || viewportSize.isEmpty) {
      return;
    }

    final sceneViewport = Rect.fromPoints(
      controller.toScene(Offset.zero),
      controller.toScene(viewportSize.bottomRight(Offset.zero)),
    );
    final visibleScene = sceneViewport.intersect(Offset.zero & contentSize);
    if (visibleScene.isEmpty) {
      return;
    }

    final viewportRect = geometry.toMapRect(visibleScene);
    canvas.drawRect(viewportRect, Paint()..color = viewportColor);
    canvas.drawRect(
      viewportRect.deflate(viewportBorderWidth / 2),
      Paint()
        ..color = viewportBorderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = viewportBorderWidth,
    );
  }

  @override
  bool shouldRepaint(covariant MiniMapViewportPainter oldDelegate) {
    return oldDelegate.controller != controller ||
        oldDelegate.contentSize != contentSize ||
        oldDelegate.viewportSize != viewportSize ||
        oldDelegate.viewportColor != viewportColor ||
        oldDelegate.viewportBorderColor != viewportBorderColor ||
        oldDelegate.viewportBorderWidth != viewportBorderWidth;
  }
}
