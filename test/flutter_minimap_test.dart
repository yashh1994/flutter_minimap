import 'package:flutter/material.dart';
import 'package:flutter_minimap/flutter_minimap.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('builds an InteractiveViewer and visible minimap', (
    tester,
  ) async {
    final controller = TransformationController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 400,
          height: 300,
          child: MiniMapViewer(
            controller: controller,
            child: const SizedBox(width: 1200, height: 800),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(InteractiveViewer), findsOneWidget);
    expect(
      find.byKey(const ValueKey<String>('flutter_minimap.viewport')),
      findsOneWidget,
    );
  });

  testWidgets('does not build a minimap when hidden', (tester) async {
    final controller = TransformationController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 400,
          height: 300,
          child: MiniMapViewer(
            controller: controller,
            visibilityMode: MiniMapVisibility.hidden,
            child: const SizedBox(width: 1200, height: 800),
          ),
        ),
      ),
    );

    expect(
      find.byKey(const ValueKey<String>('flutter_minimap.viewport')),
      findsNothing,
    );
  });
}
