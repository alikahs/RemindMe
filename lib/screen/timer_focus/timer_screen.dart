import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:remind_task/style/color_style.dart';
import '../../style/text_style.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

enum _Session { focus, shortBreak, longBreak }

class _TimerScreenState extends State<TimerScreen> {
  // ====== STATE UTAMA ======
  _Session _session = _Session.focus;

  // Konfigurasi dari user (menit & flags)
  int focusM = 25;
  int shortM = 5;
  int longM = 15;
  int longEvery = 4;
  bool autoStartNext = true;

  // Runtime (detik)
  int _total = 25 * 60;
  int _remaining = 25 * 60;
  bool _running = false;
  Timer? _ticker;
  int _completedFocus = 0;

  // ====== LIFECYCLE ======
  @override
  void initState() {
    super.initState();
    _loadPrefs().then((_) {
      if (!mounted) return;
      _applySession(_Session.focus, resetCounter: true);
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _ticker = null;
    _running = false;
    super.dispose();
  }

  // ====== PREFS ======
  Future<void> _loadPrefs() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      focusM = p.getInt('focus_m') ?? 25;
      shortM = p.getInt('short_m') ?? 5;
      longM = p.getInt('long_m') ?? 15;
      longEvery = p.getInt('long_every') ?? 4;
      autoStartNext = p.getBool('auto_next') ?? true;
    });
  }

  Future<void> _savePrefs() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('focus_m', focusM);
    await p.setInt('short_m', shortM);
    await p.setInt('long_m', longM);
    await p.setInt('long_every', longEvery);
    await p.setBool('auto_next', autoStartNext);
  }

  // ====== TIMER LOGIC ======
  void _applySession(_Session s, {bool resetCounter = false}) {
    _session = s;
    final secs = switch (s) {
      _Session.focus => focusM * 60,
      _Session.shortBreak => shortM * 60,
      _Session.longBreak => longM * 60,
    };
    if (resetCounter) _completedFocus = 0;

    _pause();
    if (!mounted) return;
    setState(() {
      _total = secs;
      _remaining = secs;
    });
  }

  void _start() {
    if (_running) return;
    _running = true;

    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (_remaining <= 1) {
        t.cancel();
        _ticker = null;
        _running = false;
        setState(() => _remaining = 0);
        _onSessionFinished();
      } else {
        setState(() => _remaining--);
      }
    });

    if (mounted) setState(() {}); // trigger rebuild tombol Start->Pause
  }

  void _pause() {
    _ticker?.cancel();
    _ticker = null;
    _running = false;
    if (mounted) setState(() {});
  }

  void _reset() {
    _pause();
    if (mounted) setState(() => _remaining = _total);
  }

  void _onSessionFinished() {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('${_label(_session)} selesai → lanjut otomatis'),
        duration: const Duration(seconds: 1),
      ),
    );

    if (_session == _Session.focus) {
      _completedFocus++;
      if (_completedFocus % (longEvery.clamp(1, 12)) == 0) {
        _applySession(_Session.longBreak);
      } else {
        _applySession(_Session.shortBreak);
      }
    } else {
      _applySession(_Session.focus);
    }

    if (autoStartNext) _start();
  }

  // ====== HELPERS UI ======
  String _format(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  String _label(_Session s) => switch (s) {
    _Session.focus => 'Focus',
    _Session.shortBreak => 'Short Break',
    _Session.longBreak => 'Long Break',
  };

  int _previewNextSecs() {
    if (_session == _Session.focus) {
      final willBeLong =
          ((_completedFocus + 1) % (longEvery.clamp(1, 12)) == 0);
      return (willBeLong ? longM : shortM) * 60;
    } else {
      return focusM * 60;
    }
  }

  double get _progress => _total == 0 ? 0 : 1 - (_remaining / _total);

  // ====== SETTINGS DIALOG ======
  Future<void> _openSettings() async {
    final focusCtrl = TextEditingController(text: focusM.toString());
    final shortCtrl = TextEditingController(text: shortM.toString());
    final longCtrl = TextEditingController(text: longM.toString());
    final everyCtrl = TextEditingController(text: longEvery.toString());
    bool autoNextLocal = autoStartNext;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Timer Settings',
            style: poppins(fontWeight: FontWeight.w700),
          ),
          content: StatefulBuilder(
            builder: (ctx, setStateDlg) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NumField(label: 'Focus (menit)', controller: focusCtrl),
                    const SizedBox(height: 10),
                    _NumField(
                      label: 'Short Break (menit)',
                      controller: shortCtrl,
                    ),
                    const SizedBox(height: 10),
                    _NumField(
                      label: 'Long Break (menit)',
                      controller: longCtrl,
                    ),
                    const SizedBox(height: 10),
                    _NumField(
                      label: 'Long Break setiap N fokus',
                      controller: everyCtrl,
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Auto-start sesi berikutnya',
                        style: poppins(fontWeight: FontWeight.w600),
                      ),
                      value: autoNextLocal,
                      onChanged: (v) => setStateDlg(() => autoNextLocal = v),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsStyle.truffleTrouble,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                int? f = int.tryParse(focusCtrl.text);
                int? s = int.tryParse(shortCtrl.text);
                int? l = int.tryParse(longCtrl.text);
                int? e = int.tryParse(everyCtrl.text);

                // Validasi sederhana
                bool bad = false;
                if (f == null || f < 1 || f > 180) bad = true;
                if (s == null || s < 1 || s > 180) bad = true;
                if (l == null || l < 1 || l > 180) bad = true;
                if (e == null || e < 1 || e > 12) bad = true;

                if (bad) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cek input (1–180 menit, long-every 1–12)'),
                    ),
                  );
                  return;
                }

                // Apply ke state lokal
                focusM = f!;
                shortM = s!;
                longM = l!;
                longEvery = e!;
                autoStartNext = autoNextLocal;

                Navigator.pop(ctx, true);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (ok == true) {
      await _savePrefs();
      _applySession(_session); // tetap di sesi sekarang tapi pakai durasi baru
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pengaturan tersimpan')));
    }
  }

  // ====== BUILD ======
  @override
  Widget build(BuildContext context) {
    final label = _label(_session);
    final nextInfo = (_session == _Session.focus)
        ? 'Next: Break ${_format(_previewNextSecs())}'
        : 'Next: Focus ${_format(_previewNextSecs())}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset('assets/images/icon_back.svg'),
        ),
        title: Text(
          'Focus Time',
          style: poppins(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openSettings,
            tooltip: 'Settings',
            icon: const Icon(
              Icons.settings_rounded,
              color: ColorsStyle.truffleTrouble,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 28.0),
          decoration: const BoxDecoration(color: Colors.white),
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header + preview
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: ColorsStyle.truffleTrouble,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        label,
                        style: poppins(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      nextInfo,
                      style: poppins(
                        color: Colors.black54,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Progress ring + time
                SizedBox(
                  width: 260,
                  height: 260,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 260,
                        height: 260,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: _progress),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          builder: (context, v, _) {
                            return CircularProgressIndicator(
                              value: v.clamp(0, 1),
                              strokeWidth: 16,
                              backgroundColor: Colors.black12,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                ColorsStyle.truffleTrouble,
                              ),
                            );
                          },
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _format(_remaining),
                            style: poppins(
                              color: Colors.black,
                              fontSize: 50.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Completed Focus: $_completedFocus',
                            style: poppins(
                              color: Colors.black45,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Controls
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _running ? _pause : _start,
                        icon: Icon(
                          _running
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                        ),
                        label: Text(_running ? 'Pause' : 'Start'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          backgroundColor: ColorsStyle.truffleTrouble,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton.filledTonal(
                      onPressed: _reset,
                      icon: const Icon(Icons.restart_alt_rounded),
                      style: IconButton.styleFrom(
                        minimumSize: const Size(52, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Pindah mode manual (opsional)
                Wrap(
                  spacing: 8,
                  children: [
                    _ModeChip(
                      label: 'Focus ${focusM}m',
                      selected: _session == _Session.focus,
                      onTap: () => _applySession(_Session.focus),
                    ),
                    _ModeChip(
                      label: 'Short ${shortM}m',
                      selected: _session == _Session.shortBreak,
                      onTap: () => _applySession(_Session.shortBreak),
                    ),
                    _ModeChip(
                      label: 'Long ${longM}m',
                      selected: _session == _Session.longBreak,
                      onTap: () => _applySession(_Session.longBreak),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ====== WIDGET BANTUAN ======
class _NumField extends StatelessWidget {
  const _NumField({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? ColorsStyle.truffleTrouble : Colors.black12;
    final fg = selected ? Colors.white : Colors.black87;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: fg,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}
