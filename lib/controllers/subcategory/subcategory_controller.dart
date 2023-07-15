import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:zuluresh/utils/constants.dart';

import '../../models/single_product_model.dart';
import '../../models/subcategory_model.dart';
import '../../services/global.dart';

class SubCategoryController extends GetxController {
  var selectedCategory = 0.obs;
  var subCategoryName = "all".obs;

  Future<List<SubCategoryModel>> getAllSubCategoryList(String id) async {
    Dio.Response response = await Global.apiClient
        .getData("${Constants.getAllCategoryListEndPoint}/$id", null);

    if (response.statusCode == 200) {
      final List subCategoryList = response.data["data"];
      return subCategoryList.map((e) => SubCategoryModel.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<SingleProductModel>> getSubCategoryProductList(
      String categoryName, String subCategoryName) async {
    Dio.Response response;
    if (subCategoryName == "all") {
      response = await Global.apiClient.getDataWithParams(
        Constants.getAllProductsListEndPoint,
        null,
        {
          "category": categoryName,
        },
      );
    } else {
      response = await Global.apiClient.getDataWithParams(
        Constants.getAllProductsListEndPoint,
        null,
        {
          "category": categoryName,
          "sub_category": subCategoryName,
        },
      );
    }

    if (response.statusCode == 200) {
      final List subCategoryProductList = response.data["data"];
      return subCategoryProductList
          .map((e) => SingleProductModel.fromJson(e))
          .toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
