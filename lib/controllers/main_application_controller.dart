import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zuluresh/controllers/payment_controller.dart';
import 'package:zuluresh/models/best_seller_deals_combos_single_products.dart';
import 'package:zuluresh/models/order_details_model.dart';
import 'package:zuluresh/models/single_address_model.dart';
import 'package:zuluresh/models/single_order_model.dart';
import 'package:zuluresh/models/single_time_slot_model.dart';
import 'package:zuluresh/models/success_order_model.dart';
import 'package:zuluresh/services/global.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/auth.dart';
import 'package:zuluresh/views/main_application/cart/cart_screen.dart';
import 'package:zuluresh/views/main_application/account/account_screen.dart';
import 'package:zuluresh/views/main_application/categories/categories_screen.dart';
import 'package:zuluresh/views/main_application/home/home.dart';
import 'package:dio/dio.dart' as Dio;
import '../models/banner_model.dart';
import '../models/cart_data_model.dart';
import '../models/category_model.dart';
import '../views/main_application/address/choose_delivery.dart';

class MainApplicationController extends GetxController {
  var pageIdx = 0.obs;
  var bannerIdx = 0.obs;

  var showCart = 0.obs;

  var selectedAddressData = SingleAddressModel().obs;

  List<Widget> homeWidgets = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];

  String calculatePercentage(double mrp, double price) {
    double percentage;
    percentage = ((mrp - price) / mrp) * 100;

    return percentage.toInt().toString();
  }

  Future<List<BannerModel>> getAllBanners() async {
    Dio.Response response = await Global.apiClient
        .getData(Constants.getAllBannerListEndPoint, null);

    if (response.statusCode == 200) {
      final List categoryList = response.data["data"];
      return categoryList.map((e) => BannerModel.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    Dio.Response response =
        await Global.apiClient.getData("admin/getAllCategory", null);

    if (response.statusCode == 200) {
      final List categoryList = response.data["data"];
      return categoryList.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<BestSellerDealsCombosSingleProductModel>>
      getBestSellerDealsCombos(String route) async {
    Dio.Response response = await Global.apiClient.getData(route, null);

    if (response.statusCode == 200) {
      final List bestSellerDealsCombosSingleProductList = response.data["data"];
      return bestSellerDealsCombosSingleProductList
          .map((e) => BestSellerDealsCombosSingleProductModel.fromJson(e))
          .toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  // Cart Screen Related
  checkAuthentication() {
    if (Global.storageServices.getString("x-auth-token") == null) {
      Get.to(() => const AuthScreen());
    } else {
      Get.to(() => const ChooseDeliveryScreen());
    }
  }

  var homeQty = 0.obs;
  List allProductData = [];

  Future getAllProductsList() async {
    Dio.Response response = await Global.apiClient
        .getData(Constants.getAllProductsListEndPoint, null);
    if (response.statusCode == 200) {
      return response.data["data"];
    }

    return false;
  }

  Future<CartDataModel> getCartData() async {
    Dio.Response response =
        await Global.apiClient.getData(Constants.getCartDataEndPoint, null);

    if (response.statusCode == 200) {
      var cartData = response.data["data"];
      return CartDataModel.fromJson(cartData);
      // return bestSellerDealsCombosSingleProductList
      //     .map((e) => BestSellerDealsCombosSingleProductModel.fromJson(e))
      //     .toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  var itemTotal = "".obs;
  var discount = "".obs;
  var shipping = "".obs;
  var finalPay = 0.obs;
  var promoPay = 0.0.obs;
  var promoDiscount = "".obs;
  var showPromo = false.obs;

  final TextEditingController promoCodeTextEditingController =
      TextEditingController();

  Future<bool> getFinalPriceAfterPromo(bool getPromoData, int price) async {
    CartDataModel cartData = await getCartData();

    itemTotal.value = (cartData.totalPrice! + cartData.discount!).toString();
    discount.value = cartData.discount.toString();
    finalPay.value = cartData.totalPrice!;
    shipping.value =
        cartData.shipping == 0 ? " Free" : cartData.shipping.toString();

    if (getPromoData) {
      Dio.Response response = await Global.apiClient.postData(
        Constants.getPromoDiscountEndPoint,
        {
          "totalPrice": price,
          "promoCode": promoCodeTextEditingController.text.toUpperCase()
        },
        null,
      );

      if (response.statusCode == 200) {
        showPromo.value = true;
        promoPay.value = response.data["data"].toDouble();
        promoDiscount.value =
            ((finalPay.value).toDouble() - promoPay.value).toString();
        return true;
      } else {
        return false;
      }
    }

    return true;
  }

  Future<SuccessOrderModel> createOrder(String promoCode, bool cod) async {
    Map<String, dynamic> body;
    if (cod) {
      body = {
        "deliverySlot": {
          "day": selectedDeliveryTime.day,
          "startTime": selectedDeliveryTime.startTime,
          "endTime": selectedDeliveryTime.endTime
        },
        "promoCode": promoCode,
        "paymentMethod": {"cod": true}
      };
    } else {
      body = {
        "deliverySlot": {
          "day": selectedDeliveryTime.day,
          "startTime": selectedDeliveryTime.startTime,
          "endTime": selectedDeliveryTime.endTime
        },
        "promoCode": promoCode,
        // "paymentMethod": {"cod": true}
      };
    }
    Dio.Response response = await Global.apiClient.postData(
        "${Constants.createOrderEndPoint}/${selectedAddressId.value}",
        body,
        null);
    if (response.statusCode == 201) {
      var successOrderData = response.data["data"];
      return SuccessOrderModel.fromJson(successOrderData);
    } else {
      return SuccessOrderModel();
      // throw Exception(response.statusMessage);
    }
  }

  addItemToCart(String id) async {
    Dio.Response response = await Global.apiClient
        .postData(Constants.addProductToCartEndPoint, {"productId": id}, null);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  deleteItemFromCart(String id, String? all) async {
    Dio.Response response = await Global.apiClient.putData(
        Constants.updateProductToCartEndPoint,
        {
          "productId": id,
          "removeProduct": all ?? "1",
        },
        null);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  var cartItems = [].obs;

  void incrementQtyById(String id) {
    for (var item in cartItems) {
      if (item["id"] == id) {
        item['qty']++;
        break;
      }
    }
  }

  void decrementQtyById(String id) {
    for (var item in cartItems) {
      if (item["id"] == id) {
        if (item["qty"] > 1) {
          item['qty']--;
        } else {
          cartItems.remove(item);
        }
        break;
      }
    }
  }

  void deleteItemById(String id) {
    cartItems.removeWhere((element) => element["id"] == id);
  }

  String getQuantityById(String id) {
    for (var item in cartItems) {
      if (item['id'] == id) {
        return item['qty'].toString();
      }
    }
    return "0";
  }

  List getAllProductsIdWithQty() {
    final List productList = cartItems
        .map((item) =>
            {'productId': item['id'], 'quantity': item['qty'].toString()})
        .toList();

    return productList;
  }

  getSumOfProducts() {
    var totalMrp = cartItems.fold(
        0, (sum, item) => sum + (item['data'].price * item['qty']) as int);

    return totalMrp;
  }

  getDiscountSumOfProducts() {
    var totalDiscount = cartItems.fold(
        0, (sum, item) => sum + (item['data'].mRP * item['qty']) as int);

    return totalDiscount - getSumOfProducts();
  }

// Address Related
  Future<List<SingleAddressModel>> getUserAllAddresses() async {
    Dio.Response response = await Global.apiClient
        .getData(Constants.userAllAddressesEndPoint, null);

    if (response.statusCode == 200) {
      final List allAddressesList = response.data["data"];
      return allAddressesList
          .map((e) => SingleAddressModel.fromJson(e))
          .toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  var selectedAddress = 0.obs;
  var selectedAddressId = "".obs;

  var selectedDeliveryDate = 0.obs;
  var selectedDeliveryTime = SingleTimeSlotModel();

  deleteAddress(String id) async {
    Dio.Response response = await Global.apiClient
        .deleteData("${Constants.deleteUserAddressEndPoint}/$id", null);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<SingleTimeSlotModel>> getAllTimeSlots() async {
    Dio.Response response = await Global.apiClient
        .getData(Constants.getAvailableTimeSlotsEndPoint, null);

    if (response.statusCode == 200) {
      final List allTimeSlotsList = response.data["timeSlots"];
      return allTimeSlotsList
          .map((e) => SingleTimeSlotModel.fromJson(e))
          .toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  List<SingleTimeSlotModel> todayTimeSlots = <SingleTimeSlotModel>[].obs;
  List<SingleTimeSlotModel> tomorrowTimeSlots = <SingleTimeSlotModel>[].obs;
  List<SingleTimeSlotModel> nextDayTimeSlots = <SingleTimeSlotModel>[].obs;

  refineDataListByDate(List<SingleTimeSlotModel> allTimeSlots) {
    todayTimeSlots.clear();
    tomorrowTimeSlots.clear();
    nextDayTimeSlots.clear();

    final DateTime dateTime = DateTime.now();
    final int today = dateTime.day;
    final int tomorrow = dateTime.add(const Duration(days: 1)).day;
    final int dayAfterTomorrow = dateTime.add(const Duration(days: 2)).day;

    for (var item in allTimeSlots) {
      final String itemDay = item.day!;
      final String responseDate = itemDay.split('(')[1].split(' ')[0];

      if (int.parse(responseDate) == today) {
        todayTimeSlots.add(item);
      } else if (int.parse(responseDate) == tomorrow) {
        tomorrowTimeSlots.add(item);
      } else if (int.parse(responseDate) == dayAfterTomorrow) {
        nextDayTimeSlots.add(item);
      }
    }
  }

  // Order Related
  Future<List<SingleOrderModel>> getAllOrdersList() async {
    Dio.Response response =
        await Global.apiClient.getData(Constants.getAllOrdersEndPoint, null);

    if (response.statusCode == 200) {
      final List allOrdersList = response.data["data"];
      return allOrdersList.map((e) => SingleOrderModel.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<OrderDetailsModel> getOderDetails(String orderId) async {
    Dio.Response response = await Global.apiClient
        .getData("${Constants.getOrderDetailsEndPoint}/$orderId", null);
    if (response.statusCode == 200) {
      var orderDetailsData = response.data["orderData"];
      return OrderDetailsModel.fromJson(orderDetailsData);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  DateTime getTimeFromDateTimeStamp(String timeStamp) {
    return DateTime.parse(timeStamp);
  }
}
