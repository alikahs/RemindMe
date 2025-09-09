import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remind_task/bloc/task/add_task/add_task_bloc.dart';
import 'package:remind_task/route/route_name.dart';
import '../../data/model/request_model/task/task_request_model.dart';
import '../../style/color_style.dart';
import '../../style/text_style.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  List<Map<String, dynamic>> listControllerTask = [
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

  TextEditingController pesertaController = TextEditingController();
  final DateFormat _fmt = DateFormat('dd MMM yyyy');
  DateTimeRange? _pickedRange;

  List<Map<String, dynamic>> subTask = [
    {'controller': TextEditingController()},
  ];

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final initialRange =
        _pickedRange ??
        DateTimeRange(start: now, end: now.add(const Duration(days: 1)));

    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      initialDateRange: initialRange,
      helpText: 'Pilih Durasi Pengerjaan',
      saveText: 'PILIH',
      builder: (context, child) {
        // Opsional: sesuaikan tema dialog
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: ColorsStyle.truffleTrouble),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      setState(() {
        _pickedRange = result;
        final start = _fmt.format(result.start);
        final end = _fmt.format(result.end);
        // Asumsi index 1 adalah "Durasi Pengerjaan" sesuai list kamu
        (listControllerTask[1]['controller'] as TextEditingController).text =
            '$start - $end';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/images/icon_back.svg'),
        ),
        title: Text(
          'Add Task',
          style: poppins(
            color: ColorsStyle.truffleTrouble,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //spacing: 10.0,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listControllerTask.length,
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5.0,
                  children: [
                    Text(
                      listControllerTask[i]['title'],
                      style: poppins(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    (i == 2)
                        ? SizedBox(
                            height: 150,
                            child: TextFormField(
                              controller: listControllerTask[i]['controller'],
                              expands: true, // penting biar ngisi tinggi parent
                              maxLines: null, // wajib null kalau pakai expands
                              minLines: null,
                              textAlignVertical: TextAlignVertical
                                  .top, // biar teks mulai dari atas
                              decoration: InputDecoration(
                                hintText: listControllerTask[i]['hint'],
                                suffixIcon:
                                    listControllerTask[i]['suffix_icon'] == true
                                    ? IconButton(
                                        onPressed: null,
                                        icon: SvgPicture.asset(
                                          'assets/images/icon_date.svg',
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          )
                        : TextFormField(
                            controller: listControllerTask[i]['controller'],
                            readOnly: i == 1 ? true : false,
                            decoration: InputDecoration(
                              hintText: listControllerTask[i]['hint'],
                              suffixIcon:
                                  listControllerTask[i]['suffix_icon'] == true
                                  ? IconButton(
                                      onPressed: () {
                                        _pickDateRange();
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/images/icon_date.svg',
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                    const SizedBox(height: 10.0),
                  ],
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5.0,
              children: [
                // Text(
                //   'Peserta',
                //   style: poppins(
                //     color: Colors.black,
                //     fontSize: 14.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   spacing: 10.0,
                //   children: [
                //     Expanded(
                //       flex: 1,
                //       child: TextFormField(
                //         controller: pesertaController,
                //         decoration: InputDecoration(
                //           hintText: 'contoh : name@example.com',
                //         ),
                //       ),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {},
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: ColorsStyle.truffleTrouble,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //         ),
                //         fixedSize: const Size(double.infinity, 60.0),
                //       ),
                //       child: Center(
                //         child: Text(
                //           'Tambah',
                //           style: poppins(
                //             fontSize: 12.0,
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 30.0,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 1,
                //     padding: EdgeInsets.zero,
                //     itemBuilder: (context, index) {
                //       return Padding(
                //         padding: const EdgeInsets.only(right: 5.0),
                //         child: InkWell(
                //           onTap: () {
                //             debugPrint('delete');
                //           },
                //           child: Stack(
                //             clipBehavior: Clip.none,
                //             children: [
                //               // lingkaran
                //               Container(
                //                 width: 35.0,
                //                 height: 35.0,
                //                 decoration: const BoxDecoration(
                //                   color: Colors.black12,
                //                   shape: BoxShape.circle,
                //                 ),
                //               ),
                //               // icon "-" di pojok kanan atas (sedikit di luar)
                //               const Positioned(
                //                 top: -2,
                //                 right: -2,
                //                 child: Icon(
                //                   Icons.remove_circle,
                //                   size: 16,
                //                   color: ColorsStyle.truffleTrouble,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5.0,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Task',
                          style: poppins(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              subTask.add({
                                'controller': TextEditingController(),
                              });
                            });
                          },
                          child: Text(
                            'Tambah Task',
                            style: poppins(
                              color: ColorsStyle.truffleTrouble,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      itemCount: subTask.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10.0,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black12,
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: poppins(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: subTask[i]['controller'],
                                  decoration: InputDecoration(
                                    hintText: 'contoh: Buat app mobile',
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (subTask.length > 1) {
                                    setState(() {
                                      subTask.removeAt(i);
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: ColorsStyle.truffleTrouble,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                BlocConsumer<AddTaskBloc, AddTaskState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      error: (message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      success: (data) {
                        Get.offNamed(RouteName.home);
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => ElevatedButton(
                        onPressed: () {
                          // ambil nilai dasar
                          final judul = listControllerTask[0]['controller'].text
                              .trim();
                          final durasiRaw = listControllerTask[1]['controller']
                              .text
                              .trim(); // "09 Sep 2025 - 12 Sep 2025"
                          final deskripsi = listControllerTask[2]['controller']
                              .text
                              .trim();

                          // validasi ringan
                          if (judul.isEmpty || durasiRaw.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Judul dan durasi tidak boleh kosong',
                                ),
                              ),
                            );
                            return;
                          }

                          // parse durasi "dd MMM yyyy - dd MMM yyyy"
                          DateTime? startedAt;
                          DateTime? endedAt;
                          try {
                            final fmt = DateFormat('dd MMM yyyy');
                            final parts = durasiRaw.split('-');
                            if (parts.length == 2) {
                              final startStr = parts[0].trim();
                              final endStr = parts[1].trim();
                              startedAt = fmt.parseStrict(startStr);
                              endedAt = fmt.parseStrict(endStr);
                            }
                          } catch (_) {
                            // fallback kalau gagal parse
                            startedAt ??= DateTime.now();
                            endedAt ??= DateTime.now();
                          }

                          // bangun list SubTask dari input user
                          final List<SubTask> subTasks = subTask
                              .map<SubTask?>((e) {
                                final text =
                                    (e['controller'] as TextEditingController)
                                        .text
                                        .trim();
                                if (text.isEmpty) return null;
                                return SubTask(
                                  isiSubTask: text,
                                  isCompleted: false,
                                  startedAt:
                                      DateTime.now(), // mulai dicatat saat dibuat
                                  endedAt: null,
                                );
                              })
                              .whereType<SubTask>()
                              .toList();

                          // bikin TaskModel; idTask kosong supaya diisi otomatis oleh datasource
                          final task = TaskModel(
                            idTask: '',
                            judulTask: judul,
                            startedAt: startedAt,
                            endedAt: endedAt,
                            deskripsiTask: deskripsi,
                            subTask: subTasks,
                            idUser: "US2MR2MrAJYKLAh1EdIv",
                            member: const [],
                          );

                          // optional: debug print data yang rapih
                          debugPrint('data task (model): ${task.toJson()}');

                          // kirim ke AddTaskBloc
                          context.read<AddTaskBloc>().add(
                            AddTaskEvent.addTask(taskModel: task),
                          );

                          // kalau mau langsung refresh list setelah add sukses,
                          // kamu bisa listen state AddTaskBloc dan trigger GetTaskBloc.fetch()
                          // atau cukup pop/snackbar di listener.
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsStyle.truffleTrouble,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fixedSize: const Size(double.infinity, 50.0),
                        ),
                        child: Center(
                          child: Text(
                            'Simpan',

                            style: poppins(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
