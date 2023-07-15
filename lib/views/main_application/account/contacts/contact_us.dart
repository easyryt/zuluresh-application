import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/button/primary_filled_button.dart';
import 'package:zuluresh/common/button/primary_outlined_button.dart';
import 'package:zuluresh/controllers/update_profile_controller.dart';
import 'package:zuluresh/utils/constants.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(height: AppBar().preferredSize.height),
            SizedBox(
              height: AppBar().preferredSize.height,
              width: 100.w,
              child: Row(
                children: [
                  SizedBox(width: 5.w),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      size: 19.sp,
                      color: const Color(0xFF941A49),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Contact Us",
                        style: GoogleFonts.heebo(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: const Color(0xFF941A49),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 60.w,
                    // color: Colors.grey,
                    child: const Image(
                      image: AssetImage("assets/images/contact-us.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    "Tingling xxxxxxxx?\nThats a Magnetic To Get In Touch With Us.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.heebo(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  InkWell(
                      onTap: () {},
                      child: PrimaryOutlinedButton(
                        icon: Icons.wifi_calling_3,
                        buttonText: "Call",
                        hasIcon: true,
                        width: 30.w,
                      )
                      // Container(
                      //   height: 50,
                      //   width: 30.w,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(color: Constants.primaryColor)
                      //   ),
                      //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.wifi_calling_3,
                      //         color: Constants.primaryColor,
                      //         size: 20.sp,
                      //       ),
                      //       SizedBox(width: 5.w),
                      //       Text(
                      //         "Call",
                      //         textAlign: TextAlign.center,
                      //         style: GoogleFonts.heebo(
                      //           fontSize: 16.sp,
                      //           color: Constants.primaryColor,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
