import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miladtech_flutter_icons/miladtech_flutter_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/custom_toasts.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/models/best_seller_deals_combos_single_products.dart';
import 'package:zuluresh/models/category_model.dart';
import 'package:zuluresh/services/global.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/choose_location.dart';
import 'package:zuluresh/views/main_application/home/home_offers_screen.dart';
import 'package:zuluresh/views/main_application/home/subcategory_screen.dart';

import '../../../models/banner_model.dart';
import '../../../models/cart_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MainApplicationController _mainApplicationController = Get.find();
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    () async {
      loadCartData();
      loadAllProduct();
    }();
  }

  loadAllProduct() async {
    var data = await _mainApplicationController.getAllProductsList();
    if (data != false) {
      _mainApplicationController.allProductData = data;
    }
  }

  loadCartData() async {
    if (Global.storageServices.getString("x-auth-token") != null) {
      CartDataModel cartData = await _mainApplicationController.getCartData();
      _mainApplicationController.cartItems.clear();
      for (var item in cartData.productsData!) {
        _mainApplicationController.cartItems.add({
          "id": item.sId,
          "data": item,
          "qty": item.productQuantity,
        });
      }
      setState(() {
        _mainApplicationController.cartItems.refresh();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            Container(
              height: 130 + AppBar().preferredSize.height,
              width: 100.w,
              color: Constants.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: AppBar().preferredSize.height),
                      SizedBox(
                        width: 90.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  MaterialCommunityIcons.map_marker,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 2.w),
                                InkWell(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  onTap: () {
                                    Get.to(() => const ChooseLocation());
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Home",
                                            style: GoogleFonts.heebo(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 1.w),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                            size: 20.sp,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${Global.storageServices.getString("pin_code")}, ${Global.storageServices.getString("pin_location")}",
                                        style: GoogleFonts.heebo(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                _mainApplicationController.pageIdx.value = 2;
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Icon(
                                    MaterialCommunityIcons.cart,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                  Positioned(
                                      top: -15,
                                      right: 0,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: EdgeInsets.all(1.w),
                                        child: Text(
                                          _mainApplicationController
                                              .cartItems.length
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 90.w,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {
                        // showSearch(context: context, delegate: CustomSearch(_mainApplicationController.allProductData));
                      },
                      child: TextFormField(
                        onTap: () {
                          showSearch(
                              context: context,
                              delegate: CustomSearch(
                                  _mainApplicationController.allProductData));
                        },
                        cursorHeight: 18,
                        cursorColor: Constants.primaryColor,
                        decoration: InputDecoration(
                            icon: Icon(
                              Feather.search,
                              size: 18.sp,
                            ),
                            iconColor: Constants.lightTextColor,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Search By Product Name",
                            hintStyle: GoogleFonts.heebo(
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 2.h),
                      FutureBuilder<List<BannerModel>>(
                          future: _mainApplicationController.getAllBanners(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<String> imgUrls = [];
                              print(imgUrls);

                              for (var item in snapshot.data!) {
                                imgUrls.add(item.bannerImg!.url!);
                              }

                              return Column(children: [
                                Container(
                                  width: 90.w,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                  ),
                                  child: PageView(
                                      controller: controller,
                                      onPageChanged: (val) {
                                        _mainApplicationController
                                            .bannerIdx.value = val;
                                      },
                                      children: List.generate(
                                        imgUrls.length,
                                        (index) => Image(
                                          image: NetworkImage(imgUrls[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 90.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(imgUrls.length,
                                        (index) => buildDots(index)),
                                  ),
                                ),
                              ]);
                            }
                            return Center(
                                child: CircularProgressIndicator(
                                    color: Constants.primaryColor));
                          }),
                      SizedBox(height: 2.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shop by Categories",
                            style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            "Fresh meats and much more",
                            style: GoogleFonts.heebo(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.5.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          SizedBox(
                            height: 150,
                            width: 100.w,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    //Get to offer pages..
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 90,
                                        width: 90,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/home-offer.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        "Offers",
                                        style: GoogleFonts.heebo(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: FutureBuilder<List<CategoryModel>>(
                                    future: _mainApplicationController
                                        .getAllCategories(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 1.w),
                                            itemCount:
                                                snapshot.data!.length >= 8
                                                    ? 8
                                                    : snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.to(() =>
                                                      SubCategoryScreen(
                                                          categoryId: snapshot
                                                              .data![index]
                                                              .sId!,
                                                          categoryName: snapshot
                                                              .data![index]
                                                              .categoryName!));
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 2.w),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          height: 90,
                                                          width: 90,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .categoryImg!
                                                                      .url!),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 1.h),
                                                        Text(
                                                          snapshot.data![index]
                                                              .categoryName!,
                                                          style:
                                                              GoogleFonts.heebo(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 2.w),
                                                  ],
                                                ),
                                              );
                                            });
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Best Deals",
                                style: GoogleFonts.heebo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const HomeOfferScreen(
                                        endpoints: Constants
                                            .bestDealsProductsListEndPoint,
                                      ));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "View All",
                                      style: GoogleFonts.heebo(
                                        fontWeight: FontWeight.bold,
                                        color: Constants.primaryColor,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    SizedBox(width: 1.w),
                                    Icon(
                                      AntDesign.arrowright,
                                      color: Constants.primaryColor,
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Most popular products near you..",
                            style: GoogleFonts.heebo(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.5.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          SizedBox(
                            height: 230,
                            width: 100.w,
                            child: FutureBuilder<
                                List<BestSellerDealsCombosSingleProductModel>>(
                              future: _mainApplicationController
                                  .getBestSellerDealsCombos(
                                      Constants.bestDealsProductsListEndPoint),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return singleProductTile(snapshot);
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Best Sellers",
                                style: GoogleFonts.heebo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const HomeOfferScreen(
                                        endpoints: Constants
                                            .bestSellerProductsListEndPoint,
                                      ));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "View All",
                                      style: GoogleFonts.heebo(
                                        fontWeight: FontWeight.bold,
                                        color: Constants.primaryColor,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    SizedBox(width: 1.w),
                                    Icon(
                                      AntDesign.arrowright,
                                      color: Constants.primaryColor,
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Most popular products near you..",
                            style: GoogleFonts.heebo(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.5.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          SizedBox(
                            height: 240,
                            width: 100.w,
                            child: FutureBuilder<
                                List<BestSellerDealsCombosSingleProductModel>>(
                              future: _mainApplicationController
                                  .getBestSellerDealsCombos(
                                      Constants.bestSellerProductsListEndPoint),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return singleProductTile(snapshot);
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Combos For You",
                                style: GoogleFonts.heebo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const HomeOfferScreen(
                                        endpoints: Constants
                                            .bestCombosProductsListEndPoint,
                                      ));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "View All",
                                      style: GoogleFonts.heebo(
                                        fontWeight: FontWeight.bold,
                                        color: Constants.primaryColor,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    SizedBox(width: 1.w),
                                    Icon(
                                      AntDesign.arrowright,
                                      color: Constants.primaryColor,
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Savour the savings..",
                            style: GoogleFonts.heebo(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.5.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          SizedBox(
                            height: 230,
                            width: 100.w,
                            child: FutureBuilder<
                                List<BestSellerDealsCombosSingleProductModel>>(
                              future: _mainApplicationController
                                  .getBestSellerDealsCombos(
                                      Constants.bestCombosProductsListEndPoint),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return singleProductTile(snapshot);
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        return SizedBox(
          child: Global.storageServices.getString("x-auth-token") != null
              ? _mainApplicationController.cartItems.isNotEmpty
                  ? Container(
                      width: 90.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_mainApplicationController.cartItems.length} Items in Cart",
                            style: GoogleFonts.heebo(
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _mainApplicationController.pageIdx.value = 2;
                            },
                            child: Text(
                              "View Cart",
                              style: GoogleFonts.heebo(
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox()
              : _mainApplicationController.cartItems.isNotEmpty
                  ? Container(
                      width: 90.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Items in Cart",
                            style: GoogleFonts.heebo(
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _mainApplicationController.pageIdx.value = 2;
                            },
                            child: Text(
                              "View Cart",
                              style: GoogleFonts.heebo(
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
        );
      }),
    );
  }

  Widget buildDots(int index) {
    return Obx(() {
      return Row(
        children: [
          Container(
            height: 10,
            width: 10,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Constants.lightTextColor.withOpacity(0.1),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _mainApplicationController.bannerIdx.value == index
                    ? Constants.primaryColor
                    : Colors.transparent,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      );
    });
  }

  Widget singleProductTile(snapshot) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        itemCount: snapshot.data!.length >= 8 ? 8 : snapshot.data!.length,
        itemBuilder: (context, index) {
          String percentage = _mainApplicationController.calculatePercentage(
              snapshot.data![index].mRP!.toDouble(),
              snapshot.data![index].price!.toDouble());
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 45.w,
                    padding: EdgeInsets.symmetric(
                        horizontal: 2.5.w, vertical: 3.5.w),
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
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.w),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.5.w),
                              image: DecorationImage(
                                image: NetworkImage(
                                    snapshot.data![index].productImg![0].url!),
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
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              snapshot.data![index].mRP.toString(),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.heebo(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(width: 2.5.w),
                            Text(
                              "- $percentage%",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.heebo(
                                color: Constants.primaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                              containsItemWithId(snapshot.data![index].sId)
                                  ? InkWell(
                                      // onTap: () async {
                                      //   if (Global.storageServices
                                      //           .getString("x-auth-token") !=
                                      //       null) {
                                      //     if (await _mainApplicationController
                                      //         .deleteItemFromCart(
                                      //             snapshot.data![index].sId)) {
                                      //       _mainApplicationController
                                      //           .deleteItemById(
                                      //               snapshot.data![index].sId);
                                      //       _mainApplicationController.cartItems
                                      //           .refresh();
                                      //     } else {
                                      //       if (mounted) {
                                      //         CustomToasts.errorToast(context,
                                      //             "Unable to Delete Item from Cart..");
                                      //       }
                                      //     }
                                      //   } else {
                                      //     _mainApplicationController
                                      //         .deleteItemById(
                                      //             snapshot.data![index].sId);
                                      //   }
                                      // },
                                      child: Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1.w),
                                        border: Border.all(
                                            color: Constants.primaryColor),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (Global.storageServices
                                                      .getString(
                                                          "x-auth-token") !=
                                                  null) {
                                                if (await _mainApplicationController
                                                    .deleteItemFromCart(
                                                        snapshot
                                                            .data![index].sId!,
                                                        null)) {
                                                  loadCartData();
                                                  _mainApplicationController
                                                      .cartItems
                                                      .refresh();
                                                  setState(() {});
                                                } else {
                                                  if (mounted) {
                                                    CustomToasts.errorToast(
                                                        context,
                                                        "Unable to Decrease Quantity");
                                                  }
                                                }
                                              } else {
                                                _mainApplicationController
                                                    .decrementQtyById(snapshot
                                                        .data![index].sId!);
                                                _mainApplicationController
                                                    .cartItems
                                                    .refresh();
                                              }
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: Constants.primaryColor,
                                              size: 17.sp,
                                            ),
                                          ),
                                          Obx(() {
                                            return Text(
                                              "${getQuantityById(snapshot.data![index].sId)}",
                                              style: GoogleFonts.heebo(
                                                color: Constants.primaryColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }),
                                          InkWell(
                                            onTap: () async {
                                              if (Global.storageServices
                                                      .getString(
                                                          "x-auth-token") !=
                                                  null) {
                                                if (await _mainApplicationController
                                                    .addItemToCart(snapshot
                                                        .data![index].sId!)) {
                                                  loadCartData();
                                                  _mainApplicationController
                                                      .cartItems
                                                      .refresh();
                                                  setState(() {});
                                                } else {
                                                  if (mounted) {
                                                    CustomToasts.errorToast(
                                                        context,
                                                        "Unable to Increase Quantity");
                                                  }
                                                }
                                              } else {
                                                _mainApplicationController
                                                    .incrementQtyById(snapshot
                                                        .data![index].sId!);
                                                _mainApplicationController
                                                    .cartItems
                                                    .refresh();
                                              }
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Constants.primaryColor,
                                              size: 17.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                      // Container(
                                      //   height: 30,
                                      //   decoration: BoxDecoration(
                                      //     borderRadius:
                                      //     BorderRadius.circular(1.w),
                                      //     border: Border.all(
                                      //         color: Constants.primaryColor),
                                      //   ),
                                      //   padding: EdgeInsets.symmetric(
                                      //       horizontal: 1.5.w),
                                      //   child: Center(
                                      //     child: Icon(
                                      //       Icons.delete_outline,
                                      //       color: Constants.primaryColor,
                                      //     ),
                                      //   ),
                                      // ),
                                      )
                                  : InkWell(
                                      onTap: () async {
                                        if (Global.storageServices
                                                .getString("x-auth-token") !=
                                            null) {
                                          if (await _mainApplicationController
                                              .addItemToCart(
                                                  snapshot.data![index].sId)) {
                                            _mainApplicationController.cartItems
                                                .add({
                                              "id": snapshot.data![index].sId,
                                              "data": snapshot.data![index],
                                              "qty": 1,
                                            });
                                            _mainApplicationController.cartItems
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
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 2.w),
            ],
          );
        });
  }

  bool containsItemWithId(String id) {
    return _mainApplicationController.cartItems.any((item) => item["id"] == id);
  }

  int getQuantityById(String itemId) {
    var item = _mainApplicationController.cartItems.firstWhere(
      (item) => item["id"] == itemId,
      orElse: () => null,
    );

    return item != null ? item["qty"] : 0;
  }
}

class CustomSearch extends SearchDelegate<String> {
  final MainApplicationController _mainApplicationController = Get.find();
  List _allProducts = []; // Variable to store all products.

  CustomSearch(List products) {
    _allProducts = products; // Save the data from the API call in the variable.
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context,
            ''); // Close the search and pass an empty string as the result.
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // This method is called when the user submits a search query.
    // Filter the local data (_allProducts) based on the search query.
    final filteredProducts = _allProducts.where((product) {
      return product["title"].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        return searchTile(filteredProducts[index], index, context);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called when the user types in the search bar but hasn't submitted the query yet.
    // You can show suggestions based on the user's input if needed.
    return Container();
  }

  bool containsItemWithId(String id) {
    return _mainApplicationController.cartItems.any((item) => item["id"] == id);
  }

  int qty(String id) {
    for (var element in _mainApplicationController.cartItems) {
      if (element["id"] == id) {
        return element["qty"];
      }
    }
    // print();
    // return _mainApplicationController.cartItems.firstWhere((element) => element["_id"] == id)["qty"];
    return 0;
  }

  Widget searchTile(var product, int index, BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Container(
            width: 90.w,
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
            decoration: BoxDecoration(
              border: Border.all(color: Constants.primaryColor),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Row(
              children: [
                Container(
                  width: 110,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.w),
                    image: DecorationImage(
                      image: NetworkImage(product["productImg"][0]["url"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 2.5.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product["title"],
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.heebo(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        product["MRP"].toString(),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.heebo(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
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
                                product["price"].toString(),
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
                          containsItemWithId(product["_id"])
                              ? Container(
                                  height: 30,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1.w),
                                    border: Border.all(
                                        color: Constants.primaryColor),
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.5.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (Global.storageServices
                                                  .getString("x-auth-token") !=
                                              null) {
                                            if (await _mainApplicationController
                                                .deleteItemFromCart(
                                                    product["_id"], null)) {
                                            } else {}
                                          } else {
                                            _mainApplicationController
                                                .decrementQtyById(
                                                    product["_id"]);
                                          }
                                          _mainApplicationController.cartItems
                                              .refresh();
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          color: Constants.primaryColor,
                                          size: 17.sp,
                                        ),
                                      ),
                                      Text(
                                        qty(product["_id"]).toString(),
                                        style: GoogleFonts.heebo(
                                          color: Constants.primaryColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (Global.storageServices
                                                  .getString("x-auth-token") !=
                                              null) {
                                            if (await _mainApplicationController
                                                .addItemToCart(
                                                    product["_id"])) {
                                            } else {}
                                          }
                                          _mainApplicationController
                                              .incrementQtyById(product["_id"]);
                                          _mainApplicationController.cartItems
                                              .refresh();
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Constants.primaryColor,
                                          size: 17.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 30,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1.w),
                                    color: Constants.primaryColor,
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.5.w),
                                  child: InkWell(
                                    onTap: () async {
                                      if (Global.storageServices
                                              .getString("x-auth-token") !=
                                          null) {
                                        if (await _mainApplicationController
                                            .addItemToCart(product["_id"])) {
                                        } else {}
                                      }
                                      _mainApplicationController
                                          .incrementQtyById(product["_id"]);
                                      _mainApplicationController.cartItems
                                          .refresh();
                                    },
                                    child: Center(
                                      child: Text(
                                        "Add",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
  }
}
