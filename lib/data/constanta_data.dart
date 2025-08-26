import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConstantaData {
  static List<Map<String, dynamic>> listControllerTask = [
    {
      'title': 'Judul Task',
      'hint': 'contoh: Buat app mobile',
      'suffix_icon': false,
      'controller': TextEditingController(),
    },
    {
      'title': 'Durasi Pengerjaan',
      'hint':
          'contoh: ${DateFormat('dd MMM yyyy').format(DateTime.now())} - ${DateFormat('dd MMM yyyy').format(DateTime.now().add(Duration(days: 1)))}',
      'suffix_icon': true,
      'controller': TextEditingController(),
    },
    {
      'title': 'Deskripsi Task',
      'hint': 'contoh: app mobile menggunakan flutter',
      'suffix_icon': false,
      'controller': TextEditingController(),
    },
  ];
}
