import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/button/primary_filled_button.dart';
import 'package:zuluresh/common/custom_toasts.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/controllers/payment_controller.dart';
import 'package:zuluresh/models/success_order_model.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/main_application/create_order/order_success_screen.dart';
import 'package:zuluresh/views/main_application/main_home.dart';

import '../../../models/cart_data_model.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentController _paymentController = Get.put(PaymentController());
  final MainApplicationController _mainApplicationController = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    () async {
      await _mainApplicationController.getFinalPriceAfterPromo(false, 0);
      setState(() {});
    }();
  }

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
                      _mainApplicationController.showPromo.value = false;
                      _mainApplicationController.promoPay.value = 0.0;
                      _mainApplicationController.promoDiscount.value = "";
                      _mainApplicationController.promoCodeTextEditingController
                          .clear();
                      _mainApplicationController.getFinalPriceAfterPromo(
                          false, _mainApplicationController.finalPay.value);
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
                        "Payment",
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
                physics: const BouncingScrollPhysics(),
                child: Container(
                  height: 100.h - (2 * AppBar().preferredSize.height),
                  padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment",
                              style: GoogleFonts.heebo(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Obx(() {
                              return InkWell(
                                onTap: () {
                                  _paymentController.paymentMode.value = 0;
                                },
                                child: Container(
                                  height: 55,
                                  width: 100.w,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 7.5.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _paymentController
                                                    .paymentMode.value ==
                                                0
                                            ? Constants.primaryColor
                                            : Colors.grey.shade400),
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Online Payment",
                                        style: GoogleFonts.heebo(
                                            color: Constants.primaryColor,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Constants.primaryColor),
                                        ),
                                        child: _paymentController
                                                    .paymentMode.value ==
                                                0
                                            ? Center(
                                                child: Container(
                                                  height: 10,
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                    color: Constants.primaryColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                            SizedBox(height: 2.h),
                            Obx(() {
                              return InkWell(
                                onTap: () {
                                  _paymentController.paymentMode.value = 1;
                                },
                                child: Container(
                                  height: 55,
                                  width: 100.w,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 7.5.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _paymentController
                                                    .paymentMode.value ==
                                                1
                                            ? Constants.primaryColor
                                            : Colors.grey.shade400),
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Cash on Delivery",
                                        style: GoogleFonts.heebo(
                                            color: Constants.primaryColor,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Constants.primaryColor),
                                        ),
                                        // padding: EdgeInsets.all(3),
                                        child: _paymentController
                                                    .paymentMode.value ==
                                                1
                                            ? Center(
                                                child: Container(
                                                  height: 10,
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                    color: Constants.primaryColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 90.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Form(
                              key: _formKey,
                              child: Obx(() {
                                return Expanded(
                                  child: TextFormField(
                                    controller: _mainApplicationController
                                        .promoCodeTextEditingController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Invalid Promo";
                                      }
                                      return null;
                                    },
                                    readOnly: _mainApplicationController
                                        .showPromo.value,
                                    decoration: InputDecoration(
                                      hintStyle: GoogleFonts.heebo(
                                        fontSize: 16.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      hintText: "Promo Code",
                                      errorText: "",
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.primaryColor)),
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.lightTextColor)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.lightTextColor)),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 2.5.w,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(width: 2.5.w),
                            InkWell(
                              onTap: () {
                                _mainApplicationController.showPromo.value =
                                    false;
                                // _mainApplicationController
                                //     .promoCodeTextEditingController
                                //     .clear();
                                _mainApplicationController
                                    .getFinalPriceAfterPromo(
                                        false,
                                        _mainApplicationController
                                            .finalPay.value);
                                _mainApplicationController.promoPay.value = 0;
                                _mainApplicationController.promoDiscount.value =
                                    "0";
                              },
                              child: Icon(
                                Icons.delete_outline,
                                color: Constants.primaryColor,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 2.5.w),
                            InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (await _mainApplicationController
                                      .getFinalPriceAfterPromo(
                                          true,
                                          _mainApplicationController
                                              .finalPay.value)) {
                                    //
                                  } else {
                                    if (mounted) {
                                      CustomToasts.errorToast(
                                          context, "Invalid Promo Code");
                                    }
                                  }
                                }
                              },
                              child: Container(
                                width: 30.w,
                                height: 45,
                                decoration:
                                    BoxDecoration(color: Constants.primaryColor),
                                child: Center(
                                  child: Text(
                                    "Apply",
                                    style: GoogleFonts.heebo(
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            // Text(
                            //   "Promo Code",
                            //   style: GoogleFonts.heebo(
                            //     fontSize: 16.sp,
                            //     color: Colors.grey,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: const Color(0xFF941A49)),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                        // child: FutureBuilder<CartDataModel>(
                        //     future: _mainApplicationController.getCartData(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData) {
                        child: Obx(() {
                          return Column(
                            children: [
                              Text(
                                "Bill Details",
                                style: GoogleFonts.heebo(
                                  fontSize: 17.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Item Total",
                                      style: GoogleFonts.heebo(
                                        fontSize: 15.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee,
                                          color: Colors.black,
                                          size: 15.sp,
                                        ),
                                        Text(
                                          _mainApplicationController
                                              .itemTotal.value,
                                          style: GoogleFonts.heebo(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Discount",
                                      style: GoogleFonts.heebo(
                                        fontSize: 15.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee,
                                          color: Colors.black,
                                          size: 15.sp,
                                        ),
                                        Text(
                                          _mainApplicationController
                                              .discount.value,
                                          style: GoogleFonts.heebo(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              _mainApplicationController.showPromo.value
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "PromoCode Discount",
                                            style: GoogleFonts.heebo(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25.w,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.currency_rupee,
                                                color: Colors.black,
                                                size: 15.sp,
                                              ),
                                              Text(
                                                _mainApplicationController
                                                    .promoDiscount.value,
                                                style: GoogleFonts.heebo(
                                                  fontSize: 15.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Shipping Charges",
                                      style: GoogleFonts.heebo(
                                        fontSize: 15.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                    child: Row(
                                      children: [
                                        _mainApplicationController
                                                    .shipping.value ==
                                                " Free"
                                            ? const SizedBox()
                                            : Icon(
                                                Icons.currency_rupee,
                                                color: Colors.black,
                                                size: 15.sp,
                                              ),
                                        Text(
                                          _mainApplicationController
                                              .shipping.value,
                                          style: GoogleFonts.heebo(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 4.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Total",
                                      style: GoogleFonts.heebo(
                                        fontSize: 18.sp,
                                        color: Constants.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee,
                                          color: Constants.primaryColor,
                                          size: 18.sp,
                                        ),
                                        Text(
                                          _mainApplicationController
                                                      .promoPay.value ==
                                                  0.0
                                              ? _mainApplicationController
                                                  .finalPay.value
                                                  .toString()
                                              : _mainApplicationController
                                                  .promoPay.value
                                                  .toString(),
                                          style: GoogleFonts.heebo(
                                            fontSize: 17.sp,
                                            color: Constants.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                        // }
                        //   return Center(
                        //     child: CircularProgressIndicator(
                        //       color: Constants.primaryColor,
                        //     ),
                        //   );
                        // }),
                      ),
                      SizedBox(height: 2.5.h),
                      InkWell(
                        onTap: () async {
                          if (_paymentController.paymentMode.value == 0) {
                            CustomToasts.errorToast(context,
                                "Online Payments are not available now.!");
                          } else {
                            bool cod = _paymentController.paymentMode.value == 0
                                ? false
                                : true;
                            SuccessOrderModel data =
                                await _mainApplicationController.createOrder(
                                    _mainApplicationController
                                        .promoCodeTextEditingController.text.toUpperCase(),
                                    cod);
                            if (data.sId != null) {
                              _mainApplicationController
                                  .promoCodeTextEditingController
                                  .clear();
                              Get.to(() => OrderSuccessScreen(
                                    successOrderData: data,
                                  ));
                            } else {
                              if (mounted) {
                                CustomToasts.errorToast(
                                    context, "Unable To Place Order");
                              }
                            }
                          }
                        },
                        child: Center(
                          child: Obx(() {
                            return PrimaryFilledButton(
                              width: 80.w,
                              buttonText:
                                  _paymentController.paymentMode.value == 0
                                      ? "Pay"
                                      : "Place Order",
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
