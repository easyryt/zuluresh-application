import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/button/primary_filled_button.dart';
import 'package:zuluresh/controllers/update_profile_controller.dart';
import 'package:zuluresh/utils/constants.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final UpdateProfileController _updateProfileController =
      Get.put(UpdateProfileController());

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
                  Icon(
                    Icons.arrow_back_ios_new_sharp,
                    size: 19.sp,
                    color: const Color(0xFF941A49),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Update Profile",
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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: .5.h),
                            Text(
                              "At The Following Details Are Mandatory",
                              style: GoogleFonts.heebo(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(height: 2.5.h),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      cursorColor: Constants.primaryColor,
                                      decoration: InputDecoration(
                                        labelText: "First Name",
                                        labelStyle: GoogleFonts.heebo(
                                            color: Constants.lightTextColor),
                                        floatingLabelStyle: GoogleFonts.heebo(
                                            color: Constants.primaryColor),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      cursorColor: Constants.primaryColor,
                                      decoration: InputDecoration(
                                        labelText: "Last Name",
                                        labelStyle: GoogleFonts.heebo(
                                            color: Constants.lightTextColor),
                                        floatingLabelStyle: GoogleFonts.heebo(
                                            color: Constants.primaryColor),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.5.h),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                cursorColor: Constants.primaryColor,
                                decoration: InputDecoration(
                                  labelText: "Phone Number",
                                  labelStyle: GoogleFonts.heebo(
                                      color: Constants.lightTextColor),
                                  floatingLabelStyle: GoogleFonts.heebo(
                                      color: Constants.primaryColor),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.5.h),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                cursorColor: Constants.primaryColor,
                                decoration: InputDecoration(
                                  labelText: "Email ID",
                                  labelStyle: GoogleFonts.heebo(
                                      color: Constants.lightTextColor),
                                  floatingLabelStyle: GoogleFonts.heebo(
                                      color: Constants.primaryColor),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.5.h),
                            Text(
                              "Gender",
                              style: GoogleFonts.heebo(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(() {
                                    return InkWell(
                                      onTap: () {
                                        _updateProfileController.gender.value =
                                            0;
                                      },
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color:
                                                      Constants.primaryColor),
                                            ),
                                            child: _updateProfileController
                                                        .gender.value ==
                                                    0
                                                ? Center(
                                                    child: Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        color: Constants
                                                            .primaryColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ),
                                          SizedBox(width: 2.5.w),
                                          Text(
                                            "Male",
                                            style: GoogleFonts.heebo(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                                Expanded(
                                  child: Obx(() {
                                    return InkWell(
                                      onTap: () {
                                        _updateProfileController.gender.value =
                                            1;
                                      },
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color:
                                                      Constants.primaryColor),
                                            ),
                                            child: _updateProfileController
                                                        .gender.value ==
                                                    1
                                                ? Center(
                                                    child: Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        color: Constants
                                                            .primaryColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ),
                                          SizedBox(width: 2.5.w),
                                          Text(
                                            "Female",
                                            style: GoogleFonts.heebo(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                                Expanded(
                                  child: Obx(() {
                                    return InkWell(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      onTap: () {
                                        _updateProfileController.gender.value =
                                            2;
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color:
                                                      Constants.primaryColor),
                                            ),
                                            child: _updateProfileController
                                                        .gender.value ==
                                                    2
                                                ? Center(
                                                    child: Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        color: Constants
                                                            .primaryColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ),
                                          SizedBox(width: 2.5.w),
                                          Text(
                                            "Other",
                                            style: GoogleFonts.heebo(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.5.h),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Get.to(() => const ChooseLocation());
                      },
                      child: PrimaryFilledButton(
                        width: 90.w,
                        buttonText: "Update",
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
