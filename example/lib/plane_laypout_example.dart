import 'package:flutter/material.dart';
import 'package:flutter_minimap/flutter_minimap.dart';

void main() => runApp(const AirplaneLayoutExampleApp());

class AirplaneLayoutExampleApp extends StatelessWidget {
  const AirplaneLayoutExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airplane cabin | Flutter MiniMap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B6477),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const AirplaneLayoutDemo(),
    );
  }
}

class AirplaneLayoutDemo extends StatefulWidget {
  const AirplaneLayoutDemo({super.key});

  @override
  State<AirplaneLayoutDemo> createState() => _AirplaneLayoutDemoState();
}

class _AirplaneLayoutDemoState extends State<AirplaneLayoutDemo> {
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
        title: const Text('Asteria Airways A-900'),
        actions: [
          // Switch(
          //   value: _allowDrag,
          //   onChanged: (value) => setState(() => _allowDrag = value),
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<MiniMapVisibility>(
                value: _visibility,
                onChanged: (value) => setState(() => _visibility = value!),
                items: MiniMapVisibility.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text('Minimap: ${value.name}'),
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
            child: Row(children: [
                
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: MiniMapViewer(
                    controller: _controller,
                    width: 250,
                    height: 150,
                    alignment: Alignment.bottomRight,
                    allowDrag: _allowDrag,
                    visibilityMode: _visibility,
                    child: const AirplaneCabin(),
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

class AirplaneCabin extends StatelessWidget {
  const AirplaneCabin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 5400,
      height: 1900,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE9F2F5), Color(0xFFD7E6EA)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FlightHeader(),
              const SizedBox(height: 40),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDFEFE),
                    borderRadius: BorderRadius.circular(220),
                    border: Border.all(
                      color: const Color(0xFF7698A0),
                      width: 4,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22375660),
                        blurRadius: 24,
                        offset: Offset(0, 12),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 76),
                    child: _CabinPlan(),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const _CabinLegend(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlightHeader extends StatelessWidget {
  const _FlightHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.flight_rounded, color: Color(0xFF0B6477), size: 56),
        SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ASTERIA AIRWAYS  /  A-900',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.4,
                color: Color(0xFF12333B),
              ),
            ),
            SizedBox(height: 7),
            Text(
              'Cabin plan  •  312 seats  •  Door 1L boarding',
              style: TextStyle(fontSize: 22, color: Color(0xFF547078)),
            ),
          ],
        ),
        Spacer(),
        _DirectionMarker(),
      ],
    );
  }
}

class _DirectionMarker extends StatelessWidget {
  const _DirectionMarker();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF12333B),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.arrow_back_rounded, color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text(
              'NOSE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CabinPlan extends StatelessWidget {
  const _CabinPlan();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _Cockpit(),
        SizedBox(width: 26),
        _ServiceBay(label: 'GALLEY\nLAV'),
        SizedBox(width: 26),
        _SeatCabin(
          title: 'FIRST',
          subtitle: '1-1 suites',
          color: Color(0xFF7A4D9B),
          rows: 3,
          topSeats: 1,
          bottomSeats: 1,
          seatSize: 62,
        ),
        SizedBox(width: 26),
        _ExitPair(),
        SizedBox(width: 26),
        _SeatCabin(
          title: 'BUSINESS',
          subtitle: '2-2 lie-flat',
          color: Color(0xFF226E93),
          rows: 8,
          topSeats: 2,
          bottomSeats: 2,
          seatSize: 48,
        ),
        SizedBox(width: 26),
        _ServiceBay(label: 'GALLEY\nLAV'),
        SizedBox(width: 26),
        _SeatCabin(
          title: 'PREMIUM\nECONOMY',
          subtitle: '2-3-2',
          color: Color(0xFFC26B37),
          rows: 7,
          topSeats: 2,
          middleSeats: 3,
          bottomSeats: 2,
          seatSize: 42,
        ),
        SizedBox(width: 26),
        _ExitPair(),
        SizedBox(width: 26),
        _SeatCabin(
          title: 'ECONOMY',
          subtitle: '3-3 seating',
          color: Color(0xFF2F8A68),
          rows: 22,
          topSeats: 3,
          bottomSeats: 3,
          seatSize: 34,
        ),
        SizedBox(width: 26),
        _ServiceBay(label: 'GALLEY\nLAV'),
      ],
    );
  }
}

