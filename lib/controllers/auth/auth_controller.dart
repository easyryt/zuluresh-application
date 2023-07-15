import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/services/global.dart';
import 'package:zuluresh/utils/constants.dart';

class AuthController extends GetxController {
  var sendingOtp = false.obs;
  var sentOtp = false.obs;
  var verifyingOtp = false.obs;
  var verifyErrorOtp = false.obs;

  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController otpTextEditingController = TextEditingController();

  MainApplicationController mainApplicationController = Get.find();

  getOtp() async {
    sendingOtp.value = true;
    Dio.Response response = await Global.apiClient.postData(
      Constants.generateOtpEndPoint,
      {
        "number": phoneTextEditingController.text,
      },
      null,
    );
    sendingOtp.value = false;
    if (response.statusCode == 200) {
      otpTextEditingController.text = response.data["otp"];
      sentOtp.value = true;
      return true;
    } else {
      return false;
    }
  }

  verifyOtp() async {
    verifyingOtp.value = true;
    Map<String, dynamic> body;
    if (mainApplicationController.cartItems.isEmpty) {
      body = {
        "number": phoneTextEditingController.text,
        "otp": otpTextEditingController.text,
        "items": [],
        "totalPrice": null,
        "totalItems": null
      };
    } else {
      body = {
        "number": phoneTextEditingController.text,
        "otp": otpTextEditingController.text,
        "items": mainApplicationController.getAllProductsIdWithQty(),
        "totalPrice": mainApplicationController.getSumOfProducts(),
        "totalItems": mainApplicationController.cartItems.length
      };
    }
    Dio.Response response = await Global.apiClient.postData(
      Constants.verifyOtpEndPoint,
      body,
      null,
    );
    verifyingOtp.value = false;
    if (response.statusCode == 200) {
      return response.data["token"];
    } else {
      verifyErrorOtp.value = true;
      return false;
    }
  }
}
