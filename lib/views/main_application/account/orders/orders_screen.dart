import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/models/single_order_model.dart';
import 'package:zuluresh/models/success_order_model.dart';
import 'package:zuluresh/views/main_application/create_order/order_detail_screen.dart';

import '../../../../controllers/main_application_controller.dart';
import '../../../../utils/constants.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final MainApplicationController _mainApplicationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "Orders",
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
              child: FutureBuilder<List<SingleOrderModel>>(
                future: _mainApplicationController.getAllOrdersList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        reverse: true,
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            DateTime orderDate = _mainApplicationController
                                .getTimeFromDateTimeStamp(
                                    snapshot.data![index].updatedAt!);
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => OrderDetailScreen(
                                        orderSuccess: false,
                                        successOrderData: SuccessOrderModel(
                                          sId: snapshot.data![index].sId,
                                        )));
                                  },
                                  child: Container(
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          offset: const Offset(0, 0),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 1.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5.w),
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/set-location-intro3-plate.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2.5.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data![index].orderId!,
                                                    style: GoogleFonts.heebo(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${snapshot.data![index].totalItems.toString()} items",
                                                    style: GoogleFonts.heebo(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.currency_rupee,
                                                        color: Colors.black,
                                                        size: 17.sp,
                                                      ),
                                                      Text(
                                                        snapshot.data![index]
                                                            .totalPrice
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.heebo(
                                                          color: Colors.black,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3.w),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: snapshot.data![index]
                                                                .orderStatus!
                                                                .toLowerCase() ==
                                                            "delivered"
                                                        ? Colors.green
                                                        : snapshot.data![index]
                                                                    .orderStatus!
                                                                    .toLowerCase() ==
                                                                "processing"
                                                            ? Colors.orange
                                                            : Colors.black54,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Center(
                                                child: Text(
                                                  snapshot.data![index]
                                                      .orderStatus!,
                                                  style: GoogleFonts.heebo(
                                                    color: snapshot.data![index]
                                                                .orderStatus!
                                                                .toLowerCase() ==
                                                            "delivered"
                                                        ? Colors.green
                                                        : snapshot.data![index]
                                                                    .orderStatus!
                                                                    .toLowerCase() ==
                                                                "processing"
                                                            ? Colors.orange
                                                            : Colors.black54,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Divider(
                                          height: 3.h,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Order Date",
                                                    style: GoogleFonts.heebo(
                                                      fontSize: 15.5.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${orderDate.day}-${orderDate.month}-${orderDate.year} ${orderDate.hour.toString().padLeft(2, '0')}:${orderDate.minute.toString().padLeft(2, '0')} ${orderDate.hour < 12 ? "AM" : "PM"}",
                                                    style: GoogleFonts.heebo(
                                                      fontSize: 14.sp,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Delivery Date",
                                                    style: GoogleFonts.heebo(
                                                      fontSize: 15.5.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data![index]
                                                        .shippingInfo!
                                                        .deliverySlot!
                                                        .day!,
                                                    style: GoogleFonts.heebo(
                                                      fontSize: 14.sp,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: 50.w,
                                            //   child: Row(
                                            //     children: [
                                            //       Icon(
                                            //         Icons.currency_rupee,
                                            //         color: Constants.primaryColor,
                                            //         size: 18.sp,
                                            //       ),
                                            //       Text(
                                            //         "900",
                                            //         style: GoogleFonts.heebo(
                                            //           fontSize: 18.sp,
                                            //           color: Constants.primaryColor,
                                            //           fontWeight: FontWeight.bold,
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.5.h),
                              ],
                            );
                          });
                    } else {
                      Center(
                        child: Text(
                          "No any Orders Yet..",
                          style: GoogleFonts.heebo(
                            color: Constants.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
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
            ),
          ],
        ),
      ),
    );
  }
}
