# flutter_minimap

A small, focused minimap for Flutter's `InteractiveViewer`. It previews one
finite-size canvas, tracks pan and zoom through a `TransformationController`,
and can navigate the canvas by dragging the viewport on the minimap.

## Features

- Live viewport tracking while panning and zooming
- Optional viewport dragging
- `always`, `onInteraction`, and `hidden` visibility modes
- Fixed, intentional API surface for v0.1

## Usage

```dart
final controller = TransformationController();

MiniMapViewer(
  controller: controller,
  width: 180,
  height: 120,
  alignment: Alignment.bottomRight,
  allowDrag: true,
  visibilityMode: MiniMapVisibility.always,
  child: const SizedBox(
    width: 2400,
    height: 1400,
    child: MyCanvas(),
  ),
)
```

`MiniMapViewer` owns the `InteractiveViewer` and uses the supplied controller.
The child must resolve to a finite size; wrapping a canvas in `SizedBox` is the
most predictable option. The child configuration is also rendered as the
non-interactive minimap preview, so avoid child widgets that depend on a
`GlobalKey` or have side effects when built twice.

## Example

Run the example:

```sh
cd example && flutter run
```
# flutter_mini
