import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/button/primary_filled_button.dart';
import 'package:zuluresh/common/button/primary_outlined_button.dart';
import 'package:zuluresh/common/custom_toasts.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/models/single_address_model.dart';
import 'package:zuluresh/services/global.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/main_application/address/update_edit_address.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  final MainApplicationController _mainApplicationController = Get.find();

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
                        "Address",
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
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 1.5.h),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: FutureBuilder<List<SingleAddressModel>>(
                            future: _mainApplicationController
                                .getUserAllAddresses(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.isNotEmpty) {
                                  final int defaultIndex = snapshot.data!
                                      .indexWhere(
                                          (item) => item.setAsDefault == true);
                                  _mainApplicationController
                                      .selectedAddress.value = defaultIndex;
                                  _mainApplicationController
                                          .selectedAddressId.value =
                                      snapshot.data![defaultIndex].sId!;
                                  return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Obx(() {
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _mainApplicationController
                                                      .selectedAddress
                                                      .value = index;
                                                  _mainApplicationController
                                                          .selectedAddressId
                                                          .value =
                                                      snapshot
                                                          .data![index].sId!;
                                                  _mainApplicationController
                                                          .selectedAddressData
                                                          .value =
                                                      snapshot.data![index];
                                                },
                                                child: Container(
                                                  width: 90.w,
                                                  decoration: BoxDecoration(
                                                    color: _mainApplicationController
                                                                .selectedAddress
                                                                .value ==
                                                            index
                                                        ? Constants.primaryColor
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFF941A49)),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5.w,
                                                      vertical: 1.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: 1.h),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            color: _mainApplicationController
                                                                        .selectedAddress
                                                                        .value ==
                                                                    index
                                                                ? Colors.white
                                                                : Constants
                                                                    .primaryColor,
                                                            size: 20.sp,
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .data![index]
                                                                .saveAddressAs!,
                                                            style: GoogleFonts
                                                                .heebo(
                                                              fontSize: 17.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: _mainApplicationController
                                                                          .selectedAddress
                                                                          .value ==
                                                                      index
                                                                  ? Colors.white
                                                                  : Constants
                                                                      .primaryColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Text(
                                                        "${snapshot.data![index].name}",
                                                        style:
                                                            GoogleFonts.heebo(
                                                          fontSize: 15.sp,
                                                          color: _mainApplicationController
                                                                      .selectedAddress
                                                                      .value ==
                                                                  index
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${snapshot.data![index].houseFlatNo} - ${snapshot.data![index].blockName} ${snapshot.data![index].street}",
                                                        style:
                                                            GoogleFonts.heebo(
                                                          fontSize: 15.sp,
                                                          color: _mainApplicationController
                                                                      .selectedAddress
                                                                      .value ==
                                                                  index
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${snapshot.data![index].locality} - ${snapshot.data![index].pinCode}",
                                                        style:
                                                            GoogleFonts.heebo(
                                                          fontSize: 15.sp,
                                                          color: _mainApplicationController
                                                                      .selectedAddress
                                                                      .value ==
                                                                  index
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        "+91 ${snapshot.data![index].phoneNo}",
                                                        style:
                                                            GoogleFonts.heebo(
                                                          fontSize: 15.sp,
                                                          color: _mainApplicationController
                                                                      .selectedAddress
                                                                      .value ==
                                                                  index
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                      Divider(height: 4.h),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              if (await _mainApplicationController
                                                                  .deleteAddress(snapshot
                                                                      .data![
                                                                          index]
                                                                      .sId!)) {
                                                                if (mounted) {
                                                                  CustomToasts
                                                                      .successToast(
                                                                          context,
                                                                          "Address deleted Successfully..");
                                                                }
                                                              } else {
                                                                if (mounted) {
                                                                  CustomToasts
                                                                      .successToast(
                                                                          context,
                                                                          "Unable to delete address for now. Try again later...");
                                                                }
                                                              }
                                                              setState(() {});
                                                            },
                                                            child: Text(
                                                              "Delete",
                                                              style: GoogleFonts
                                                                  .heebo(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: _mainApplicationController
                                                                            .selectedAddress
                                                                            .value ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                    : Constants
                                                                        .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            overlayColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .transparent),
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  EditAddressScreen(
                                                                    update:
                                                                        true,
                                                                    id: snapshot.data![index].sId!,
                                                                  ));
                                                            },
                                                            child: Text(
                                                              "Edit",
                                                              style: GoogleFonts
                                                                  .heebo(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: _mainApplicationController
                                                                            .selectedAddress
                                                                            .value ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                    : Constants
                                                                        .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 1.h),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 1.5.h),
                                            ],
                                          );
                                        });
                                      });
                                } else {
                                  return Center(
                                    child: Text(
                                      "No any Saved Address. Add New..",
                                      style: GoogleFonts.heebo(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color: Constants.primaryColor,
                                      ),
                                    ),
                                  );
                                }
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Constants.primaryColor,
                                ),
                              );
                            },
                          ),
                        )),
                        // Container(
                        //   width: 90.w,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(9),
                        //     border: Border.all(color: const Color(0xFF941A49)),
                        //   ),
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 5.w, vertical: 1.h),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       SizedBox(height: 1.h),
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Row(
                        //             children: [
                        //               Icon(
                        //                 Icons.location_on,
                        //                 color: Constants.primaryColor,
                        //                 size: 20.sp,
                        //               ),
                        //               Text(
                        //                 "Home",
                        //                 style: GoogleFonts.heebo(
                        //                   fontSize: 17.sp,
                        //                   fontWeight: FontWeight.w500,
                        //                   color: Constants.primaryColor,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           Text(
                        //             "Change",
                        //             style: GoogleFonts.heebo(
                        //               fontSize: 15.sp,
                        //               fontWeight: FontWeight.w400,
                        //               color: Constants.primaryColor,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(height: 1.h),
                        //       Text(
                        //         "Irfan\nSadar Bazar, xxxxxxxxx\nDelhi - 65008 ",
                        //         style: GoogleFonts.heebo(
                        //           fontSize: 15.sp,
                        //           color: Constants.lightTextColor,
                        //         ),
                        //       ),
                        //       Divider(height: 4.h),
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             "Delete",
                        //             style: GoogleFonts.heebo(
                        //               fontSize: 16.sp,
                        //               fontWeight: FontWeight.w500,
                        //               color: Constants.primaryColor,
                        //             ),
                        //           ),
                        //           InkWell(
                        //             overlayColor: MaterialStateProperty.all(
                        //                 Colors.transparent),
                        //             onTap: () {
                        //               Get.to(() => const EditAddressScreen(
                        //                   update: true));
                        //             },
                        //             child: Text(
                        //               "Edit",
                        //               style: GoogleFonts.heebo(
                        //                 fontSize: 15.sp,
                        //                 fontWeight: FontWeight.w400,
                        //                 color: Constants.primaryColor,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(height: 1.h),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 2.5.h),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              Get.to(() => const EditAddressScreen(
                                    update: false,
                                    id: "",
                                  ));
                            },
                            child: PrimaryOutlinedButton(
                              buttonText: "New Address",
                              width: 90.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.5.w),
                        Expanded(
                          child: InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              Get.back();
                            },
                            child: PrimaryFilledButton(
                              buttonText: "Continue",
                              width: 90.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
