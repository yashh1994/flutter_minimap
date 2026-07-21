/// Controls when the minimap is displayed.
enum MiniMapVisibility {
  /// Keep the minimap visible.
  always,

  /// Show the minimap only while the user is interacting with the canvas.
  onInteraction,

  /// Do not build or display a minimap.
  hidden,
}
