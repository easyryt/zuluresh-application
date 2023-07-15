import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/controllers/subcategory/subcategory_controller.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/main_application/home/subcategory_items_screen.dart';

import '../../../models/category_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final MainApplicationController _mainApplicationController = Get.find();
  final SubCategoryController _subCategoryController =
      Get.put(SubCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            Container(height: AppBar().preferredSize.height),
            Text(
              "All Categories",
              style: GoogleFonts.heebo(
                color: Colors.black,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.5.h),
            Expanded(
              child: FutureBuilder<List<CategoryModel>>(
                  future: _mainApplicationController.getAllCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              shape: const Border(),
                              tilePadding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: .5.h),
                              childrenPadding:
                                  EdgeInsets.symmetric(horizontal: 5.w),
                              leading: Image(
                                image: NetworkImage(
                                    snapshot.data![index].categoryImg!.url!),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].categoryName!,
                                    style: GoogleFonts.heebo(
                                      color: Colors.black,
                                      fontSize: 17.5.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'Great deals on fresh meats & more',
                                    style: GoogleFonts.heebo(
                                      color: Colors.black38,
                                      fontSize: 14.5.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                FutureBuilder(
                                  future: _subCategoryController
                                      .getAllSubCategoryList(
                                          snapshot.data![index].sId!),
                                  builder: (context, inSnapshot) {
                                    if (inSnapshot.hasData) {
                                      return SizedBox(
                                        height:
                                            ((snapshot.data!.length / 3) + 1) *
                                                19.w,
                                        child: GridView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.w),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 0.w,
                                            mainAxisSpacing: 0.w,
                                          ),
                                          children: List.generate(
                                              snapshot.data!.length, (inIndex) {
                                            return InkWell(
                                              overlayColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent),
                                              onTap: () {
                                                Get.to(() =>
                                                    SubCategoryItemScreen(
                                                        subCategoryName:
                                                            inSnapshot
                                                                .data![inIndex]
                                                                .subCategoryName!,
                                                        categoryName: snapshot
                                                            .data![index]
                                                            .categoryName!, back: true));
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 14.w,
                                                    // padding:
                                                    //     const EdgeInsets.all(5),
                                                    width: 15.w,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red,
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          inSnapshot
                                                              .data![inIndex]
                                                              .subCategoryImg!
                                                              .url!,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    inSnapshot.data![inIndex]
                                                        .subCategoryName!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                      // return Column(
                                      //   children: [
                                      //     Container(
                                      //       height: 20.w,
                                      //       width: 20.w,
                                      //       decoration: const BoxDecoration(
                                      //         shape: BoxShape.circle,
                                      //         image: DecorationImage(
                                      //           image: AssetImage(
                                      //               "assets/images/set-location-intro3-plate.png"),
                                      //           fit: BoxFit.cover,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     Text(
                                      //       inSnapshot.data![index].subCategoryName!,
                                      //       style: GoogleFonts.heebo(
                                      //         fontSize: 16.sp,
                                      //         fontWeight: FontWeight.w500,
                                      //         color: Constants.primaryColor,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // );
                                    }
                                    return Text("data");
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Constants.primaryColor,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
