import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:remind_task/route/route_name.dart';
import 'package:remind_task/style/color_style.dart';
import 'package:remind_task/style/text_style.dart';

class SiginScreen extends StatefulWidget {
  const SiginScreen({super.key});

  @override
  State<SiginScreen> createState() => _SiginScreenState();
}

class _SiginScreenState extends State<SiginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/signin_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Center(
              child: Text(
                'RemindMe',
                style: poppins(
                  color: ColorsStyle.truffleTrouble,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                InkWell(
                  onTap: () {
                    Get.offAllNamed(RouteName.home);
                  },
                  child: Container(
                    width: 150.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: ColorsStyle.truffleTrouble,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10.0,
                      children: [
                        Text(
                          'Sign In',
                          style: poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SvgPicture.asset('assets/images/icon_login.svg'),
                      ],
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
