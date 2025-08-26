import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
                                        onPressed: () {},
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
                            decoration: InputDecoration(
                              hintText: listControllerTask[i]['hint'],
                              suffixIcon:
                                  listControllerTask[i]['suffix_icon'] == true
                                  ? IconButton(
                                      onPressed: () {},
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
                Text(
                  'Peserta',
                  style: poppins(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10.0,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: pesertaController,
                        decoration: InputDecoration(
                          hintText: 'contoh : name@example.com',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsStyle.truffleTrouble,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fixedSize: const Size(double.infinity, 60.0),
                      ),
                      child: Center(
                        child: Text(
                          'Tambah',
                          style: poppins(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: InkWell(
                          onTap: () {
                            debugPrint('delete');
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // lingkaran
                              Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              // icon "-" di pojok kanan atas (sedikit di luar)
                              const Positioned(
                                top: -2,
                                right: -2,
                                child: Icon(
                                  Icons.remove_circle,
                                  size: 16,
                                  color: ColorsStyle.truffleTrouble,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
                          onPressed: () {},
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
                      itemCount: 1,
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
                                  decoration: InputDecoration(
                                    hintText: 'contoh: Buat app mobile',
                                  ),
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
                ElevatedButton(
                  onPressed: () {},
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
