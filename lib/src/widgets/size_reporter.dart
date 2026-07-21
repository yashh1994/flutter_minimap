import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Reports its child's laid-out size without changing its layout behavior.
class SizeReporter extends SingleChildRenderObjectWidget {
  const SizeReporter({
    required this.onSizeChanged,
    required super.child,
    super.key,
  });

  final ValueChanged<Size> onSizeChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSizeReporter(onSizeChanged);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderObject renderObject,
  ) {
    (renderObject as _RenderSizeReporter).onSizeChanged = onSizeChanged;
  }
}

class _RenderSizeReporter extends RenderProxyBox {
  _RenderSizeReporter(this._onSizeChanged);

  ValueChanged<Size> _onSizeChanged;
  Size? _lastReportedSize;

  set onSizeChanged(ValueChanged<Size> callback) => _onSizeChanged = callback;

  @override
  void performLayout() {
    super.performLayout();
    if (size == _lastReportedSize) {
      return;
    }
    final reportedSize = size;
    _lastReportedSize = reportedSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (attached) {
        _onSizeChanged(reportedSize);
      }
    });
  }
}
