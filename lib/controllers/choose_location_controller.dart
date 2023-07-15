import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:zuluresh/common/custom_toasts.dart';
import 'package:zuluresh/services/global.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/main_application/main_home.dart';

class ChooseLocationController extends GetxController {
  Position? currentPosition;
  bool servicePosition = false;
  late LocationPermission permission;
  var pinCode = "".obs;
  var pinLocation = "".obs;
  var raiseError = false;

  Future<Position> getCurrentPosition() async {
    servicePosition = await Geolocator.isLocationServiceEnabled();
    // if(!servicePosition){
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // }
    return await Geolocator.getCurrentPosition();
  }

  getAddressFromCoordinates() async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);

      Placemark place = placeMarks[0];
      pinCode.value = place.postalCode!;
      pinLocation.value = place.name!;
    } catch (e) {
      print(e.toString());
    }
  }

  checkLocationServiceable(
      BuildContext context, bool text, String pincode) async {
    if (text != true) {
      currentPosition = await getCurrentPosition();
      await getAddressFromCoordinates();
    }
    var body;
    if (text) {
      body = {
        "pincode": pincode,
      };
    } else {
      body = {
        "pincode": pinCode.value,
      };
    }
    Dio.Response response = await Global.apiClient.postData(
      Constants.checkLocationServiceableEndPoint,
      body,
      null,
    );

    if (response.statusCode == 201) {
      if (text) {
        Global.storageServices.setString("pin_code", pincode);
      } else {
        Global.storageServices.setString("pin_code", pinCode.value);
      }
      Global.storageServices.setString("pin_location", pinLocation.value);
      return true;
    } else {
      return false;
    }
  }
}
