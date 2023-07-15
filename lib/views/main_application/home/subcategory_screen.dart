import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/controllers/subcategory/subcategory_controller.dart';
import 'package:zuluresh/models/subcategory_model.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/main_application/home/subcategory_items_screen.dart';

class SubCategoryScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const SubCategoryScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final SubCategoryController _subCategoryController =
      Get.put(SubCategoryController());

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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.5.w),
              height: AppBar().preferredSize.height,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Constants.primaryColor,
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Chicken",
                    style: GoogleFonts.heebo(
                      color: Constants.primaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 1.5.w, color: Colors.grey.shade50),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 100.h - (AppBar().preferredSize.height * 2) - 1.5.w,
                    child: Column(
                      children: [
                        InkWell(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () {
                            _subCategoryController.subCategoryName.value =
                                "all";
                            _subCategoryController.selectedCategory.value = 0;
                          },
                          child: Obx(() {
                            return Column(
                              children: [
                                Container(
                                  height: 20.w,
                                  width: 20.w,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: _subCategoryController
                                                  .selectedCategory.value ==
                                              0
                                          ? 2.5.w
                                          : 5.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: _subCategoryController
                                                    .selectedCategory.value ==
                                                0
                                            ? Constants.primaryColor
                                            : Colors.transparent),
                                    shape: BoxShape.circle,
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/set-location-intro3-plate.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  "All",
                                  style: GoogleFonts.heebo(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: _subCategoryController
                                                .selectedCategory.value ==
                                            0
                                        ? Constants.primaryColor
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        Expanded(
                          child: FutureBuilder<List<SubCategoryModel>>(
                            future: _subCategoryController
                                .getAllSubCategoryList(widget.categoryId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1.w),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Obx(() {
                                        return InkWell(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          onTap: () {
                                            _subCategoryController
                                                .selectedCategory
                                                .value = index + 1;
                                            _subCategoryController
                                                    .subCategoryName.value =
                                                snapshot.data![index]
                                                    .subCategoryName!;
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(height: 2.h),
                                              Container(
                                                height: 25.w,
                                                width: 25.w,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                        _subCategoryController
                                                                    .selectedCategory
                                                                    .value ==
                                                                index + 1
                                                            ? 2.5.w
                                                            : 5.w),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 4,
                                                      color: _subCategoryController
                                                                  .selectedCategory
                                                                  .value ==
                                                              index + 1
                                                          ? Constants
                                                              .primaryColor
                                                          : Colors.transparent),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data![index]
                                                        .subCategoryImg!
                                                        .url!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                snapshot.data![index]
                                                    .subCategoryName!,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: GoogleFonts.heebo(
                                                  fontSize: 16.sp,
                                                  color: _subCategoryController
                                                              .selectedCategory
                                                              .value ==
                                                          index + 1
                                                      ? Constants.primaryColor
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    });
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade50,
                    width: 1.5.w,
                    height: 100.h - (AppBar().preferredSize.height * 2) - 1.5.w,
                  ),
                  SizedBox(
                    width: 78.5.w,
                    height: 100.h - (AppBar().preferredSize.height * 2) - 1.5.w,
                    child: Obx(() {
                      return SubCategoryItemScreen(
                        subCategoryName:
                            _subCategoryController.subCategoryName.value,
                        categoryName: widget.categoryName,
                        back: false,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
