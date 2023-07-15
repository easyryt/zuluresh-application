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
      "saveAddressAs": saveAsNumber.value == 0 ? "Home" : saveAsNumber.value ==
          1 ? "Work" : "Other"
    };
    Dio.Response response = await Global.apiClient
        .postData(Constants.addUserAddressEndPoint, body, null);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
