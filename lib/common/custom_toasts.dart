import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miladtech_flutter_icons/miladtech_flutter_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/utils/constants.dart';

import '../services/global.dart';
import '../views/main_application/main_home.dart';

class CustomToasts {

  static void showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(minutes: 20),
      ),
    );
  }

  static void errorToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        // margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              AntDesign.warning,
              color: Constants.primaryColor,
              size: 18.sp,
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.heebo(
                  fontSize: 17.sp,
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static void successToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              AntDesign.check,
              color: Colors.green,
              size: 18.sp,
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.heebo(
                  fontSize: 17.sp,
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static Widget viewCartBanner(int count){
    final MainApplicationController mainApplicationController = Get.find();

    return Obx(() {
      return SizedBox(
        child: Global.storageServices.getString("x-auth-token") !=
            null
            ? mainApplicationController.cartItems.isNotEmpty
            ? Container(
          width: 90.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$count Items in Cart",
                style: GoogleFonts.heebo(
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              InkWell(
                onTap: () {
                  mainApplicationController.pageIdx.value = 2;
                  Get.to(() => const MainHomeScreen());
                },
                child: Text(
                  "View Cart",
                  style: GoogleFonts.heebo(
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )
            : const SizedBox()
            : mainApplicationController.cartItems.isNotEmpty
            ? Container(
          width: 90.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Items in Cart",
                style: GoogleFonts.heebo(
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              InkWell(
                onTap: () {
                  mainApplicationController.pageIdx.value = 2;
                  Get.to(() => const MainHomeScreen());
                },
                child: Text(
                  "View Cart",
                  style: GoogleFonts.heebo(
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )
            : const SizedBox(),
      );
    });
  }
}
