import 'package:flutter/material.dart';
import 'package:flutter_minimap/flutter_minimap.dart';

void main() => runApp(const OfficeLayoutExampleApp());

class OfficeLayoutExampleApp extends StatelessWidget {
  const OfficeLayoutExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Office floor plan | Flutter MiniMap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const OfficeLayoutDemo(),
    );
  }
}

class OfficeLayoutDemo extends StatefulWidget {
  const OfficeLayoutDemo({super.key});

  @override
  State<OfficeLayoutDemo> createState() => _OfficeLayoutDemoState();
}

class _OfficeLayoutDemoState extends State<OfficeLayoutDemo> {
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
        actions: [
          Switch(
            value: _allowDrag,
            onChanged: (value) => setState(() => _allowDrag = value),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Center(child: Text('Minimap visibility')),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
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
            child: Row(children: [const Text('Drag minimap')]),
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
                    child: const OfficeFloorPlan(),
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

class OfficeFloorPlan extends StatelessWidget {
  const OfficeFloorPlan({super.key});

  static const _departments = [
    _OfficeRoom('DevOps', 'Platform & reliability', Color(0xFFDDF4F0)),
    _OfficeRoom('Flutter', 'Mobile experiences', Color(0xFFDCEBFF)),
    _OfficeRoom('Node.js', 'API services', Color(0xFFFFEDCC)),
    _OfficeRoom('Python', 'Data tooling', Color(0xFFFFE0E7)),
    _OfficeRoom('AI Lab', 'Models & research', Color(0xFFE9E2FF)),
    _OfficeRoom('Web', 'Frontend platform', Color(0xFFDFF5DD)),
    _OfficeRoom('QA', 'Quality engineering', Color(0xFFFFE9D5)),
    _OfficeRoom('Security', 'Trust & compliance', Color(0xFFDCEFF7)),
    _OfficeRoom('Data', 'Analytics & insights', Color(0xFFF4E0F5)),
    _OfficeRoom('SRE', 'Production operations', Color(0xFFFFE3D6)),
    _OfficeRoom('Product', 'Discovery & strategy', Color(0xFFE8F2CF)),
    _OfficeRoom('Design', 'UX & systems', Color(0xFFFCE0EC)),
    _OfficeRoom('Support', 'Customer success', Color(0xFFE2F0FF)),
    _OfficeRoom('People', 'Talent & culture', Color(0xFFFFECD5)),
    _OfficeRoom('Finance', 'Planning & operations', Color(0xFFE1EFEA)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 3400,
      height: 2500,
      child: ColoredBox(
        color: const Color(0xFFF1F5F4),
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: Column(
            children: [
              const _FloorPlanHeader(),
              const SizedBox(height: 44),
              Expanded(
                child: Row(
                  children: [
                    const _VerticalRoom(
                      title: 'Reception',
                      detail: 'Visitor welcome',
                      color: Color(0xFF163C3B),
                      dark: true,
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Expanded(
                                child: _WideRoom(
                                  title: 'Town Hall',
                                  detail: 'All-hands, demos & events',
                                  color: Color(0xFF256D68),
                                  dark: true,
                                ),
                              ),
                              SizedBox(width: 32),
                              Expanded(
                                child: _WideRoom(
                                  title: 'Cafeteria',
                                  detail: 'Coffee, lunch & conversations',
                                  color: Color(0xFFE8C168),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 5,
                              mainAxisSpacing: 28,
                              crossAxisSpacing: 28,
                              childAspectRatio: 1,
                              physics: const NeverScrollableScrollPhysics(),
                              children: _departments
                                  .map((room) => _DepartmentRoom(room: room))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    const _VerticalRoom(
                      title: 'Focus Pods',
                      detail: 'Quiet work',
                      color: Color(0xFFB8D2C8),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Row(
                children: [
                  Expanded(
                    child: _WideRoom(
                      title: 'Atlas',
                      detail: 'Large meeting room',
                      color: Color(0xFFC8D9F1),
                    ),
                  ),
                  SizedBox(width: 32),
                  Expanded(
                    child: _WideRoom(
                      title: 'Library',
                      detail: 'Reading & learning',
                      color: Color(0xFFE4D5BB),
                    ),
                  ),
                  SizedBox(width: 32),
                  Expanded(
                    child: _WideRoom(
                      title: 'Orion',
                      detail: 'Client meeting room',
                      color: Color(0xFFD9C9E8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloorPlanHeader extends StatelessWidget {
  const _FloorPlanHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.business_rounded, size: 56, color: Color(0xFF0F766E)),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NORTHSTAR / LEVEL 04',
              style: TextStyle(
                fontSize: 36,
                letterSpacing: 3,
                fontWeight: FontWeight.w800,
                color: Color(0xFF17403E),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Engineering and operations floor plan',
              style: TextStyle(fontSize: 24, color: Color(0xFF54716E)),
            ),
          ],
        ),
        Spacer(),
        _FloorKey(),
      ],
    );
  }
}

class _FloorKey extends StatelessWidget {
  const _FloorKey();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD7E3E1), width: 2),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.square_rounded, color: Color(0xFF0F766E), size: 22),
            SizedBox(width: 8),
            Text('Shared space', style: TextStyle(fontSize: 18)),
            SizedBox(width: 18),
            Icon(Icons.square_rounded, color: Color(0xFF8AB1AB), size: 22),
            SizedBox(width: 8),
            Text('Team room', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class _DepartmentRoom extends StatelessWidget {
  const _DepartmentRoom({required this.room});

  final _OfficeRoom room;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: room.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFB8CAC7), width: 3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              _iconFor(room.title),
              color: const Color(0xFF1F5550),
              size: 42,
            ),
            const Spacer(),
            Text(
              room.title,
              style: const TextStyle(
                fontSize: 31,
                fontWeight: FontWeight.w800,
                color: Color(0xFF173D3A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              room.detail,
              style: const TextStyle(fontSize: 18, color: Color(0xFF416460)),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(String department) {
    return switch (department) {
      'DevOps' || 'SRE' => Icons.settings_suggest_rounded,
      'Flutter' => Icons.phone_iphone_rounded,
      'Node.js' => Icons.hub_rounded,
      'Python' || 'Data' => Icons.data_object_rounded,
      'AI Lab' => Icons.psychology_alt_rounded,
      'Web' => Icons.language_rounded,
      'QA' => Icons.fact_check_rounded,
      'Security' => Icons.shield_outlined,
      'Product' => Icons.route_rounded,
      'Design' => Icons.palette_outlined,
      'Support' => Icons.headset_mic_outlined,
      'People' => Icons.groups_rounded,
      'Finance' => Icons.account_balance_wallet_outlined,
      _ => Icons.apartment_rounded,
    };
  }
}

class _WideRoom extends StatelessWidget {
  const _WideRoom({
    required this.title,
    required this.detail,
    required this.color,
    this.dark = false,
  });

  final String title;
  final String detail;
  final Color color;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final foreground = dark ? Colors.white : const Color(0xFF173D3A);
    return Container(
      height: 180,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: dark ? const Color(0xFF163C3B) : const Color(0xFFB8CAC7),
          width: 3,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.meeting_room_outlined, color: foreground, size: 42),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: foreground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 18,
                  color: foreground.withValues(alpha: 0.76),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VerticalRoom extends StatelessWidget {
  const _VerticalRoom({
    required this.title,
    required this.detail,
    required this.color,
    this.dark = false,
  });

  final String title;
  final String detail;
  final Color color;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final foreground = dark ? Colors.white : const Color(0xFF173D3A);
    return SizedBox(
      width: 210,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: dark ? const Color(0xFF163C3B) : const Color(0xFF91B3AC),
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.door_front_door_outlined, color: foreground, size: 42),
              const Spacer(),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: foreground,
                  ),
                ),
              ),
              const SizedBox(height: 64),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 17,
                  color: foreground.withValues(alpha: 0.76),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfficeRoom {
  const _OfficeRoom(this.title, this.detail, this.color);

  final String title;
  final String detail;
  final Color color;
}
