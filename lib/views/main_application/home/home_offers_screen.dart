import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/views/main_application/main_home.dart';

import '../../../common/custom_toasts.dart';
import '../../../models/best_seller_deals_combos_single_products.dart';
import '../../../services/global.dart';
import '../../../utils/constants.dart';

class HomeOfferScreen extends StatefulWidget {
  final String endpoints;

  const HomeOfferScreen({
    super.key,
    required this.endpoints,
  });

  @override
  State<HomeOfferScreen> createState() => _HomeOfferScreenState();
}

class _HomeOfferScreenState extends State<HomeOfferScreen> {
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
                    onTap: (){
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
                        widget.endpoints == Constants.bestCombosProductsListEndPoint ? "Best Combos" : widget.endpoints == Constants.bestSellerProductsListEndPoint ? "Best Sellers" : "Best Deals",
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
            Expanded(child: listData()),
          ],
        ),
      ),
      floatingActionButton: CustomToasts.viewCartBanner(),
    );
  }

  Widget listData() {
    return FutureBuilder<List<BestSellerDealsCombosSingleProductModel>>(
      future: _mainApplicationController.getBestSellerDealsCombos(widget.endpoints),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 2.5.h),
                    Container(
                      width: 100.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.5.w, vertical: 2.5.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1.5.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: const Offset(0, 0),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.w),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.5.w),
                                image: DecorationImage(
                                  image: NetworkImage(snapshot
                                      .data![index].productImg![0].url!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            snapshot.data![index].title!,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.heebo(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            snapshot.data![index].mRP.toString(),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.heebo(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      color: Constants.primaryColor,
                                      size: 16.sp,
                                    ),
                                    Text(
                                      snapshot.data![index].price!.toString(),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.heebo(
                                        color: Constants.primaryColor,
                                        fontSize: 16.5.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                containsItemWithId(snapshot.data![index].sId!)
                                    ? InkWell(
                                        onTap: () async {
                                          if (Global.storageServices
                                                  .getString("x-auth-token") !=
                                              null) {
                                            if (await _mainApplicationController
                                                .deleteItemFromCart(snapshot
                                                    .data![index].sId!)) {
                                              _mainApplicationController
                                                  .deleteItemById(snapshot
                                                      .data![index].sId!);
                                              _mainApplicationController
                                                  .cartItems
                                                  .refresh();
                                            } else {
                                              if (mounted) {
                                                CustomToasts.errorToast(context,
                                                    "Unable to Delete Item from Cart..");
                                              }
                                            }
                                          } else {
                                            _mainApplicationController
                                                .deleteItemById(
                                                    snapshot.data![index].sId!);
                                          }
                                        },
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1.w),
                                            border: Border.all(
                                                color: Constants.primaryColor),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.5.w),
                                          child: Center(
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: Constants.primaryColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () async {
                                          if (Global.storageServices
                                                  .getString("x-auth-token") !=
                                              null) {
                                            if (await _mainApplicationController
                                                .addItemToCart(snapshot
                                                    .data![index].sId!)) {
                                              _mainApplicationController
                                                  .cartItems
                                                  .add({
                                                "id": snapshot.data![index].sId,
                                                "data": snapshot.data![index],
                                                "qty": 1,
                                              });
                                              _mainApplicationController
                                                  .cartItems
                                                  .refresh();
                                            } else {
                                              if (mounted) {
                                                CustomToasts.errorToast(context,
                                                    "Unable to add Item from Cart..");
                                              }
                                            }
                                          } else {
                                            _mainApplicationController.cartItems
                                                .add({
                                              "id": snapshot.data![index].sId,
                                              "data": snapshot.data![index],
                                              "qty": 1,
                                            });
                                            _mainApplicationController.cartItems
                                                .refresh();
                                          }
                                        },
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1.w),
                                            border: Border.all(
                                                color: Constants.primaryColor),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: Center(
                                            child: Text(
                                              "Add",
                                              style: GoogleFonts.heebo(
                                                color: Constants.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                // Container(
                                //   height: 30,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(1.w),
                                //     border:
                                //         Border.all(color: Constants.primaryColor),
                                //   ),
                                //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                                //   child: Center(
                                //     child: Text(
                                //       "Add",
                                //       style: GoogleFonts.heebo(
                                //         color: Constants.primaryColor,
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                );
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  bool containsItemWithId(String id) {
    return _mainApplicationController.cartItems.any((item) => item["id"] == id);
  }
}
