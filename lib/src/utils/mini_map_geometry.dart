import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Geometry used to map between the InteractiveViewer scene and its minimap.
@immutable
class MiniMapGeometry {
  const MiniMapGeometry._({
    required this.contentSize,
    required this.mapSize,
    required this.contentRect,
    required this.scale,
  });

  /// Creates the mapping for a [contentSize] previewed in [mapSize].
  factory MiniMapGeometry.create({
    required Size contentSize,
    required Size mapSize,
  }) {
    if (contentSize.isEmpty || mapSize.isEmpty) {
      return MiniMapGeometry._(
        contentSize: contentSize,
        mapSize: mapSize,
        contentRect: Rect.zero,
        scale: 0,
      );
    }

    final scale = math
        .min(
          mapSize.width / contentSize.width,
          mapSize.height / contentSize.height,
        )
        .toDouble();
    final previewSize = contentSize * scale;
    return MiniMapGeometry._(
      contentSize: contentSize,
      mapSize: mapSize,
      contentRect: Offset(
            (mapSize.width - previewSize.width) / 2,
            (mapSize.height - previewSize.height) / 2,
          ) &
          previewSize,
      scale: scale,
    );
  }

  final Size contentSize;
  final Size mapSize;
  final Rect contentRect;
  final double scale;

  bool get isUsable => scale > 0;

  /// Converts a scene point to a minimap point.
  Offset toMap(Offset scenePoint) => contentRect.topLeft + scenePoint * scale;

  /// Converts a minimap point to a scene point.
  Offset toScene(Offset mapPoint) => (mapPoint - contentRect.topLeft) / scale;

  /// Converts a rect in scene coordinates to one in minimap coordinates.
  Rect toMapRect(Rect sceneRect) => Rect.fromPoints(
    toMap(sceneRect.topLeft),
    toMap(sceneRect.bottomRight),
  );
}
