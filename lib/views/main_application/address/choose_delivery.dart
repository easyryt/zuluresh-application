import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/button/primary_filled_button.dart';
import 'package:zuluresh/common/custom_toasts.dart';
import 'package:zuluresh/controllers/address/choose_delivery_controller.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/models/single_address_model.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:zuluresh/views/main_application/address/select_address.dart';

import '../../../models/single_time_slot_model.dart';
import '../create_order/payment.dart';

class ChooseDeliveryScreen extends StatefulWidget {
  const ChooseDeliveryScreen({super.key});

  @override
  State<ChooseDeliveryScreen> createState() => _ChooseDeliveryScreenState();
}

class _ChooseDeliveryScreenState extends State<ChooseDeliveryScreen> {
  final MainApplicationController _mainApplicationController = Get.find();
  final ChooseDeliveryController _chooseDeliveryController =
  Get.put(ChooseDeliveryController());

  bool selectedAddress = false;

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
                        "Delivery",
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
                    child:
                    // SingleChildScrollView(
                    //   child: FutureBuilder<Dio>(
                    //     itemCount: 90,
                    //     itembuilder:(context, snapshot){
                    //       return Container(
                    //         width: 90.w,
                    //         decoration: BoxDecoration(
                    //           border: DashedBorder.fromBorderSide(
                    //             dashLength: 10,
                    //             side: BorderSide(
                    //                 color: Constants.primaryColor, width: 1),
                    //           ),
                    //           borderRadius: BorderRadius.circular(9),
                    //           // border: Border.all(color: const Color(0xFF941A49)),
                    //         ),
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: 5.w, vertical: 1.h),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             SizedBox(height: 1.h),
                    //             Row(
                    //               mainAxisAlignment:
                    //               MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     Icon(
                    //                       Icons.location_on,
                    //                       color: Constants.primaryColor,
                    //                       size: 20.sp,
                    //                     ),
                    //                     Text(
                    //                       "Home",
                    //                       style: GoogleFonts.heebo(
                    //                         fontSize: 17.sp,
                    //                         fontWeight: FontWeight.w500,
                    //                         color: Constants.primaryColor,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 InkWell(
                    //                   onTap: (){
                    //                     Get.to(()=> const SelectAddressScreen());
                    //                   },
                    //                   child: Text(
                    //                     "Change",
                    //                     style: GoogleFonts.heebo(
                    //                       fontSize: 15.sp,
                    //                       fontWeight: FontWeight.w400,
                    //                       color: Constants.primaryColor,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             SizedBox(height: 1.h),
                    //             Text(
                    //               "Irfan\nSadar Bazar, xxxxxxxxx\nDelhi - 65008 ",
                    //               style: GoogleFonts.heebo(
                    //                 fontSize: 15.sp,
                    //                 color: Constants.lightTextColor,
                    //               ),
                    //             ),
                    //             SizedBox(height: 1.h),
                    //           ],
                    //         ),
                    //       );
                    //     }
                    //   ),
                    // )
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2.5.h),
                            Container(
                              width: 90.w,
                              decoration: BoxDecoration(
                                border: DashedBorder.fromBorderSide(
                                  dashLength: 10,
                                  side: BorderSide(
                                      color: Constants.primaryColor, width: 1),
                                ),
                                borderRadius: BorderRadius.circular(9),
                                // border: Border.all(color: const Color(0xFF941A49)),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 1.h),
                              child: FutureBuilder(
                                  future: _mainApplicationController
                                      .getUserAllAddresses(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.isNotEmpty) {
                                        selectedAddress = true;

                                        if (snapshot.data!.length == 1) {
                                          _mainApplicationController
                                              .selectedAddressId.value =
                                          snapshot.data![0].sId!;
                                          return Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 1.h),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Constants
                                                            .primaryColor,
                                                        size: 20.sp,
                                                      ),
                                                      Text(
                                                        snapshot.data![0]
                                                            .saveAddressAs!,
                                                        style:
                                                        GoogleFonts.heebo(
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: Constants
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(() =>
                                                      const SelectAddressScreen());
                                                    },
                                                    child: Text(
                                                      "Change",
                                                      style: GoogleFonts.heebo(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        color: Constants
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 1.h),
                                              Text(
                                                "${snapshot.data![0]
                                                    .houseFlatNo}, ${snapshot
                                                    .data![0].blockName}",
                                                style: GoogleFonts.heebo(
                                                  fontSize: 15.sp,
                                                  color:
                                                  Constants.lightTextColor,
                                                ),
                                              ),
                                              Text(
                                                "${snapshot.data![0]
                                                    .street} - ${snapshot
                                                    .data![0].landMark}",
                                                style: GoogleFonts.heebo(
                                                  fontSize: 15.sp,
                                                  color:
                                                  Constants.lightTextColor,
                                                ),
                                              ),
                                              Text(
                                                "${snapshot.data![0]
                                                    .locality} - ${snapshot
                                                    .data![0].pinCode}",
                                                style: GoogleFonts.heebo(
                                                  fontSize: 15.sp,
                                                  color:
                                                  Constants.lightTextColor,
                                                ),
                                              ),
                                              Text(
                                                "+91 ${snapshot.data![0]
                                                    .phoneNo!}",
                                                style: GoogleFonts.heebo(
                                                  fontSize: 15.sp,
                                                  color:
                                                  Constants.lightTextColor,
                                                ),
                                              ),
                                              SizedBox(height: 1.h),
                                            ],
                                          );
                                        } else {
                                          SingleAddressModel data =
                                          SingleAddressModel();
                                          for (var item in snapshot.data!) {
                                            if (item.setAsDefault!) {
                                              data = item;
                                              _mainApplicationController
                                                  .selectedAddressId.value =
                                              data.sId!;
                                            }
                                          }

                                          for (var item in snapshot.data!) {
                                            if (item.sId ==
                                                _mainApplicationController
                                                    .selectedAddressId.value) {
                                              data = item;
                                              _mainApplicationController.selectedAddressData.value = item;
                                            }
                                          }

                                          return Obx(() {
                                            return Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 1.h),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          color: Constants
                                                              .primaryColor,
                                                          size: 20.sp,
                                                        ),
                                                        Text(
                                                          _mainApplicationController.selectedAddressData.value.saveAddressAs!,
                                                          // snapshot.data![0]
                                                          //     .saveAddressAs!,
                                                          style:
                                                          GoogleFonts.heebo(
                                                            fontSize: 17.sp,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            color: Constants
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Get.to(() =>
                                                        const SelectAddressScreen());
                                                      },
                                                      child: Text(
                                                        "Change",
                                                        style: GoogleFonts
                                                            .heebo(
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          color: Constants
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 1.h),
                                                Text(
                                                  "${_mainApplicationController.selectedAddressData.value.houseFlatNo}, ${_mainApplicationController.selectedAddressData.value
                                                      .blockName}",
                                                  style: GoogleFonts.heebo(
                                                    fontSize: 15.sp,
                                                    color:
                                                    Constants.lightTextColor,
                                                  ),
                                                ),
                                                Text(
                                                  "${_mainApplicationController.selectedAddressData.value.street} - ${_mainApplicationController.selectedAddressData.value
                                                      .landMark}",
                                                  style: GoogleFonts.heebo(
                                                    fontSize: 15.sp,
                                                    color:
                                                    Constants.lightTextColor,
                                                  ),
                                                ),
                                                Text(
                                                  "${_mainApplicationController.selectedAddressData.value.locality} - ${_mainApplicationController.selectedAddressData.value
                                                      .pinCode}",
                                                  style: GoogleFonts.heebo(
                                                    fontSize: 15.sp,
                                                    color:
                                                    Constants.lightTextColor,
                                                  ),
                                                ),
                                                Text(
                                                  "+91 ${_mainApplicationController.selectedAddressData.value.phoneNo!}",
                                                  style: GoogleFonts.heebo(
                                                    fontSize: 15.sp,
                                                    color:
                                                    Constants.lightTextColor,
                                                  ),
                                                ),
                                                SizedBox(height: 1.h),
                                              ],
                                            );
                                          });
                                        }
                                      } else {
                                        selectedAddress = false;
                                        return Column(
                                          children: [
                                            Text(
                                              "No Address is available.\n Add new address using below button.",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.heebo(
                                                color: Constants.primaryColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 2.5.h),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                const SelectAddressScreen());
                                              },
                                              child: PrimaryFilledButton(
                                                width: 90.w,
                                                buttonText: "All Addresses",
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Constants.primaryColor,
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(height: 2.5.h),
                            Text(
                              "Available Delivery Slots",
                              style: GoogleFonts.heebo(
                                color: Constants.primaryColor,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 2.5.h),
                            Obx(() {
                              return ExpansionTile(
                                title: const Text("Choose time"),
                                shape: const Border(),
                                childrenPadding:
                                EdgeInsets.symmetric(horizontal: 5.w),
                                backgroundColor: Colors.white,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        tabs("Today", 0),
                                        tabs("Tomorrow", 1),
                                        tabs("${DateTime
                                            .now()
                                            .day + 2} June", 2),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2.5.h),
                                  FutureBuilder<List<SingleTimeSlotModel>>(
                                      future: _mainApplicationController
                                          .getAllTimeSlots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          _mainApplicationController
                                              .refineDataListByDate(
                                              snapshot.data!);
                                          return Column(
                                            children: [
                                              _mainApplicationController
                                                  .selectedDeliveryDate
                                                  .value ==
                                                  0
                                                  ? buildTimeSlotTime(
                                                  _mainApplicationController
                                                      .todayTimeSlots)
                                                  : const SizedBox(),
                                              _mainApplicationController
                                                  .selectedDeliveryDate
                                                  .value ==
                                                  1
                                                  ? buildTimeSlotTime(
                                                  _mainApplicationController
                                                      .tomorrowTimeSlots)
                                                  : const SizedBox(),
                                              _mainApplicationController
                                                  .selectedDeliveryDate
                                                  .value ==
                                                  2
                                                  ? buildTimeSlotTime(
                                                  _mainApplicationController
                                                      .nextDayTimeSlots)
                                                  : const SizedBox(),
                                            ],
                                          );
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: Constants.primaryColor,
                                          ),
                                        );
                                      }),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_mainApplicationController.selectedDeliveryTime.sId ==
                          null ||
                          selectedAddress == false) {
                        if (_mainApplicationController
                            .selectedDeliveryTime.sId ==
                            null) {
                          CustomToasts.errorToast(
                              context, "Choose Time Slot..");
                        } else {
                          CustomToasts.errorToast(
                              context, "Add or Select Address..");
                        }
                      } else {
                        Get.to(() => const PaymentScreen());
                      }
                    },
                    child: PrimaryFilledButton(
                      buttonText: "Make Payment",
                      width: 90.w,
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

  Widget buildTimeSlotTime(List<SingleTimeSlotModel> data) {
    if (data.isNotEmpty) {
      return SizedBox(
        height: ((50 + 2.h) * data.length).toDouble(),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Obx(() {
                    return InkWell(
                      onTap: () {
                        _chooseDeliveryController
                            .selectedDeliveryTimeIndex.value = index;
                        _mainApplicationController.selectedDeliveryTime =
                        data[index];
                      },
                      child: Container(
                        height: 45,
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Constants.primaryColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(2.w),
                          color: _chooseDeliveryController
                              .selectedDeliveryTimeIndex.value ==
                              index
                              ? Constants.primaryColor
                              : Colors.white,
                        ),
                        child: Text(
                          "${data[index].startTime} - ${data[index].endTime}",
                          style: GoogleFonts.heebo(
                            color: _chooseDeliveryController
                                .selectedDeliveryTimeIndex.value ==
                                index
                                ? Colors.white
                                : Constants.primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 1.5.h),
                ],
              );
            }),
      );
    } else {
      return Center(
        child: Text(
          "No any delivery is possible",
          style: GoogleFonts.heebo(
            color: Colors.black,
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  }

  Widget tabs(String date, int index) {
    return InkWell(
      onTap: () {
        _mainApplicationController.selectedDeliveryDate.value = index;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.5.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: Constants.primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(2.w),
          color: _mainApplicationController.selectedDeliveryDate.value == index
              ? Constants.primaryColor
              : Colors.white,
        ),
        child: Center(
          child: Text(
            date,
            style: GoogleFonts.heebo(
              color:
              _mainApplicationController.selectedDeliveryDate.value == index
                  ? Colors.white
                  : Constants.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
