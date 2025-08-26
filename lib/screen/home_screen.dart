import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remind_task/route/route_name.dart';
import 'package:remind_task/style/text_style.dart';

import '../style/color_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTask = 0;

  List<Map<String, dynamic>> dataTask = [
    {
      'judul_task': 'App RemindMe',
      'tanggal_mulai': '25 Oktober 2025',
      'tanggal_selesai': '',
      'durasi_pengerjaan': '',
      'peserta': [],
      'deskripsi_task':
          'Membuat sebuah aplikasi pengingat task di mobile dan windows',
      'list_task': [
        {
          'nama_task': 'Buat design app',
          'tanggal_mulai': '25 Oktober 2025',
          'tanggal_selesai': '25 Oktober 2025',
          'isDone': true,
        },
        {
          'nama_task': 'Implementasi design ke code',
          'tanggal_mulai': '25 Oktober 2025',
          'tanggal_selesai': '',
          'isDone': false,
        },
        {
          'nama_task': 'Buat backend',
          'tanggal_mulai': '25 Oktober 2025',
          'tanggal_selesai': '',
          'isDone': false,
        },
      ],
    },
    {
      'judul_task': 'Mobile App Kezmo',
      'tanggal_mulai': '20 Oktober 2025',
      'tanggal_selesai': '',
      'durasi_pengerjaan': '',
      'peserta': [],
      'deskripsi_task':
          'Membuat sebuah aplikasi pencatatan keuangan mobile versi 1.0',
      'list_task': [
        {
          'nama_task': 'Buat design app',
          'tanggal_mulai': '20 Oktober 2025',
          'tanggal_selesai': '',
          'isDone': false,
        },
        {
          'nama_task': 'Buat backend',
          'tanggal_mulai': '20 Oktober 2025',
          'tanggal_selesai': '',
          'isDone': false,
        },
      ],
    },
  ];

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Afternoon";
    } else if (hour >= 17 && hour < 21) {
      return "Evening";
    } else {
      return "Night";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsStyle.palladian,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Group 1.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(RouteName.timer);
            },
            icon: SvgPicture.asset('assets/images/icon_timer.svg'),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Container(width: 20.0, height: 30.0, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            //height: 175,
            padding: const EdgeInsets.only(left: 20.0, top: 0.0),
            margin: const EdgeInsets.only(right: 20.0),
            decoration: BoxDecoration(
              color: ColorsStyle.palladian,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50.0),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/Group 1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getGreeting(),
                      style: poppins(
                        color: ColorsStyle.truffleTrouble,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Amanda',
                      style: poppins(
                        color: ColorsStyle.truffleTrouble,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '- RemindMe -',
                      style: poppins(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      //mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Kotak tanggal
                        Container(
                          width: 70.0,
                          height: 50.0,
                          //margin: EdgeInsets.zero,
                          decoration: const BoxDecoration(
                            color: Color(0xFF9B4A35), // warna coklat
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${DateTime.now().day}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                DateFormat('MMM yyyy').format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Kotak hari vertikal
                        Container(
                          width: 40.0,
                          height: 90.0,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: DateFormat('EEE')
                                .format(DateTime.now())
                                .split("")
                                .map((letter) {
                                  return Text(
                                    letter,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                })
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.0,
                children: [
                  Text(
                    'Today Task',
                    style: poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                    child: ListView.builder(
                      itemCount: dataTask.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, i) {
                        // Ambil list_task
                        final List<Map<String, dynamic>> listTask =
                            (dataTask[i]['list_task'] as List)
                                .cast<Map<String, dynamic>>();

                        // Hitung progres
                        final int total = listTask.length;
                        final int done = listTask
                            .where((t) => t['isDone'] == true)
                            .length;
                        final double progress = total == 0
                            ? 0
                            : done / total; // 0.0 - 1.0
                        final int percent = (progress * 100).round(); // 0 - 100
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedTask = i;
                            });
                            // Get.toNamed(
                            //   RouteName.detailTask,
                            //   arguments: {'detail_data_task': dataTask[i]},
                            // );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            width: 200.0,
                            margin: const EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              color: selectedTask == i
                                  ? ColorsStyle.palladian
                                  : ColorsStyle.oatmealDisable,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  spacing: 5.0,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        dataTask[i]['tanggal_mulai'],
                                        style: poppins(
                                          color: selectedTask == i
                                              ? Colors.black
                                              : Colors.black38,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      dataTask[i]['judul_task'],
                                      style: poppins(
                                        color: selectedTask == i
                                            ? Colors.black
                                            : Colors.black38,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      dataTask[i]['deskripsi_task'],
                                      style: poppins(
                                        color: selectedTask == i
                                            ? Colors.black
                                            : Colors.black38,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 5.0,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Progres',
                                          style: poppins(
                                            color: selectedTask == i
                                                ? Colors.black
                                                : Colors.black38,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '$percent %',
                                          style: poppins(
                                            color: selectedTask == i
                                                ? Colors.black
                                                : Colors.black38,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Progress bar (animasi halus)
                                    TweenAnimationBuilder<double>(
                                      tween: Tween(begin: 0, end: progress),
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      builder: (context, value, _) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          child: LinearProgressIndicator(
                                            value: value,
                                            minHeight: 5,
                                            backgroundColor: Colors.white,
                                            valueColor: AlwaysStoppedAnimation(
                                              value < 0.34
                                                  ? ColorsStyle.truffleTrouble
                                                  : (value < 0.67
                                                        ? ColorsStyle
                                                              .truffleTrouble
                                                        : Colors.green),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: selectedTask == i
                                        ? () {
                                            Get.toNamed(
                                              RouteName.detailTask,
                                              arguments: {
                                                'detail_data_task': dataTask[i],
                                              },
                                            );
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: selectedTask == i
                                          ? ColorsStyle.truffleTrouble
                                          : Colors.black12,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      fixedSize: Size(80.0, 20.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Detail',
                                        style: poppins(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    'Task List',
                    style: poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dataTask[selectedTask]['list_task'].length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, i) {
                        final isDone =
                            dataTask[selectedTask]['list_task'][i]['isDone'] ==
                            true;
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            color: ColorsStyle.palladian,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 10.0,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Center(
                                      child: Text(
                                        '${i + 1}',
                                        style: poppins(
                                          color: ColorsStyle.truffleTrouble,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    dataTask[selectedTask]['list_task'][i]['nama_task'],
                                    style: poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                              Checkbox(
                                activeColor: ColorsStyle.truffleTrouble,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                side: BorderSide(
                                  color: isDone
                                      ? Colors.transparent
                                      : Colors.black26,
                                  width: 1,
                                ),
                                value: isDone,
                                onChanged: (bool? value) {
                                  setState(() {
                                    dataTask[selectedTask]['list_task'][i]['isDone'] =
                                        value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.addTask);
        },
        backgroundColor: ColorsStyle.truffleTrouble,
        child: const Icon(Icons.add_outlined, color: Colors.white),
      ),
    );
  }
}
