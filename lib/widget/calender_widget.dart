import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../style/color_style.dart';
import '../style/text_style.dart';

class CalendarStrip extends StatefulWidget {
  const CalendarStrip({super.key});

  @override
  State<CalendarStrip> createState() => _CalendarStripState();
}

class _CalendarStripState extends State<CalendarStrip> {
  final double _itemWidth = 60.0;
  final double _itemExtent = 70.0; // width + gap (≈10)
  late final ScrollController _sc;
  late final List<DateTime> _days;
  late final int _todayIndex;

  // label bulan yang ditampilkan di header
  late DateTime _labelMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    // rentang: 1 bulan sebelumnya s/d 1 bulan sesudahnya
    final firstPrevMonth = DateTime(now.year, now.month - 1, 1);
    final lastNextMonth = DateTime(
      now.year,
      now.month + 2,
      0,
    ); // last day next month

    final totalDays = lastNextMonth.difference(firstPrevMonth).inDays + 1;

    _days = List.generate(
      totalDays,
      (i) => DateTime(
        firstPrevMonth.year,
        firstPrevMonth.month,
        firstPrevMonth.day + i,
      ),
    );

    _todayIndex = now.difference(firstPrevMonth).inDays;
    _labelMonth = DateTime(now.year, now.month);

    // auto-scroll ke hari ini
    _sc = ScrollController(initialScrollOffset: _todayIndex * _itemExtent);

    // update label bulan saat discroll
    _sc.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_sc.hasClients) return;
    final idx = (_sc.offset / _itemExtent).round().clamp(0, _days.length - 1);
    final d = _days[idx];
    final newLabel = DateTime(d.year, d.month);
    if (newLabel.month != _labelMonth.month ||
        newLabel.year != _labelMonth.year) {
      setState(() => _labelMonth = newLabel);
    }
  }

  @override
  void dispose() {
    _sc.removeListener(_onScroll);
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return SizedBox(
      height: 120.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Kalau Flutter versi lama belum ada `spacing`, ganti dengan SizedBox(height: 10)
          spacing: 10.0,
          children: [
            // Header bulan dinamis
            Text(
              DateFormat('MMMM yyyy').format(_labelMonth),
              style: poppins(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: ColorsStyle.truffleTrouble,
              ),
            ),

            Expanded(
              child: ListView.builder(
                controller: _sc,
                scrollDirection: Axis.horizontal,
                itemCount: _days.length,
                itemExtent:
                    _itemExtent, // jaga lebar + jarak antar item konsisten
                padding: EdgeInsets.zero,
                itemBuilder: (ctx, i) {
                  final d = _days[i];
                  final isToday =
                      d.year == now.year &&
                      d.month == now.month &&
                      d.day == now.day;

                  return Center(
                    child: Container(
                      width: _itemWidth,
                      decoration: BoxDecoration(
                        color: isToday
                            ? ColorsStyle.truffleTrouble
                            : Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(
                          color: isToday
                              ? Colors.white
                              : ColorsStyle.oatmealModif,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // kalau Flutter lama: ganti dengan SizedBox(height: 5)
                        spacing: 5.0,
                        children: [
                          Text(
                            '${d.day}',
                            style: poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: isToday
                                  ? Colors.white
                                  : ColorsStyle.truffleTrouble,
                            ),
                          ),
                          Text(
                            DateFormat('EEE').format(d),
                            style: poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0,
                              color: isToday
                                  ? Colors.white
                                  : ColorsStyle.truffleTrouble,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
