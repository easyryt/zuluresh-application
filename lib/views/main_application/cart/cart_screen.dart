import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/button/primary_filled_button.dart';
import 'package:zuluresh/common/custom_toasts.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/models/cart_data_model.dart';
import 'package:zuluresh/services/global.dart';
import 'package:zuluresh/utils/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final MainApplicationController _mainApplicationController = Get.find();

  @override
  void initState() {
    super.initState();
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
                  // SizedBox(width: 5.w),
                  // Icon(
                  //   Icons.arrow_back_ios_new_sharp,
                  //   size: 19.sp,
                  //   color: const Color(0xFF941A49),
                  // ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Cart",
                        style: GoogleFonts.heebo(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: const Color(0xFF941A49),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 5.w),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // Product Expanded List
                  Expanded(
                    child: Global.storageServices.getString("x-auth-token") !=
                            null
                        ? FutureBuilder<CartDataModel>(
                            future: _mainApplicationController.getCartData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.productsData!.isNotEmpty) {
                                  return ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 5.w),
                                      itemCount:
                                          snapshot.data?.productsData!.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Container(
                                              width: 90.w,
                                              height: 120,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3.w,
                                                  vertical: 3.w),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Constants.primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(2.w),
                                              ),
                                              child: Row(
                                                children: [
                                                  // Product Image
                                                  Container(
                                                    width: 110,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.w),
                                                      image:
                                                          const DecorationImage(
                                                        image: NetworkImage(
                                                            "https://res.cloudinary.com/decjoyrmj/image/upload/v1688235558/products/yrrvx27krfhkgbzfbzcv.webp"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 2.5.w),
                                                  // Details
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .productsData![
                                                                  index]
                                                              .title!,
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style:
                                                              GoogleFonts.heebo(
                                                            color: Colors.black,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .productsData![
                                                                  index].productMrp.toString(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style:
                                                              GoogleFonts.heebo(
                                                                decoration: TextDecoration.lineThrough,
                                                            color: Colors.black,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                        SizedBox(height: 1.h),
                                                        //Price and Quantity Row
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            // Price
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .currency_rupee,
                                                                  color: Constants
                                                                      .primaryColor,
                                                                  size: 16.sp,
                                                                ),
                                                                Text(
                                                                  snapshot
                                                                      .data!
                                                                      .productsData![
                                                                          index]
                                                                      .price
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                  style:
                                                                      GoogleFonts
                                                                          .heebo(
                                                                    color: Constants
                                                                        .primaryColor,
                                                                    fontSize:
                                                                        16.5.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            // Increment Decrement Button
                                                            Container(
                                                              height: 30,
                                                              width: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            1.w),
                                                                border: Border.all(
                                                                    color: Constants
                                                                        .primaryColor),
                                                              ),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          2.5.w),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      if (await _mainApplicationController.addItemToCart(snapshot
                                                                          .data!
                                                                          .productsData![
                                                                              index]
                                                                          .sId!)) {
                                                                        setState(
                                                                            () {});
                                                                      } else {
                                                                        if (mounted) {
                                                                          CustomToasts.errorToast(
                                                                              context,
                                                                              "Unable to Increase Quantity");
                                                                        }
                                                                      }
                                                                      // _mainApplicationController.incrementQtyById(
                                                                      //     _mainApplicationController.cartItems[index]
                                                                      //         [
                                                                      //         "id"]);
                                                                      // _mainApplicationController
                                                                      //     .cartItems
                                                                      //     .refresh();
                                                                    },
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Constants
                                                                          .primaryColor,
                                                                      size:
                                                                          17.sp,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    snapshot
                                                                        .data!
                                                                        .productsData![
                                                                            index]
                                                                        .productQuantity
                                                                        .toString(),
                                                                    style: GoogleFonts
                                                                        .heebo(
                                                                      color: Constants
                                                                          .primaryColor,
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      if (await _mainApplicationController.deleteItemFromCart(snapshot
                                                                          .data!
                                                                          .productsData![
                                                                              index]
                                                                          .sId!)) {
                                                                        setState(
                                                                            () {});
                                                                      } else {
                                                                        if (mounted) {
                                                                          CustomToasts.errorToast(
                                                                              context,
                                                                              "Unable to Decrease Quantity");
                                                                        }
                                                                      }
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Constants
                                                                          .primaryColor,
                                                                      size:
                                                                          17.sp,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 1.5.h),
                                          ],
                                        );
                                      });
                                } else {
                                  return Center(
                                    child: Text(
                                      "No any Item in Cart..",
                                      style: GoogleFonts.heebo(
                                        color: Constants.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17.sp,
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
                            })
                        : Obx(() {
                          if(_mainApplicationController.cartItems.isEmpty){
                            return Center(
                              child: Text(
                                "No any Item in Cart..",
                                style: GoogleFonts.heebo(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.sp,
                                ),
                              ),
                            );
                          }
                            return ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 5.w),
                                itemCount:
                                    _mainApplicationController.cartItems.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        width: 90.w,
                                        height: 120,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.w, vertical: 3.w),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Constants.primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(2.w),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 110,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2.w),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      _mainApplicationController
                                                          .cartItems[index]
                                                              ["data"]
                                                          .productImg![0]
                                                          .url!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2.5.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    _mainApplicationController
                                                        .cartItems[index]
                                                            ["data"]
                                                        .title,
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: GoogleFonts.heebo(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    _mainApplicationController
                                                        .cartItems[index]
                                                            ["data"]
                                                        .mRP
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: GoogleFonts.heebo(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.black,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .currency_rupee,
                                                            color: Constants
                                                                .primaryColor,
                                                            size: 16.sp,
                                                          ),
                                                          Text(
                                                            _mainApplicationController
                                                                .cartItems[
                                                                    index]
                                                                    ["data"]
                                                                .price
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: GoogleFonts
                                                                .heebo(
                                                              color: Constants
                                                                  .primaryColor,
                                                              fontSize: 16.5.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        height: 30,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      1.w),
                                                          border: Border.all(
                                                              color: Constants
                                                                  .primaryColor),
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    2.5.w),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                _mainApplicationController
                                                                    .incrementQtyById(
                                                                        _mainApplicationController
                                                                                .cartItems[index]
                                                                            [
                                                                            "id"]);
                                                                _mainApplicationController
                                                                    .cartItems
                                                                    .refresh();
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Constants
                                                                    .primaryColor,
                                                                size: 17.sp,
                                                              ),
                                                            ),
                                                            Text(
                                                              _mainApplicationController
                                                                  .cartItems[
                                                                      index]
                                                                      ["qty"]
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .heebo(
                                                                color: Constants
                                                                    .primaryColor,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                _mainApplicationController
                                                                    .decrementQtyById(
                                                                        _mainApplicationController
                                                                                .cartItems[index]
                                                                            [
                                                                            "id"]);
                                                                _mainApplicationController
                                                                    .cartItems
                                                                    .refresh();
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: Constants
                                                                    .primaryColor,
                                                                size: 17.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 1.5.h),
                                    ],
                                  );
                                });
                          }),
                  ),
                  SizedBox(height: 1.5.h),
                  Global.storageServices.getString("x-auth-token") != null
                      ? FutureBuilder<CartDataModel>(
                          future: _mainApplicationController.getCartData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.productsData!.isNotEmpty) {
                                return Container(
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(
                                        color: const Color(0xFF941A49)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 1.h),
                                  child: Column(
                                    children: [
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
                                            width: 20.w,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.currency_rupee,
                                                  color: Colors.black,
                                                  size: 15.sp,
                                                ),
                                                Text(
                                                  (snapshot.data!.totalPrice! + snapshot.data!.discount!).toString(),
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
                                      SizedBox(height: 1.h),
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
                                            width: 20.w,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.currency_rupee,
                                                  color: Colors.black,
                                                  size: 15.sp,
                                                ),
                                                Text(
                                                  snapshot.data!.discount.toString(),
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
                                      // Row(
                                      //   children: [
                                      //     Expanded(
                                      //       child: Text(
                                      //         "Charge Delivery",
                                      //         style: GoogleFonts.heebo(
                                      //           fontSize: 15.sp,
                                      //           color: Colors.black,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     SizedBox(
                                      //       width: 20.w,
                                      //       child: Row(
                                      //         children: [
                                      //           Icon(
                                      //             Icons.currency_rupee,
                                      //             color: Colors.black,
                                      //             size: 15.sp,
                                      //           ),
                                      //           Text(
                                      //             "16",
                                      //             style: GoogleFonts.heebo(
                                      //               fontSize: 15.sp,
                                      //               color: Colors.black,
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Divider(
                                        height: 2.h,
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
                                            width: 20.w,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.currency_rupee,
                                                  color: Constants.primaryColor,
                                                  size: 18.sp,
                                                ),
                                                Text(
                                                  snapshot.data!.totalPrice.toString(),
                                                  style: GoogleFonts.heebo(
                                                    fontSize: 18.sp,
                                                    color:
                                                        Constants.primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Constants.primaryColor,
                                ),
                              );
                            }
                          })
                      : _mainApplicationController.cartItems.isNotEmpty ? Container(
                          width: 90.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: const Color(0xFF941A49)),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: Column(
                            children: [
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
                                    width: 20.w,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee,
                                          color: Colors.black,
                                          size: 15.sp,
                                        ),
                                        Text(
                                          (_mainApplicationController.getSumOfProducts() + _mainApplicationController.getDiscountSumOfProducts()).toString(),
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
                              SizedBox(height: 1.h),
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
                                    width: 20.w,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee,
                                          color: Colors.black,
                                          size: 15.sp,
                                        ),
                                        Text(
                                          _mainApplicationController.getDiscountSumOfProducts().toString(),
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
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: Text(
                              //         "Charge Delivery",
                              //         style: GoogleFonts.heebo(
                              //           fontSize: 15.sp,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 20.w,
                              //       child: Row(
                              //         children: [
                              //           Icon(
                              //             Icons.currency_rupee,
                              //             color: Colors.black,
                              //             size: 15.sp,
                              //           ),
                              //           Text(
                              //             "16",
                              //             style: GoogleFonts.heebo(
                              //               fontSize: 15.sp,
                              //               color: Colors.black,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Divider(
                                height: 2.h,
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
                                    width: 20.w,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee,
                                          color: Constants.primaryColor,
                                          size: 18.sp,
                                        ),
                                        Text(
                                          _mainApplicationController.getSumOfProducts().toString(),
                                          style: GoogleFonts.heebo(
                                            fontSize: 18.sp,
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
                          ),
                        ) : const SizedBox(),
                  SizedBox(height: 1.5.h),
                  InkWell(
                    onTap: () {
                      if(_mainApplicationController.cartItems.isNotEmpty){
                      _mainApplicationController.checkAuthentication();
                      }
                      else{
                        if(mounted)
                          {
                            CustomToasts.errorToast(context, "Add Some Items to Cart..");
                          }
                      }
                    },
                    child: PrimaryFilledButton(
                      width: 90.w,
                      buttonText: "Add Address to Proceed",
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
