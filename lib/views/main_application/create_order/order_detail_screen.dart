import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/models/order_details_model.dart';
import 'package:zuluresh/models/success_order_model.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/main_application/main_home.dart';

class OrderDetailScreen extends StatefulWidget {
  final bool orderSuccess;
  final SuccessOrderModel successOrderData;

  const OrderDetailScreen({
    super.key,
    required this.orderSuccess,
    required this.successOrderData,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final MainApplicationController _mainApplicationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: AppBar().preferredSize.height),
            SizedBox(
              height: AppBar().preferredSize.height,
              width: 100.w,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (widget.orderSuccess) {
                        Get.offAll(() => const MainHomeScreen());
                      } else {
                        Get.back();
                      }
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
                        "Order Details",
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
              child: FutureBuilder<OrderDetailsModel>(
                  future: _mainApplicationController
                      .getOderDetails(widget.successOrderData.sId!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "# ${snapshot.data!.orderId!}",
                                style: GoogleFonts.heebo(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                snapshot.data!.orderStatus!,
                                style: GoogleFonts.heebo(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.5.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            snapshot.data!.address!.deliverySlot!.split(",")[0],
                            style: GoogleFonts.heebo(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Delivered To",
                            style: GoogleFonts.heebo(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                            ),
                          ),
                          Text(
                            "${snapshot.data!.address!.name}, ${snapshot.data!.address!.houseNo}, ${snapshot.data!.address!.block},\n${snapshot.data!.address!.locality} - ${snapshot.data!.address!.pincode}",
                            style: GoogleFonts.heebo(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Payment Method",
                            style: GoogleFonts.heebo(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                            ),
                          ),
                          Text(
                            snapshot.data!.paymentMethod!.cod!
                                ? "Cash On Delivery"
                                : "Online",
                            style: GoogleFonts.heebo(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                          Divider(
                            height: 4.h,
                            color: Colors.black26,
                          ),
                          SizedBox(
                            height: snapshot.data!.productDetails!.length *
                                (57 + 2.h),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount:
                                    snapshot.data!.productDetails!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      SizedBox(height: 1.h),
                                      orderItemTile(
                                          snapshot.data!.productDetails![index]
                                              .productTitle!,
                                          snapshot.data!.productDetails![index]
                                              .productQuantity
                                              .toString(),
                                          snapshot.data!.productDetails![index]
                                              .productPrice
                                              .toString()),
                                      SizedBox(height: 1.h),
                                    ],
                                  );
                                }),
                          ),
                          Divider(
                            height: 4.h,
                            color: Colors.black26,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Items Total",
                                style: GoogleFonts.heebo(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    color: Colors.black,
                                    size: 16.sp,
                                  ),
                                  Text(
                                    (snapshot.data!.totalPrice! + snapshot.data!.discount!)
                                        .toString(),
                                    style: GoogleFonts.heebo(
                                      color: Colors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount",
                                style: GoogleFonts.heebo(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    color: Colors.black,
                                    size: 16.sp,
                                  ),
                                  Text(
                                  snapshot.data!.discount
                                        .toString(),
                                    style: GoogleFonts.heebo(
                                      color: Colors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Price",
                                style: GoogleFonts.heebo(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    color: Constants.primaryColor,
                                    size: 16.sp,
                                  ),
                                  Text(
                                    snapshot.data!.totalPrice
                                        .toString(),
                                    style: GoogleFonts.heebo(
                                      color: Constants.primaryColor,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // orderItemTile("Budweiser", "4", "200"),
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Constants.primaryColor,
                      ),
                    );
                  }),
            )),
          ],
        ),
      ),
    );
  }

  Widget orderItemTile(String title, String itemCount, String price) {
    return Container(
      height: 55,
      width: 100.w,
      // color: Colors.red,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.heebo(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "X $itemCount items",
                  style: GoogleFonts.heebo(
                    color: Colors.black38,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.currency_rupee,
                  color: Colors.black,
                  size: 16.sp,
                ),
                Text(
                  price,
                  style: GoogleFonts.heebo(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
