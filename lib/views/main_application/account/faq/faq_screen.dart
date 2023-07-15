import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/utils/constants.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppBar().preferredSize.height),
            Container(
              height: AppBar().preferredSize.height,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              width: 100.w,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
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
                        "FAQs",
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        "Frequent Asked Questions",
                        style: GoogleFonts.heebo(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    faqTile("What are the benefits?",
                        "Employee benefits and benefits in kind include various types of non-wage compensation provided to employees in addition to their normal wages or salaries. Instances where an employee exchanges wages for some other form of benefit is generally referred to as a salary packaging or salary exchange arrangement."),
                    faqTile("What are the benefits?",
                        "Employee benefits and benefits in kind include various types of non-wage compensation provided to employees in addition to their normal wages or salaries. Instances where an employee exchanges wages for some other form of benefit is generally referred to as a salary packaging or salary exchange arrangement."),
                    faqTile("What are the benefits?",
                        "Employee benefits and benefits in kind include various types of non-wage compensation provided to employees in addition to their normal wages or salaries. Instances where an employee exchanges wages for some other form of benefit is generally referred to as a salary packaging or salary exchange arrangement.")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget faqTile(String title, String description) {
    return ExpansionTile(
      shape: const Border(),
      iconColor: Constants.primaryColor,
      collapsedIconColor: Constants.primaryColor,
      backgroundColor: Constants.primaryColor.withOpacity(0.2),
      tilePadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: .5.h),
      childrenPadding: EdgeInsets.symmetric(horizontal: 5.w),
      title: Text(
        title,
        style: GoogleFonts.heebo(
          color: Constants.primaryColor,
          fontSize: 17.5.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Container(
          width: 80.w,
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Text(
            description,
            textAlign: TextAlign.justify,
            style: GoogleFonts.heebo(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}
