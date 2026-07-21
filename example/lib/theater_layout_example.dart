import 'package:flutter/material.dart';
import 'package:flutter_minimap/flutter_minimap.dart';

void main() => runApp(const TheaterLayoutExampleApp());

class TheaterLayoutExampleApp extends StatelessWidget {
  const TheaterLayoutExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theater floor plan | Flutter MiniMap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F2937),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const TheaterLayoutDemo(),
    );
  }
}

class TheaterLayoutDemo extends StatefulWidget {
  const TheaterLayoutDemo({super.key});

  @override
  State<TheaterLayoutDemo> createState() => _TheaterLayoutDemoState();
}

class _TheaterLayoutDemoState extends State<TheaterLayoutDemo> {
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
        title: const Text('Theater minimap example'),
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
          Switch(
            value: _allowDrag,
            onChanged: (value) => setState(() => _allowDrag = value),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: Text('Drag minimap')),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(children: const [
                
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
                    width: 240,
                    height: 160,
                    alignment: Alignment.bottomRight,
                    allowDrag: _allowDrag,
                    visibilityMode: _visibility,
                    child: const TheaterFloorPlan(),
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

class TheaterFloorPlan extends StatelessWidget {
  const TheaterFloorPlan({super.key});

  static const double _seatSize = 30;
  static const double _seatGap = 8;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 3400,
      height: 2600,
      child: ColoredBox(
        color: const Color(0xFFF4F6F8),
        child: Padding(
          padding: const EdgeInsets.all(64),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x120F172A),
                  blurRadius: 18,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(80, 56, 80, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Orion Theater — Main House',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 14),
                            Text(
                              'A large auditorium layout with stage, VIP seating, regular sections, aisles, exits, and technical rooms.',
                              style: TextStyle(fontSize: 18, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          'Floor plan scale: 34 x 25 meters',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 42),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(28),
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 100,
                                right: 100,
                                top: 48,
                                bottom: 48,
                                child: Column(
                                  children: [
                                    _buildStage(),
                                    const SizedBox(height: 42),
                                    _buildVipSection(),
                                    const SizedBox(height: 42),
                                    Expanded(child: _buildMainSeating()),
                                    const SizedBox(height: 42),
                                    _buildBackRooms(),
                                  ],
                                ),
                              ),
                              const Positioned(
                                left: 24,
                                top: 220,
                                child: _SideExit(label: 'Exit'),
                              ),
                              const Positioned(
                                right: 24,
                                top: 220,
                                child: _SideExit(label: 'Exit'),
                              ),
                              const Positioned(
                                left: 24,
                                bottom: 360,
                                child: _SideExit(label: 'Exit'),
                              ),
                              const Positioned(
                                right: 24,
                                bottom: 360,
                                child: _SideExit(label: 'Exit'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStage() {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFEBEEF7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFCBD5E1), width: 2),
        ),
        child: SizedBox(
          width: 2600,
          height: 260,
          child: Center(
            child: Text(
              'STAGE',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVipSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SectionBlock(
          title: 'VIP Left',
          rows: 4,
          columns: 12,
          primaryColor: const Color(0xFFDDEBF7),
          seatColor: const Color(0xFF8B96B0),
          accessibleEdge: true,
        ),
        _SectionBlock(
          title: 'VIP Center',
          rows: 4,
          columns: 18,
          primaryColor: const Color(0xFFFCE7E7),
          seatColor: const Color(0xFF7C3AED),
          accessibleEdge: true,
        ),
        _SectionBlock(
          title: 'VIP Right',
          rows: 4,
          columns: 12,
          primaryColor: const Color(0xFFDDEBF7),
          seatColor: const Color(0xFF8B96B0),
          accessibleEdge: true,
        ),
      ],
    );
  }

  Widget _buildMainSeating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            children: [
              _SectionBlock(
                title: 'Left Orchestra',
                rows: 16,
                columns: 12,
                primaryColor: const Color(0xFFEFF6FF),
                seatColor: const Color(0xFF64748B),
                accessibleEdge: true,
              ),
              const SizedBox(height: 28),
              _SectionBlock(
                title: 'Left Mezzanine',
                rows: 8,
                columns: 10,
                primaryColor: const Color(0xFFECEBF7),
                seatColor: const Color(0xFF475569),
                accessibleEdge: true,
              ),
            ],
          ),
        ),
        const SizedBox(width: 120),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _SectionBlock(
                title: 'Center Orchestra',
                rows: 16,
                columns: 20,
                primaryColor: const Color(0xFFEFF7ED),
                seatColor: const Color(0xFF334155),
                accessibleEdge: true,
              ),
              const SizedBox(height: 28),
              _SectionBlock(
                title: 'Center Balcony',
                rows: 8,
                columns: 16,
                primaryColor: const Color(0xFFF8FAFC),
                seatColor: const Color(0xFF475569),
                accessibleEdge: true,
              ),
            ],
          ),
        ),
        const SizedBox(width: 120),
        Expanded(
          child: Column(
            children: [
              _SectionBlock(
                title: 'Right Orchestra',
                rows: 16,
                columns: 12,
                primaryColor: const Color(0xFFEFF6FF),
                seatColor: const Color(0xFF64748B),
                accessibleEdge: true,
              ),
              const SizedBox(height: 28),
              _SectionBlock(
                title: 'Right Mezzanine',
                rows: 8,
                columns: 10,
                primaryColor: const Color(0xFFECEBF7),
                seatColor: const Color(0xFF475569),
                accessibleEdge: true,
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildBackRooms() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _FacilityBlock(
          title: 'Projection Booth',
          subtitle: 'Technical support',
          width: 520,
          color: Color(0xFFEEF2FF),
        ),
        SizedBox(width: 48),
        _FacilityBlock(
          title: 'Control Room',
          subtitle: 'Lighting & sound',
          width: 520,
          color: Color(0xFFF4EBFF),
        ),
      ],
    );
  }
}

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({
    required this.title,
    required this.rows,
    required this.columns,
    required this.primaryColor,
    required this.seatColor,
    this.accessibleEdge = false,
  });

  final String title;
  final int rows;
  final int columns;
  final Color primaryColor;
  final Color seatColor;
  final bool accessibleEdge;

  @override
  Widget build(BuildContext context) {
    final seatSize = TheaterFloorPlan._seatSize;
    final seatGap = TheaterFloorPlan._seatGap;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: primaryColor.withValues(alpha: 0.8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: columns * seatSize + (columns - 1) * seatGap,
              child: Column(
                children: List.generate(rows, (rowIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(columns, (colIndex) {
                        final isAccessible =
                            accessibleEdge &&
                            (colIndex == 0 ||
                                colIndex == 1 ||
                                colIndex == columns - 1 ||
                                colIndex == columns - 2);
                        return Padding(
                          padding: EdgeInsets.only(
                            right: colIndex == columns - 1 ? 0 : seatGap,
                          ),
                          child: Container(
                            width: seatSize,
                            height: seatSize,
                            decoration: BoxDecoration(
                              color: isAccessible
                                  ? const Color(0xFF7C3AED)
                                  : seatColor,
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
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C3AED),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Accessibility seating',
                  style: TextStyle(fontSize: 13, color: Color(0xFF334155)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FacilityBlock extends StatelessWidget {
  const _FacilityBlock({
    required this.title,
    required this.subtitle,
    required this.width,
    required this.color,
  });

  final String title;
  final String subtitle;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 22),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 8,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

class _SideExit extends StatelessWidget {
  const _SideExit({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF59E0B), width: 1.5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xFF92400E),
        ),
      ),
    );
  }
}
