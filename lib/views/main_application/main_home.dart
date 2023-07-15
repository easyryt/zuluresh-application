import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miladtech_flutter_icons/miladtech_flutter_icons.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/main_application/cart/cart_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final MainApplicationController _mainApplicationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return  _mainApplicationController.homeWidgets[_mainApplicationController.pageIdx.value];
        //   'IndexedStack(
        //   index: _mainApplicationController.pageIdx.value,
        //   children: _mainApplicationController.homeWidgets,
        // );'
      }),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(() {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              _mainApplicationController.pageIdx.value = index;
              if (index == 2) {
                CartScreen cart = CartScreen();
                setState(() {

                });
                // Timer(const Duration(seconds: 1), () {
                //   cart.getState().refresh();
                // });
              }
            },
            selectedItemColor: Constants.primaryColor,
            unselectedItemColor: Constants.lightTextColor.withOpacity(0.5),
            currentIndex: _mainApplicationController.pageIdx.value,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(AntDesign.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(AntDesign.folder1),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(AntDesign.shoppingcart),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(AntDesign.user),
                label: "Account",
              )
            ],
          );
        }),
      ),
    );
  }
}
