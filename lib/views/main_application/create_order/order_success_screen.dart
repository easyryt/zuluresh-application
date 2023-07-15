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
            SizedBox(
              height: AppBar().preferredSize.height,
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.offAll(() => const MainHomeScreen());
                    },
                    child: Icon(
                      Icons.close,
                      color: Constants.primaryColor,
                      size: 22.sp,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40.h,
                    width: 80.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/order_success.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      Get.to(() => OrderDetailScreen(
                            orderSuccess: true,
                            successOrderData: widget.successOrderData,
                          ));
                    },
                    child: PrimaryFilledButton(
                      width: 90.w,
                      buttonText: "Order Details",
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
