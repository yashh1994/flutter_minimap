import 'package:flutter/material.dart';
import 'package:flutter_minimap/flutter_minimap.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TheaterExample(),
    ),
  );
}

/// A small theater-inspired example that shows how to use [MiniMapViewer].
class TheaterExample extends StatefulWidget {
  const TheaterExample({super.key});

  @override
  State<TheaterExample> createState() => _TheaterExampleState();
}

class _TheaterExampleState extends State<TheaterExample> {
  late final TransformationController controller;

  @override
  void initState() {
    super.initState();
    controller = TransformationController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theater minimap example'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pan and zoom the stage area. The minimap updates live and lets you jump around.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: MiniMapViewer(
                  controller: controller,
                  width: 170,
                  height: 110,
                  alignment: Alignment.topRight,
                  allowDrag: true,
                  visibilityMode: MiniMapVisibility.onInteraction,
                  child: const SizedBox(
                    width: 1200,
                    height: 900,
                    child: TheaterScene(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TheaterScene extends StatelessWidget {
  const TheaterScene({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0F172A),
            colorScheme.surface.withValues(alpha: 0.95),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 120,
            top: 120,
            child: Container(
              width: 960,
              height: 620,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white24, width: 2),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 60,
                    top: 40,
                    child: Container(
                      width: 840,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFF334155),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 120,
                    top: 220,
                    child: SizedBox(
                      width: 720,
                      height: 320,
                      child: Column(
                        children: List.generate(6, (rowIndex) {
                          final seatCount = rowIndex.isEven ? 10 : 8;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(seatCount, (seatIndex) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: seatIndex % 2 == 0
                                          ? const Color(0xFF64748B)
                                          : const Color(0xFF94A3B8),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 120,
            bottom: 80,
            child: Row(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Container(
                    width: 220,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        index == 0
                            ? 'Front row'
                            : index == 1
                            ? 'Center stage'
                            : 'Balcony',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