class _Cockpit extends StatelessWidget {
  const _Cockpit();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF183E4A),
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(120),
          ),
          border: Border.all(color: const Color(0xFF0D2B35), width: 3),
        ),
        child: const Padding(
          padding: EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flight_rounded, color: Colors.white, size: 56),
              SizedBox(height: 16),
              Text(
                'COCKPIT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Flight deck',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFBFD9E0), fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeatCabin extends StatelessWidget {
  const _SeatCabin({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.rows,
    required this.topSeats,
    required this.bottomSeats,
    required this.seatSize,
    this.middleSeats = 0,
  });

  final String title;
  final String subtitle;
  final Color color;
  final int rows;
  final int topSeats;
  final int middleSeats;
  final int bottomSeats;
  final double seatSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: _flexForCabin(title),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withValues(alpha: 0.62), width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF506C73),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    rows,
                    (index) => _SeatColumn(
                      rowNumber: index + 1,
                      topSeats: topSeats,
                      middleSeats: middleSeats,
                      bottomSeats: bottomSeats,
                      seatSize: seatSize,
                      color: color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _flexForCabin(String cabin) {
    return switch (cabin) {
      'FIRST' => 8,
      'BUSINESS' => 17,
      'PREMIUM\nECONOMY' => 18,
      _ => 33,
    };
  }
}

class _SeatColumn extends StatelessWidget {
  const _SeatColumn({
    required this.rowNumber,
    required this.topSeats,
    required this.middleSeats,
    required this.bottomSeats,
    required this.seatSize,
    required this.color,
  });

  final int rowNumber;
  final int topSeats;
  final int middleSeats;
  final int bottomSeats;
  final double seatSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$rowNumber',
          style: const TextStyle(
            color: Color(0xFF607B81),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        _SeatGroup(count: topSeats, size: seatSize, color: color),
        const SizedBox(height: 16),
        if (middleSeats > 0) ...[
          _SeatGroup(count: middleSeats, size: seatSize, color: color),
          const SizedBox(height: 16),
        ],
        _SeatGroup(count: bottomSeats, size: seatSize, color: color),
      ],
    );
  }
}

class _SeatGroup extends StatelessWidget {
  const _SeatGroup({
    required this.count,
    required this.size,
    required this.color,
  });

  final int count;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: index == count - 1 ? 0 : 5),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.84),
              borderRadius: BorderRadius.circular(size * 0.18),
              border: Border.all(color: color, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceBay extends StatelessWidget {
  const _ServiceBay({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 126,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFE0E9EC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF93A9AF), width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_cafe_outlined, color: Color(0xFF46636A)),
              const SizedBox(height: 12),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF46636A),
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Icon(Icons.wc_outlined, color: Color(0xFF46636A)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExitPair extends StatelessWidget {
  const _ExitPair();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 68,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [_ExitDoor(), _ExitDoor(flip: true)],
      ),
    );
  }
}

class _ExitDoor extends StatelessWidget {
  const _ExitDoor({this.flip = false});

  final bool flip;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFD74141),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(flip ? 0 : 10),
          bottom: Radius.circular(flip ? 10 : 0),
        ),
      ),
      child: const SizedBox(
        width: 68,
        height: 70,
        child: Center(
          child: Text(
            'EXIT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
    );
  }
}

class _CabinLegend extends StatelessWidget {
  const _CabinLegend();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _LegendItem(label: 'First', color: Color(0xFF7A4D9B)),
        SizedBox(width: 18),
        _LegendItem(label: 'Business', color: Color(0xFF226E93)),
        SizedBox(width: 18),
        _LegendItem(label: 'Premium Economy', color: Color(0xFFC26B37)),
        SizedBox(width: 18),
        _LegendItem(label: 'Economy', color: Color(0xFF2F8A68)),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF365860),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
