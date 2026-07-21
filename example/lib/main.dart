import 'package:flutter/material.dart';
import 'package:flutter_minimap/flutter_minimap.dart';

void main() => runApp(const MiniMapExampleApp());

class MiniMapExampleApp extends StatelessWidget {
  const MiniMapExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MiniMap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
        useMaterial3: true,
      ),
      home: const CanvasDemo(),
    );
  }
}

class CanvasDemo extends StatefulWidget {
  const CanvasDemo({super.key});

  @override
  State<CanvasDemo> createState() => _CanvasDemoState();
}

class _CanvasDemoState extends State<CanvasDemo> {
  final _controller = TransformationController();
  MiniMapVisibility _visibility = MiniMapVisibility.always;
  bool _allowDrag = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project canvas'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<MiniMapVisibility>(
                value: _visibility,
                onChanged: (value) => setState(() => _visibility = value!),
                items: MiniMapVisibility.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              children: [
                const Icon(Icons.open_with_rounded),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Pan and zoom the canvas, or drag the minimap viewport.',
                  ),
                ),
                Switch(
                  value: _allowDrag,
                  onChanged: (value) => setState(() => _allowDrag = value),
                ),
                const Text('Drag minimap'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: MiniMapViewer(
                    controller: _controller,
                    width: 220,
                    height: 140,
                    alignment: Alignment.bottomRight,
                    allowDrag: _allowDrag,
                    visibilityMode: _visibility,
                    child: const ProjectCanvas(),
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

class ProjectCanvas extends StatelessWidget {
  const ProjectCanvas({super.key});

  static const _stages = [
    ('Research', Color(0xFFE0E7FF)),
    ('Design', Color(0xFFFEF3C7)),
    ('Build', Color(0xFFDCFCE7)),
    ('Launch', Color(0xFFFCE7F3)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2400,
      height: 1400,
      child: ColoredBox(
        color: const Color(0xFFF8FAFC),
        child: Padding(
          padding: const EdgeInsets.all(80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Q3 product roadmap',
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 56),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _stages
                      .map(
                        (stage) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 28),
                            child: _StageColumn(
                              title: stage.$1,
                              color: stage.$2,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StageColumn extends StatelessWidget {
  const _StageColumn({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              4,
              (index) => Container(
                width: double.infinity,
                height: 140,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(color: Color(0x120F172A), blurRadius: 12),
                  ],
                ),
                child: Text(
                  'Task ${index + 1}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
