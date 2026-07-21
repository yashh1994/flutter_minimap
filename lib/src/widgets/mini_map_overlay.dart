import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/mini_map_visibility.dart';
import '../painters/mini_map_viewport_painter.dart';
import '../utils/mini_map_geometry.dart';

class MiniMapOverlay extends StatelessWidget {
  const MiniMapOverlay({
    required this.controller,
    required this.child,
    required this.contentSize,
    required this.viewportSize,
    required this.width,
    required this.height,
    required this.alignment,
    required this.allowDrag,
    required this.visibilityMode,
    required this.isInteracting,
    super.key,
  });

  static const _borderColor = Color(0x33000000);
  static const _viewportColor = Color(0x4D2196F3);
  static const _viewportBorderColor = Color(0xFF1565C0);
  static const _borderWidth = 1.0;
  static const _viewportPainterKey = ValueKey<String>(
    'flutter_minimap.viewport',
  );

  final TransformationController controller;
  final Widget child;
  final ValueListenable<Size?> contentSize;
  final ValueListenable<Size?> viewportSize;
  final double width;
  final double height;
  final AlignmentGeometry alignment;
  final bool allowDrag;
  final MiniMapVisibility visibilityMode;
  final ValueListenable<bool> isInteracting;

  @override
  Widget build(BuildContext context) {
    if (visibilityMode == MiniMapVisibility.hidden) {
      return const SizedBox.shrink();
    }

    return ValueListenableBuilder<bool>(
      valueListenable: isInteracting,
      builder: (context, interacting, _) {
        if (visibilityMode == MiniMapVisibility.onInteraction && !interacting) {
          return const SizedBox.shrink();
        }
        return Align(
          alignment: alignment,
          child: SizedBox(
            width: width,
            height: height,
            child: ValueListenableBuilder<Size?>(
              valueListenable: contentSize,
              builder: (context, measuredContentSize, _) {
                return ValueListenableBuilder<Size?>(
                  valueListenable: viewportSize,
                  builder: (context, measuredViewportSize, _) {
                    if (measuredContentSize == null ||
                        measuredViewportSize == null ||
                        measuredContentSize.isEmpty ||
                        measuredViewportSize.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return _MiniMapSurface(
                      controller: controller,
                      contentSize: measuredContentSize,
                      viewportSize: measuredViewportSize,
                      allowDrag: allowDrag,
                      child: child,
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _MiniMapSurface extends StatelessWidget {
  const _MiniMapSurface({
    required this.controller,
    required this.child,
    required this.contentSize,
    required this.viewportSize,
    required this.allowDrag,
  });

  final TransformationController controller;
  final Widget child;
  final Size contentSize;
  final Size viewportSize;
  final bool allowDrag;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xFFFDFDFD),
        border: Border.fromBorderSide(
          BorderSide(color: MiniMapOverlay._borderColor),
        ),
      ),
      child: ClipRect(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mapSize = constraints.biggest;
            final geometry = MiniMapGeometry.create(
              contentSize: contentSize,
              mapSize: mapSize,
            );
            final surface = Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fromRect(
                  rect: geometry.contentRect,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SizedBox(
                      width: contentSize.width,
                      height: contentSize.height,
                      child: ExcludeSemantics(
                        child: IgnorePointer(
                          child: RepaintBoundary(child: child),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomPaint(
                  key: MiniMapOverlay._viewportPainterKey,
                  painter: MiniMapViewportPainter(
                    controller: controller,
                    contentSize: contentSize,
                    viewportSize: viewportSize,
                    viewportColor: MiniMapOverlay._viewportColor,
                    viewportBorderColor: MiniMapOverlay._viewportBorderColor,
                    viewportBorderWidth: MiniMapOverlay._borderWidth,
                  ),
                ),
              ],
            );

            if (!allowDrag) {
              return IgnorePointer(child: surface);
            }
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (details) =>
                  _moveViewport(details.localPosition, geometry),
              onPanUpdate: (details) =>
                  _moveViewport(details.localPosition, geometry),
              child: surface,
            );
          },
        ),
      ),
    );
  }

  void _moveViewport(Offset mapPosition, MiniMapGeometry geometry) {
    if (!geometry.isUsable) {
      return;
    }
    final unclampedScenePoint = geometry.toScene(mapPosition);
    final scenePoint = Offset(
      unclampedScenePoint.dx.clamp(0.0, contentSize.width).toDouble(),
      unclampedScenePoint.dy.clamp(0.0, contentSize.height).toDouble(),
    );
    final scale = controller.value.getMaxScaleOnAxis();
    final sceneViewportSize = viewportSize / scale;
    final targetTopLeft = scenePoint - sceneViewportSize.center(Offset.zero);
    final maxX = (contentSize.width - sceneViewportSize.width)
        .clamp(0.0, double.infinity)
        .toDouble();
    final maxY = (contentSize.height - sceneViewportSize.height)
        .clamp(0.0, double.infinity)
        .toDouble();
    final clampedTopLeft = Offset(
      targetTopLeft.dx.clamp(0.0, maxX).toDouble(),
      targetTopLeft.dy.clamp(0.0, maxY).toDouble(),
    );

    controller.value = Matrix4.copy(controller.value)
      ..setTranslationRaw(
        -clampedTopLeft.dx * scale,
        -clampedTopLeft.dy * scale,
        0,
      );
  }
}
