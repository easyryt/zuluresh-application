import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miladtech_flutter_icons/miladtech_flutter_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/button/primary_outlined_button.dart';
import 'package:zuluresh/controllers/subcategory/subcategory_controller.dart';
import 'package:zuluresh/models/single_product_model.dart';
import 'package:zuluresh/utils/constants.dart';

class SubCategoryItemScreen extends StatefulWidget {
  final String subCategoryName;
  final String categoryName;
  final bool back;

  const SubCategoryItemScreen({
    super.key,
    required this.subCategoryName,
    required this.categoryName,
    required this.back,
  });

  @override
  State<SubCategoryItemScreen> createState() => _SubCategoryItemScreenState();
}

class _SubCategoryItemScreenState extends State<SubCategoryItemScreen> {
  final SubCategoryController _subCategoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: widget.back
            ? Column(
                children: [
                  SizedBox(height: AppBar().preferredSize.height),
                  SizedBox(
                    height: AppBar().preferredSize.height,
                    width: 100.w,
                    child: Row(
                      children: [
                        SizedBox(width: 5.w),
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
                              "${widget.categoryName} - ${widget.subCategoryName}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.heebo(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                                color: const Color(0xFF941A49),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                      ],
                    ),
                  ),
                  Expanded(child: listData()),
                ],
              )
            : Obx(() {
                return listData();
              }),
      ),
    );
  }

  Widget listData() {
    return FutureBuilder<List<SingleProductModel>>(
      future: _subCategoryController.getSubCategoryProductList(
        widget.categoryName,
        _subCategoryController.subCategoryName.value,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 2.5.h),
                    Container(
                      width: 100.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.5.w, vertical: 2.5.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1.5.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: const Offset(0, 0),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.w),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.5.w),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data![0].productImg![0].url!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            snapshot.data![0].title!,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.heebo(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            snapshot.data![0].pieces.toString(),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.heebo(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    color: Constants.primaryColor,
                                    size: 16.sp,
                                  ),
                                  Text(
                                    snapshot.data![0].mRP!.toString(),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.heebo(
                                      color: Constants.primaryColor,
                                      fontSize: 16.5.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1.w),
                                  border:
                                      Border.all(color: Constants.primaryColor),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Center(
                                  child: Text(
                                    "Add",
                                    style: GoogleFonts.heebo(
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
