import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/services/global.dart';
import 'package:zuluresh/views/main_application/main_home.dart';
import 'package:zuluresh/views/set_location.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  checkFirstSeen() async {
    if (Global.storageServices.getString("pin_code") != null &&
        Global.storageServices.getString("pin_location") != null) {
      if (Global.storageServices.getString("x-auth-token") != null) {
        Global.apiClient
            .updateHeader(Global.storageServices.getString("x-auth-token"));
      }
      Timer(const Duration(seconds: 1), () async {
        Get.offAll(() => const MainHomeScreen());
      });
    } else {
      Timer(const Duration(seconds: 1), () async {
        Get.offAll(() => const SetLocation());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Image(
                image:
                    AssetImage("assets/images/set-location-intro3-plate.png"),
              ),
            ),
            // Center(
            //   child: Text(
            //     "SSU",
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20.sp,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 2.h),
            // const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
