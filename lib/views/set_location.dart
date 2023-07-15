import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/button/primary_filled_button.dart';
import 'package:zuluresh/controllers/set_location_controller.dart';
import 'package:zuluresh/views/choose_location.dart';

class SetLocation extends StatefulWidget {
  const SetLocation({super.key});

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  SetLocationController setLocationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(
              height: 75.h,
              width: 100.w,
              child: Stack(
                children: [
                  SizedBox(
                    height: 75.h,
                    width: 100.w,
                    child: PageView(
                      controller: setLocationController.pageController,
                      onPageChanged: (int index) {
                        setLocationController.page.value = index;
                      },
                      children: [
                        intro1(),
                        intro2(),
                        intro3(),
                        intro4(),
                      ],
                    ),
                  ),
                  // Dots Indicator
                  Positioned(
                    bottom: 5.h,
                    child: SizedBox(
                      height: 15,
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 0; i < 4; i++)
                            Row(
                              children: [
                                dots(i),
                                SizedBox(width: 5.w),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.h),
                    topRight: Radius.circular(5.h),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(-5, -5),
                        blurRadius: 15,
                        spreadRadius: 1),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 3.5.h),
                    Text(
                      "Set Location To Proceed",
                      style: GoogleFonts.heebo(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 19.sp,
                      ),
                    ),
                    SizedBox(height: 3.5.h),
                    InkWell(
                      onTap: () {
                        Get.to(() => const ChooseLocation());
                      },
                      child: PrimaryFilledButton(
                        buttonText: "Set Location",
                        width: 90.w,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget intro4() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            height: 20.h,
            width: 30.w,
            child: const Image(
              image: AssetImage("assets/images/set-location-top-left.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
            // height: 40.h,
            // color: Colors.red,
            width: 60.w,
            child: const Image(
              image: AssetImage("assets/images/set-location-top-right.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          top: 2.5.h,
          left: 32.5.w,
          child: SizedBox(
            height: 20.h,
            width: 30.w,
            child: const Image(
              image: AssetImage("assets/images/set-location-intro4-legs.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: 70.h,
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 85.w,
                width: 85.w,
                child: const Image(
                  image: AssetImage(
                      "assets/images/set-location-intro4-plate1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 7.5.h),
              SizedBox(
                height: 15,
                width: 100.w,
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget intro3() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            height: 20.h,
            width: 30.w,
            child: const Image(
              image: AssetImage("assets/images/set-location-intro3-zeera.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
            width: 25.w,
            child: const Image(
              image: AssetImage("assets/images/set-location-intro3-lemon.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: 70.h,
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 15.h),
              SizedBox(
                height: 90.w,
                width: 90.w,
                child: const Image(
                  image:
                      AssetImage("assets/images/set-location-intro3-plate.png"),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 15,
                width: 100.w,
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget intro2() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
            // height: 40.h,
            // color: Colors.red,
            width: 20.w,
            child: const Image(
              image: AssetImage("assets/images/set-location-intro2-zeera.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Stack(
          children: [
            SizedBox(
              height: 100.w,
              width: 100.w,
              child: const Image(
                image:
                    AssetImage("assets/images/set-location-intro2-dhaniya.png"),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 100.w,
              width: 100.w,
              child: const Image(
                image:
                    AssetImage("assets/images/set-location-intro2-plate.png"),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: 70.h,
        //   width: 100.w,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       SizedBox(height: 15.h),
        //       Stack(
        //         children: [
        //           SizedBox(
        //             height: 80.w,
        //             width: 80.w,
        //             child: const Image(
        //               image: AssetImage(
        //                   "assets/images/set-location-intro2-dhaniya.png"),
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //           SizedBox(
        //             height: 80.w,
        //             width: 80.w,
        //             child: const Image(
        //               image: AssetImage(
        //                   "assets/images/set-location-intro2-plate.png"),
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //         ],
        //       ),
        //       SizedBox(height: 5.h),
        //       SizedBox(
        //         height: 15,
        //         width: 100.w,
        //         // child: Row(
        //         //   mainAxisAlignment: MainAxisAlignment.center,
        //         //   children: [
        //         //     dots(const Color(0xFF941A49)),
        //         //     SizedBox(width: 5.w),
        //         //     dots(const Color(0xFFB6B6B6)),
        //         //     SizedBox(width: 5.w),
        //         //     dots(const Color(0xFFB6B6B6)),
        //         //     SizedBox(width: 5.w),
        //         //     dots(const Color(0xFFB6B6B6)),
        //         //   ],
        //         // ),
        //       ),
        //       SizedBox(height: 5.h),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget intro1() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            height: 20.h,
            width: 30.w,
            child: const Image(
              image: AssetImage("assets/images/set-location-top-left.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
            // height: 40.h,
            // color: Colors.red,
            width: 60.w,
            child: const Image(
              image: AssetImage("assets/images/set-location-top-right.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          top: 15.h,
          left: 10.w,
          child: SizedBox(
            height: 20.h,
            width: 30.w,
            child: const Image(
              image: AssetImage("assets/images/set-location-center-zeera.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: 70.h,
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 15.h),
              SizedBox(
                height: 80.w,
                width: 80.w,
                child: const Image(
                  image: AssetImage(
                      "assets/images/set-location-chicken-plate.png"),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 15,
                width: 100.w,
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     dots(const Color(0xFF941A49)),
                //     SizedBox(width: 5.w),
                //     dots(const Color(0xFFB6B6B6)),
                //     SizedBox(width: 5.w),
                //     dots(const Color(0xFFB6B6B6)),
                //     SizedBox(width: 5.w),
                //     dots(const Color(0xFFB6B6B6)),
                //   ],
                // ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget dots(int value) {
    return Obx(() {
      return Container(
        height: 10,
        width: setLocationController.page.value == value
            ? setLocationController.dotWidth.value.toDouble() * 3
            : setLocationController.dotWidth.value.toDouble(),
        decoration: setLocationController.page.value == value
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFF941A49),
              )
            : const BoxDecoration(
                color: Color(0xFFB6B6B6),
                shape: BoxShape.circle,
              ),
      );
    });
  }
}
