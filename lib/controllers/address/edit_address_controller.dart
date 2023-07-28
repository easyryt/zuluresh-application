import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zuluresh/services/global.dart';
import 'package:zuluresh/utils/constants.dart';

class EditAddressController extends GetxController {
  var saveAsNumber = 0.obs;

  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController deliveryAddressTextController = TextEditingController();
  TextEditingController streetTextController = TextEditingController();
  TextEditingController landmarkTextController = TextEditingController();
  TextEditingController mobileNumberTextController = TextEditingController();
  TextEditingController pinCodeTextController = TextEditingController();
  TextEditingController localityTextController = TextEditingController();
  TextEditingController houseTextController = TextEditingController();
  TextEditingController blockTextController = TextEditingController();

  loadAddressData(id) async {
    Dio.Response response = await Global.apiClient
        .getData("${Constants.getSingleUserAddressEndPoint}/$id", null);

    if (response.statusCode == 200) {
      print(response.data["data"]);
      fullNameTextController.text = response.data["data"]["name"];
      mobileNumberTextController.text = response.data["data"]["phoneNo"];
      houseTextController.text = response.data["data"]["houseFlatNo"];
      blockTextController.text = response.data["data"]["blockName"];
      streetTextController.text = response.data["data"]["street"];
      landmarkTextController.text = response.data["data"]["landMark"];
      pinCodeTextController.text = response.data["data"]["pinCode"];
      localityTextController.text = response.data["data"]["locality"];
      saveAsNumber.value = response.data["data"]["saveAddressAs"] == "Home"
          ? 0
          : response.data["data"]["saveAddressAs"] == "Work"
              ? 1
              : 2;
    }
  }

  addNewAddress() async {
    Map<String, dynamic> body = {
      "name": fullNameTextController.text,
      "phoneNo": mobileNumberTextController.text,
      "houseFlatNo": houseTextController.text,
      "blockName": blockTextController.text,
      "street": streetTextController.text,
      "landMark": landmarkTextController.text,
      "pinCode": pinCodeTextController.text,
      "locality": localityTextController.text,
      "saveAddressAs": saveAsNumber.value == 0
          ? "Home"
          : saveAsNumber.value == 1
              ? "Work"
              : "Other"
    };
    Dio.Response response = await Global.apiClient
        .postData(Constants.addUserAddressEndPoint, body, null);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  updateAddress(String id) async {
    Map<String, dynamic> body = {
      "name": fullNameTextController.text,
      "phoneNo": mobileNumberTextController.text,
      "houseFlatNo": houseTextController.text,
      "blockName": blockTextController.text,
      "street": streetTextController.text,
      "landMark": landmarkTextController.text,
      "pinCode": pinCodeTextController.text,
      "locality": localityTextController.text,
      "saveAddressAs": saveAsNumber.value == 0
          ? "Home"
          : saveAsNumber.value == 1
              ? "Work"
              : "Other"
    };
    Dio.Response response = await Global.apiClient
        .putData("${Constants.updateUserAddressEndPoint}/$id", body, null);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
