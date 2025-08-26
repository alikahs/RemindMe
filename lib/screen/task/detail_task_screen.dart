import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:remind_task/style/color_style.dart';

import '../../route/route_name.dart';
import '../../style/text_style.dart';

class DetailTaskScreen extends StatefulWidget {
  const DetailTaskScreen({super.key});

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  Map<String, dynamic> detailDataTask = {};

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      detailDataTask = Get.arguments['detail_data_task'];
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
          'Detail Task',
          style: poppins(
            color: ColorsStyle.truffleTrouble,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 20.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: ColorsStyle.oatmealDisable,
            borderRadius: BorderRadius.only(topRight: Radius.circular(50.0)),
            gradient: const LinearGradient(
              begin: Alignment.topCenter, // arah gradient
              end: Alignment.bottomCenter, // arah gradient
              colors: [
                ColorsStyle.oatmealDisable, // #FFFFFF
                Colors.white, // warna custom kamu
              ],
            ),
            border: DashedBorder.fromBorderSide(
              dashLength: 10,
              side: BorderSide(color: ColorsStyle.truffleTrouble, width: 1.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.0,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${detailDataTask['judul_task']}',
                    style: poppins(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'On Progress',
                    style: poppins(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: ColorsStyle.orange,
                    ),
                  ),
                ],
              ),
              Text(
                '${detailDataTask['tanggal_mulai']} - ${detailDataTask['tanggal_selesai']}',
                style: poppins(fontSize: 11.0, fontWeight: FontWeight.w500),
              ),
              Text(
                '${detailDataTask['deskripsi_task']}',
                style: poppins(fontSize: 12.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                height: 30.0,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Task List',
                style: poppins(fontSize: 13.0, fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: detailDataTask['list_task'].length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 2.0),
                      child: Text(
                        '${i + 1}. ${detailDataTask['list_task'][i]['nama_task']}',
                        style: poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.0,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RouteName.editTask);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsStyle.oatmealModif,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fixedSize: const Size(double.infinity, 50.0),
                    ),
                    child: Center(
                      child: Text(
                        'Edit Task',
                        style: poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
                      fixedSize: const Size(double.infinity, 50.0),
                    ),
                    child: Center(
                      child: Text(
                        'Delete Task',
                        style: poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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
