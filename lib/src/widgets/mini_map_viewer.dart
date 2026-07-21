import 'package:flutter/material.dart';

import '../models/mini_map_visibility.dart';
import 'mini_map_overlay.dart';
import 'size_reporter.dart';

/// Displays an [InteractiveViewer] with a synchronized minimap overlay.
///
/// The [child] must have a finite laid-out size, such as a [SizedBox] or a
/// widget that sizes itself from its contents. The same child configuration is
/// used for the non-interactive minimap preview.
class MiniMapViewer extends StatefulWidget {
  /// Creates an InteractiveViewer with a minimap.
  const MiniMapViewer({
    required this.controller,
    required this.child,
    this.width = 180,
    this.height = 120,
    this.alignment = Alignment.bottomRight,
    this.allowDrag = true,
    this.visibilityMode = MiniMapVisibility.always,
    super.key,
  }) : assert(width > 0),
       assert(height > 0);

  /// The controller shared with the underlying [InteractiveViewer].
  final TransformationController controller;

  /// The interactive canvas and minimap preview content.
  final Widget child;

  /// The minimap width in logical pixels.
  final double width;

  /// The minimap height in logical pixels.
  final double height;

  /// Where the minimap is placed over the InteractiveViewer.
  final AlignmentGeometry alignment;

  /// Whether dragging or tapping the minimap moves the viewport.
  final bool allowDrag;

  /// When the minimap should be displayed.
  final MiniMapVisibility visibilityMode;

  @override
  State<MiniMapViewer> createState() => _MiniMapViewerState();
}

class _MiniMapViewerState extends State<MiniMapViewer> {
  final _contentSize = ValueNotifier<Size?>(null);
  final _viewportSize = ValueNotifier<Size?>(null);
  final _isInteracting = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _contentSize.dispose();
    _viewportSize.dispose();
    _isInteracting.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        if (size.isFinite && _viewportSize.value != size) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _viewportSize.value != size) {
              _viewportSize.value = size;
            }
          });
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            InteractiveViewer(
              transformationController: widget.controller,
              constrained: false,
              onInteractionStart: (_) => _isInteracting.value = true,
              onInteractionEnd: (_) => _isInteracting.value = false,
              child: SizeReporter(
                onSizeChanged: (size) {
                  if (_contentSize.value != size) {
                    _contentSize.value = size;
                  }
                },
                child: widget.child,
              ),
            ),
            MiniMapOverlay(
              controller: widget.controller,
              contentSize: _contentSize,
              viewportSize: _viewportSize,
              width: widget.width,
              height: widget.height,
              alignment: widget.alignment,
              allowDrag: widget.allowDrag,
              visibilityMode: widget.visibilityMode,
              isInteracting: _isInteracting,
              child: widget.child,
            ),
          ],
        );
      },
    );
  }
}
