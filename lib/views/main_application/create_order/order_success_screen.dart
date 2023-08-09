import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/button/primary_filled_button.dart';
import 'package:zuluresh/models/success_order_model.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/main_application/create_order/order_detail_screen.dart';
import 'package:zuluresh/views/main_application/main_home.dart';

class OrderSuccessScreen extends StatefulWidget {
  final SuccessOrderModel successOrderData;

  const OrderSuccessScreen({
    super.key,
    required this.successOrderData,
  });

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  Container(
                    height: 25.h,
                    width: 60.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/order_success.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Order Successful",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.5.w),
                      border: Border.all(
                          color: Constants.lightTextColor.withOpacity(0.5)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),
                        Center(
                          child: Text(
                            "Order Details",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        Divider(height: 4.h, indent: 5.w, endIndent: 5.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.5.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Total Order",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "\$ 900",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Total Order",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "\$ 900",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 4.h, indent: 5.w, endIndent: 5.w),
                        InkWell(
                          onTap: () {
                            Get.to(() => OrderDetailScreen(
                                  orderSuccess: true,
                                  successOrderData: widget.successOrderData,
                                ));
                          },
                          child: Center(
                            child: Text(
                              "View Order Details",
                              style: TextStyle(
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  InkWell(
                    onTap: () {
                      Get.offAll(() => const MainHomeScreen());
                    },
                    child: PrimaryFilledButton(
                      width: 90.w,
                      buttonText: "Done",
                    ),
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
