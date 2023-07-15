import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/controllers/choose_location_controller.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/main_application/main_home.dart';

import '../common/custom_toasts.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  final ChooseLocationController _chooseLocationController =
      Get.put(ChooseLocationController());

  TextEditingController pinTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Your Location",
          style: GoogleFonts.heebo(
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xFFC5C5C5)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  width: 90.w,
                  height: 55,
                  child: TextFormField(
                    controller: pinTextController,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () async {
                          if (await _chooseLocationController
                              .checkLocationServiceable(context, false, "")) {
                            Get.offAll(() => const MainHomeScreen());
                          } else {
                            if (mounted) {
                              CustomToasts.errorToast(context,
                                  "Sorry! We don't serve this location.");
                            }
                          }
                        },
                        child: Icon(
                          Icons.my_location_sharp,
                          color: Constants.primaryColor,
                          size: 18.sp,
                        ),
                      ),
                      icon: Icon(
                        Icons.search,
                        size: 18.sp,
                        color: Colors.black,
                      ),
                      hintText: "Enter Your Pin code",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                InkWell(
                  onTap: () async {
                    if (await _chooseLocationController
                        .checkLocationServiceable(context, true, pinTextController.text)) {
                      Get.offAll(() => const MainHomeScreen());
                    } else {
                      if (mounted) {
                        CustomToasts.errorToast(
                            context, "Sorry! We don't serve this location.");
                      }
                    }
                  },
                  child: Container(
                    height: 55,
                    width: 40.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF941A49),
                          Color(0xFF941A49),
                          Color(0xFFEF578A),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(
                        //   Icons.my_location_sharp,
                        //   color: Colors.white,
                        //   size: 18.sp,
                        // ),
                        // SizedBox(width: 2.w),
                        Text(
                          "Order",
                          style: GoogleFonts.heebo(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    height: 100.h - 57.h - 110 - AppBar().preferredSize.height),
                SizedBox(
                  height: 50.h,
                  width: 100.w,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 100.w,
                            child: const Image(
                              image: AssetImage(
                                  "assets/images/choose-location-bottom.png"),
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                            child: const Image(
                              image: AssetImage(
                                  "assets/images/choose-location-bottom2.png"),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 15.h,
                        child: SizedBox(
                          width: 100.w,
                          child: const Image(
                            image: AssetImage(
                                "assets/images/choose-location-middle.png"),
                          ),
                        ),
                      )
                    ],
                  ),
                )
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //           color: Colors.grey.shade300,
                //           offset: const Offset(-5, -5),
                //           blurRadius: 15,
                //           spreadRadius: 1),
                //     ],
                //   ),
                //   height: AppBar().preferredSize.height,
                //   width: 100.w,
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.arrow_back_ios_new_sharp,
                //         size: 19.sp,
                //         color: const Color(0xFF941A49),
                //       ),
                //       Text(
                //         "Select Your Location",
                //         style: GoogleFonts.heebo(
                //           fontWeight: FontWeight.w500,
                //           fontSize: 18.sp,
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
